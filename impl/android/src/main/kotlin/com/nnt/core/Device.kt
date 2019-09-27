package com.nnt.core;

import android.annotation.SuppressLint
import android.content.Context
import android.net.ConnectivityManager
import android.net.NetworkInfo
import android.net.wifi.WifiManager
import android.provider.Settings
import android.telephony.TelephonyManager


class Device {

    companion object {

        fun GetAndroidId(context: Context, def: String = ""): String {
            try {
                return Settings.Secure.getString(context.contentResolver, Settings.Secure.ANDROID_ID);
            } catch (err: Exception) {
                // pass
            }
            return def;
        }

        fun GetMacAddress(context: Context, def: String = ""): String {
            if (!IsWifiConnected(context))
                return def;

            try {
                val wifiManager = context.applicationContext.getSystemService(Context.WIFI_SERVICE) as WifiManager
                return wifiManager.connectionInfo.macAddress
            } catch (err: Exception) {
                // pass
            }
            return def;
        }

        @SuppressLint("NewApi")
        fun GetIMEI(context: Context, def: String = ""): String {
            val tm = context.getSystemService(Context.TELEPHONY_SERVICE) as TelephonyManager
            try {
                return tm.getImei(0)
            } catch (err: Exception) {
                // pass
            }
            try {
                return tm.getImei(1)
            } catch (err: Exception) {
                // pass
            }
            try {
                return tm.imei;
            } catch (err: Exception) {
                // pass
            }
            return def;
        }

        fun IsWifiConnected(context: Context, def: Boolean = false): Boolean {
            try {
                val cm = context.getSystemService(Context.CONNECTIVITY_SERVICE) as ConnectivityManager
                return cm.getNetworkInfo(ConnectivityManager.TYPE_WIFI).state == NetworkInfo.State.CONNECTED
            } catch (err: Exception) {
                // pass
            }
            return def
        }
    }
}