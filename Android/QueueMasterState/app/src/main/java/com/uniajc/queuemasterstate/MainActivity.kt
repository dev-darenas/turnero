package com.uniajc.queuemasterstate

import android.support.v7.app.AppCompatActivity
import android.os.Bundle
import android.widget.Button
import android.widget.TextView
import android.widget.Toast
import com.mazenrashed.printooth.Printooth
import com.mazenrashed.printooth.data.printable.Printable
import com.mazenrashed.printooth.data.printable.TextPrintable
import com.mazenrashed.printooth.data.printer.DefaultPrinter
import com.mazenrashed.printooth.utilities.Printing
import kotlinx.android.synthetic.main.activity_main.*
import java.text.SimpleDateFormat
import java.util.*
import kotlin.collections.ArrayList

class MainActivity : AppCompatActivity() {
    private lateinit var stringCc: String
    private lateinit var btNewTurn: Button
    private lateinit var stringTurn: String
    private var bImp: Boolean = false

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)
        Printooth.init(this)
        val etCc = findViewById<TextView>(R.id.tv_cc)
        val date = getCurrentDateTime()
        val dateInString = date.toString("yyyy/MM/dd HH:mm:ss")
        val tvDate = findViewById<TextView>(R.id.tv_date)

        tvDate.text = dateInString

        stringCc = intent.getStringExtra("t_cc")
        stringTurn = intent.getStringExtra("t_turn")
        bImp = intent.getBooleanExtra("b_imp",false)

        if ((!stringCc.isBlank() || !stringTurn.isBlank()) && bImp) {
            var printing: Printing?
            try {
                Printooth.setPrinter("BlueTooth Printer", "66:12:7C:0F:54:60")
                if (Printooth.hasPairedPrinter()) {
                    printing = Printooth.printer()

                    val printables = getTurnPrintables()
                    printing.print(printables)
                }
            } catch (e: Exception) {
                Toast.makeText(this, e.message, Toast.LENGTH_LONG).show()
            }
        }

        btNewTurn = findViewById(R.id.bt_new)

        btNewTurn.setOnClickListener {
            finish()
            finishActivity(2)

        }
        etCc.text = "CC: $stringCc"
        tv_turn.text = stringTurn
    }
    private fun getTurnPrintables() = ArrayList<Printable>().apply {
        val date = getCurrentDateTime()
        val dateInString = date.toString("yyyy/MM/dd HH:mm:ss")
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
            .setText(dateInString)
            .setFontSize(DefaultPrinter.FONT_SIZE_NORMAL)
            .setAlignment(DefaultPrinter.ALIGNMENT_CENTER)
            .setNewLinesAfter(3)
            .build())
    }
    private fun Date.toString(format: String, locale: Locale = Locale.getDefault()): String {
        val formatter = SimpleDateFormat(format, locale)
        return formatter.format(this)
    }

    private fun getCurrentDateTime(): Date {
        return Calendar.getInstance().time
    }
}
