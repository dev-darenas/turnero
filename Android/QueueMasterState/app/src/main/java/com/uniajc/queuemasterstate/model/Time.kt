package com.uniajc.queuemasterstate.model

object Time: CurrentDateTime{
    private val date = getCurrentDateTime()
    val dateOnString = date.toString("yyyy/MM/dd HH:mm:ss")
}