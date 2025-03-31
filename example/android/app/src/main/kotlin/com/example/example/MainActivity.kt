package com.example.example

import android.content.Context
import android.os.Bundle
import io.flutter.embedding.android.FlutterActivity
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    private val CHANNEL = "com.pip.app/channel"

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        MethodChannel(flutterEngine!!.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler {
                call,
                result ->
            if (call.method == "moveTaskToFront") {
                moveTaskToFront()
                result.success(null)
            } else {
                result.notImplemented()
            }
        }
    }

    private fun moveTaskToFront() {
        val activityManager =
                getSystemService(Context.ACTIVITY_SERVICE) as android.app.ActivityManager
        activityManager.moveTaskToFront(taskId, 0)
    }
}
