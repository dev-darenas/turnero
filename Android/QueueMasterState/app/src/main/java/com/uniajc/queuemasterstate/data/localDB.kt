package com.andxpar.biblioparcial.data

import android.content.Context
import android.database.sqlite.SQLiteDatabase
import com.uniajc.queuemasterstate.data.AdminSqlOpenHelper

fun getDB(context: Context): SQLiteDatabase {
    val admin = AdminSqlOpenHelper(context, "LocalData", null, 1)
    return admin.writableDatabase
}