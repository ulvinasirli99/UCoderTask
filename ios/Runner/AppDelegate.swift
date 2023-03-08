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
   var player: AVAudioPlayer?
   let playerHandler = PlayerHandler()
   let sound = Bundle.main.path(forResource: "YOUR_SOUND_FILE", ofType: "mp3")!
   let url = URL(fileURLWithPath: sound)

   batteryChannel.setMethodCallHandler({
           (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in

             guard call.method == "getBatteryLevel" else {
               result(FlutterMethodNotImplemented)
               return
             }
             self.receiveBatteryLevel(result: result)
         })

         soundPlayerChannel.setMethodCallHandler(playerHandler.handle)

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

      func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
          switch call.method {
          case "playSound":
              playSound()
              result(nil)
          case: "stopSound":
              stopSound()
              result(nil)
          default:
              result(FlutterMethodNotImplemented)
          }
      }

      func playSound() {
          audioPlayer?.play()
      }

      func stopSound() {
          audioPlayer?.stop()
      }

}
