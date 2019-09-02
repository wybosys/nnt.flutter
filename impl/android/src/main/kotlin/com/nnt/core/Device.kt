package com.nnt.core;

import android.content.Context
import android.provider.Settings

class Device {

    companion object {
        @JvmStatic
        fun GetAndroidId(context: Context): String {
            return Settings.Secure.getString(context.contentResolver, Settings.Secure.ANDROID_ID);
        }
    }
}