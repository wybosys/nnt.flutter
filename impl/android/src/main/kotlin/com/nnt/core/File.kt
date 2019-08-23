package com.nnt.core;

import java.io.FileReader

fun content_of_file(path: String, def: String? = ""): String? {
    try {
        return FileReader(path).readText();
    } catch (err: Exception) {
        return def;
    }
}
