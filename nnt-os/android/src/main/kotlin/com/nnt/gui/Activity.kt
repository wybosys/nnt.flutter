package com.nnt.gui;

import android.content.Context
import android.os.PowerManager
import android.view.WindowManager
import io.flutter.app.FlutterActivity

open class Activity : FlutterActivity() {

    val _powermgr: PowerManager
        get() {
            return this.getSystemService(Context.POWER_SERVICE) as PowerManager
        }
    var _wakelck: PowerManager.WakeLock? = null

    var _shouldAlwaysLight: Boolean = false

    // 保持常亮
    fun alwaysLight(turnon: Boolean) {
        if (turnon == (_wakelck != null)) {
            // 当前状态和设置的一样
            return
        }

        _shouldAlwaysLight = turnon

        if (turnon) {
            _wakelck = _powermgr.newWakeLock(PowerManager.SCREEN_BRIGHT_WAKE_LOCK, "::nnt::activity::light")
        } else {
            if (_wakelck?.isHeld() == true) {
                _wakelck?.release()
                _wakelck = null
            }

            getWindow().clearFlags(WindowManager.LayoutParams.FLAG_KEEP_SCREEN_ON)
        }
    }

    override fun onResume() {
        super.onResume()
        _wakelck?.acquire(30000);
        if (_shouldAlwaysLight) {
            getWindow().addFlags(WindowManager.LayoutParams.FLAG_KEEP_SCREEN_ON);
        }
    }

    override fun onPause() {
        super.onPause()
        _wakelck?.release();
        if (_shouldAlwaysLight) {
            getWindow().clearFlags(WindowManager.LayoutParams.FLAG_KEEP_SCREEN_ON)
        }
    }
}