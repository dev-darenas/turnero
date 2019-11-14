package com.uniajc.queuemasterstate.model

import java.text.SimpleDateFormat
import java.util.*

interface CurrentDateTime{
    fun Date.toString(format: String, locale: Locale = Locale.getDefault()): String {
        val formatter = SimpleDateFormat(format, locale)
        return formatter.format(this)
    }

    fun getCurrentDateTime(): Date {
        return Calendar.getInstance().time
    }
}