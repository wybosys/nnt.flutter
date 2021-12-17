package com.nnt.core;

import android.content.Context
import java.io.FileReader

fun content_of_file(path: String, def: String? = null): String? {
    try {
        return FileReader(path).readText();
    } catch (err: Exception) {
        return def;
    }
}

fun content_of_asset(ctx: Context, path: String, def: String? = null): String? {
    try {
        return ctx.assets.open(path).reader().readText();
    } catch (err: Exception) {
        return def;
    }
}
