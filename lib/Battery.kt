package com.example.BroadcastReceiver

import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.content.IntentFilter
import android.os.BatteryManager
import io.flutter.embedding.android.FlutterActivity
import io.flutter.plugin.common.EventChannel

class MainActivity: FlutterActivity() {
    private val BATTERY_CHANNEL = "com.example.BroadcastReceiver/battery"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        EventChannel(flutterEngine.dartExecutor.binaryMessenger, BATTERY_CHANNEL).setStreamHandler(
            object : EventChannel.StreamHandler {
                private var receiver: BroadcastReceiver? = null

                override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
                    receiver = createBatteryLevelReceiver(events)
                    registerReceiver(receiver, IntentFilter(Intent.ACTION_BATTERY_CHANGED))
                }

                override fun onCancel(arguments: Any?) {
                    unregisterReceiver(receiver)
                    receiver = null
                }
            }
        )
    }

    private fun createBatteryLevelReceiver(events: EventChannel.EventSink?): BroadcastReceiver {
        return object : BroadcastReceiver() {
            override fun onReceive(context: Context, intent: Intent) {
                val level = intent.getIntExtra(BatteryManager.EXTRA_LEVEL, -1)
                val scale = intent.getIntExtra(BatteryManager.EXTRA_SCALE, -1)
                val batteryPct = level * 100 / scale.toFloat()
                if (batteryPct >= 90 && intent.getIntExtra(BatteryManager.EXTRA_PLUGGED, -1) > 0) {
                    events?.success("Battery is at $batteryPct% and charging")
                }
            }
        }
    }
}
