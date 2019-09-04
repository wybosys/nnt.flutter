package com.nnt.core;

typealias AnyMap = Map<*, *>
typealias IndexedObject = AnyMap
typealias KeyPath = String

val Nil: Any = {}

fun toInt(v: Any?, def: Int = 0): Int {
    if (v == null) {
        return def
    }
    if (v is Int) {
        return v
    }
    if (v is Double) {
        return v.toInt()
    }
    if (v is Float) {
        return v.toInt()
    }
    if (v is Number) {
        return v.toInt()
    }
    if (v is Boolean) {
        return if (v) 1 else 0
    }
    if (v is String) {
        return v.toIntOrNull() ?: def
    }
    return def
}

fun toDouble(v: Any?, def: Double = 0.0): Double {
    if (v == null) {
        return def
    }
    if (v is Int) {
        return v.toDouble()
    }
    if (v is Double) {
        return v.toDouble()
    }
    if (v is Float) {
        return v.toDouble()
    }
    if (v is Number) {
        return v.toDouble()
    }
    if (v is Boolean) {
        return if (v) 1.0 else 0.0
    }
    if (v is String) {
        return v.toDoubleOrNull() ?: def
    }
    return def
}

fun toString(v:Any?, def: String = ""):String {
    if (v == null) {
        return def
    }
    if (v is String) {
        return v
    }
    if (v is Int) {
        return v.toString()
    }
    if (v is Double) {
        return v.toString()
    }
    if (v is Float) {
        return v.toString()
    }
    if (v is Number) {
        return v.toString()
    }
    return v.toString()
}