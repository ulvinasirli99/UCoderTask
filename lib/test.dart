// package com.example.ucoders_task
//
// import io.flutter.embedding.android.FlutterActivity
// import io.flutter.embedding.engine.FlutterEngine
// import io.flutter.plugin.common.MethodChannel
// import androidx.annotation.NonNull
// import android.content.Context
// import android.content.ContextWrapper
// import android.content.Intent
// import android.content.IntentFilter
// import android.media.AudioAttributes
// import android.media.AudioManager
// import android.media.MediaPlayer
// import android.os.BatteryManager
// import android.os.Build.VERSION
// import android.os.Build.VERSION_CODES
// import android.widget.Toast
// import java.io.IOException
//
// class MainActivity : FlutterActivity() {
//   private val CHANNEL = "uCoders/battery"
//   private val CHANNEL1 = "uCoders/soundPlayer"
//   private var mediaPlayer: MediaPlayer? = null
//
//
//   override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
//   super.configureFlutterEngine(flutterEngine)
//
//   MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler {
//   // This method is invoked on the main thread.
//   call, result ->
//   if (call.method == "getBatteryLevel") {
//   val batteryLevel = getBatteryLevel()
//
//   if (batteryLevel != -1) {
//   result.success(batteryLevel)
//   } else {
//   result.error("UNAVAILABLE", "Battery level not available.", null)
//   }
//   } else {
//   result.notImplemented()
//   }
//   }
//
//   MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL1).setMethodCallHandler {
//   // This method is invoked on the main thread.
//   call, result ->
//   if (call.method == "playSound") {
//   mediaPlayer = MediaPlayer.create(this, R.raw.ucoder)
//   mediaPlayer?.start()
//   result.success(null)
//   } else if (call.method == "stopSound") {
//   mediaPlayer?.stop()
//   mediaPlayer?.release()
//   mediaPlayer = null
//   result.success(null)
//   } else {
//   result.notImplemented()
//   }
//   }
//
//
//   }
//
//   private fun getBatteryLevel(): Int {
//   val batteryLevel: Int
//   if (VERSION.SDK_INT >= VERSION_CODES.LOLLIPOP) {
//   val batteryManager = getSystemService(Context.BATTERY_SERVICE) as BatteryManager
//   batteryLevel = batteryManager.getIntProperty(BatteryManager.BATTERY_PROPERTY_CAPACITY)
//   } else {
//   val intent = ContextWrapper(applicationContext).registerReceiver(
//   null,
//   IntentFilter(Intent.ACTION_BATTERY_CHANGED)
//   )
//   batteryLevel =
//   intent!!.getIntExtra(BatteryManager.EXTRA_LEVEL, -1) * 100 / intent.getIntExtra(
//   BatteryManager.EXTRA_SCALE,
//   -1
//   )
//   }
//
//   return batteryLevel
//   }
//
// }
