package com.nnt.core;

import android.content.Context
import android.os.Build
import android.telephony.TelephonyManager
import com.nnt.core.Device.Companion.GetAndroidId
import java.util.*

class Udid {

    companion object {

        @JvmStatic
        fun GetCurrent(context: Context): String {
            try {
                return GetDeviceId(context)
            } catch (ex: Exception) {
                Logger.log(ex.toString());
            }
            try {
                return GetPseudoId(context);
            } catch (ex: Exception) {
                Logger.log(ex.toString());
            }
            try {
                return GetAndroidId(context)
            } catch (ex: Exception) {
                Logger.log(ex.toString());
            }
            return ToString(UUID.randomUUID());
        }

        @JvmStatic
        fun GetDeviceId(context: Context): String {
            val tm = context.getSystemService(Context.TELEPHONY_SERVICE) as TelephonyManager
            val tmDevice = tm.deviceId
            val tmSerial = tm.simSerialNumber
            val androidId = android.provider.Settings.Secure.getString(context.contentResolver, android.provider.Settings.Secure.ANDROID_ID)
            return ToString(UUID(androidId.hashCode().toLong(), tmDevice.hashCode().toLong() shl 32 or tmSerial.hashCode().toLong()))
        }

        @JvmStatic
        fun GetPseudoId(context: Context): String {
            val m_szDevIDShort = "NNT_" + (Build.BOARD.length % 10) +
                    (Build.BRAND.length % 10) + (Build.CPU_ABI.length % 10) +
                    (Build.DEVICE.length % 10) + (Build.MANUFACTURER.length %
                    10) + (Build.MODEL.length % 10) + (Build.PRODUCT.length %
                    10)
            var serial = android.os.Build.getSerial()
            return ToString(UUID(m_szDevIDShort.hashCode().toLong(), serial.hashCode().toLong()))
        }

        @JvmStatic
        fun ToString(id: UUID): String {
            return id.toString().replace("-", "");
        }
    }
}