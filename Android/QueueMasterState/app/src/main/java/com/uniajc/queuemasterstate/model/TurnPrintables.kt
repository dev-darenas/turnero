package com.uniajc.queuemasterstate.model

import com.mazenrashed.printooth.data.printable.Printable
import com.mazenrashed.printooth.data.printable.TextPrintable
import com.mazenrashed.printooth.data.printer.DefaultPrinter

fun turnPrintables(stringTurn: String) = ArrayList<Printable>().apply {
        add(TextPrintable.Builder()
            .setText("Queue Master")
            .setFontSize(DefaultPrinter.FONT_SIZE_LARGE)
            .setAlignment(DefaultPrinter.ALIGNMENT_CENTER)
            .setNewLinesAfter(2)
            .build())
        add(TextPrintable.Builder()
            .setText("Su turno:")
            .setFontSize(DefaultPrinter.FONT_SIZE_NORMAL)
            .setAlignment(DefaultPrinter.ALIGNMENT_CENTER)
            .setNewLinesAfter(1)
            .build())
        if(stringTurn.isNotEmpty()){
            add(TextPrintable.Builder()
                .setText(stringTurn)
                .setFontSize(DefaultPrinter.FONT_SIZE_LARGE)
                .setAlignment(DefaultPrinter.ALIGNMENT_CENTER)
                .setNewLinesAfter(1)
                .build())
        }
        else{
            add(TextPrintable.Builder()
                .setText("ERROR")
                .setFontSize(DefaultPrinter.FONT_SIZE_LARGE)
                .setAlignment(DefaultPrinter.ALIGNMENT_CENTER)
                .setNewLinesAfter(1)
                .build())
        }
        add(TextPrintable.Builder()
            .setText(Time.dateOnString)
            .setFontSize(DefaultPrinter.FONT_SIZE_NORMAL)
            .setAlignment(DefaultPrinter.ALIGNMENT_CENTER)
            .setNewLinesAfter(3)
            .build())
    }