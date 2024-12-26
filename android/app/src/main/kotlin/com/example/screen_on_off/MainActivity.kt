package com.example.screen_on_off

import android.content.Context
import android.os.Bundle
import android.os.PowerManager
import io.flutter.embedding.android.FlutterActivity
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    private val CHANNEL = "com.example.screen_control_app/screen"
    private var wakeLock: PowerManager.WakeLock? = null

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        // Register the MethodChannel to handle method calls from Flutter
        flutterEngine?.let {
            MethodChannel(it.dartBinaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
                if (call.method == "lockScreen") {
                    lockScreen()
                    result.success("Screen locked")
                } else if (call.method == "unlockScreen") {
                    unlockScreen()
                    result.success("Screen unlocked")
                } else {
                    result.notImplemented()
                }
            }
        }
    }

    // Locks the screen by acquiring a wake lock
    private fun lockScreen() {
        val powerManager = getSystemService(Context.POWER_SERVICE) as PowerManager
        wakeLock = powerManager.newWakeLock(
            PowerManager.SCREEN_DIM_WAKE_LOCK or PowerManager.ACQUIRE_CAUSES_WAKEUP,
            "MyApp::ScreenLock"
        )
        wakeLock?.acquire(10 * 60 * 1000L)  // Keep the screen on for 10 minutes
    }

    // Unlocks the screen by releasing the wake lock
    private fun unlockScreen() {
        wakeLock?.release()
        wakeLock = null
    }

    override fun onDestroy() {
        super.onDestroy()
        // Release wake lock when activity is destroyed
        wakeLock?.release()
        wakeLock = null
    }
}