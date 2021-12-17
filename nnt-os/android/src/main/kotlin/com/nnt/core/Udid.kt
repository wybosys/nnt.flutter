package com.nnt.core;

import android.annotation.TargetApi
import android.content.Context
import android.os.Build
import android.telephony.TelephonyManager
import com.nnt.core.Device.Companion.GetAndroidId
import java.util.*

class Udid {

    companion object {

        fun GetCurrent(context: Context): String {
            var r = GetDeviceId(context)
            if (r != "")
                return r
            r = GetPseudoId(context)
            if (r != "")
                return r
            r = GetAndroidId(context)
            if (r != "")
                return r
            return ToString(UUID.randomUUID());
        }

        fun GetDeviceId(context: Context, def: String = ""): String {
            try {
                val tm = context.getSystemService(Context.TELEPHONY_SERVICE) as TelephonyManager
                val tmDevice = tm.deviceId
                val tmSerial = tm.simSerialNumber
                val androidId = android.provider.Settings.Secure.getString(context.contentResolver, android.provider.Settings.Secure.ANDROID_ID)
                return ToString(UUID(androidId.hashCode().toLong(), tmDevice.hashCode().toLong() shl 32 or tmSerial.hashCode().toLong()))
            } catch (ex: Exception) {
                // pass
            }
            return def
        }

        @TargetApi(Build.VERSION_CODES.O)
        fun GetPseudoId(context: Context, def: String = ""): String {
            try {
                val m_szDevIDShort = "NNT_" + (Build.BOARD.length % 10) +
                        (Build.BRAND.length % 10) + (Build.CPU_ABI.length % 10) +
                        (Build.DEVICE.length % 10) + (Build.MANUFACTURER.length %
                        10) + (Build.MODEL.length % 10) + (Build.PRODUCT.length %
                        10)
                var serial: String
                if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
                    serial = Build.getSerial()
                } else {
                    serial = Build.SERIAL
                }
                return ToString(UUID(m_szDevIDShort.hashCode().toLong(), serial.hashCode().toLong()))
            } catch (ex: Exception) {
                // pass
            }
            return def
        }

        fun ToString(id: UUID): String {
            return id.toString().replace("-", "");
        }
    }
}