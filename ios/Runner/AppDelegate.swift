import UIKit
import Flutter
import AVFoundation

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
      
      
   let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
         let batteryChannel = FlutterMethodChannel(name: "uCoders/battery",binaryMessenger: controller.binaryMessenger)
         let soundPlayerChannel = FlutterMethodChannel(name: "uCoders/soundPlayer",binaryMessenger: controller.binaryMessenger)
//      guard let url = Bundle.main.url(forResource: "ucoder", withExtension: "mp3") else { return
//
//      }
   var audioPlayer: AVAudioPlayer?
 
   batteryChannel.setMethodCallHandler({
           (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in

             guard call.method == "getBatteryLevel" else {
               result(FlutterMethodNotImplemented)
               return
             }
             self.receiveBatteryLevel(result: result)
         })
      
      soundPlayerChannel.setMethodCallHandler({
          (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
          if let file = Bundle.main.path(forResource: "u_coder", ofType: "mp3"){
            
              
              do{
                  audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: file))
              }catch{
                  print("Error...")
              }
              if call.method == "playSound" {
                  audioPlayer?.play()
                  result(nil)
              }else if call.method == "stopSound"{
                  audioPlayer?.stop()
                  result(nil)
              }
              else {
                  result(FlutterMethodNotImplemented)
                  return
              }}
          })
      

      GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

  private func receiveBatteryLevel(result: FlutterResult) {
        let device = UIDevice.current
        device.isBatteryMonitoringEnabled = true
        if device.batteryState == UIDevice.BatteryState.unknown {
          result(FlutterError(code: "UNAVAILABLE",
                              message: "Battery level not available.",
                              details: nil))
        } else {
          result(Int(device.batteryLevel * 100))
        }
      }


}
