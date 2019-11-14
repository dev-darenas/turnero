package com.uniajc.queuemasterstate.view

import android.annotation.SuppressLint
import android.os.Bundle
import android.support.v7.app.AppCompatActivity
import android.widget.Button
import android.widget.TextView
import android.widget.Toast
import com.mazenrashed.printooth.Printooth
import com.mazenrashed.printooth.data.printable.Printable
import com.mazenrashed.printooth.data.printable.TextPrintable
import com.mazenrashed.printooth.data.printer.DefaultPrinter
import com.mazenrashed.printooth.utilities.Printing
import com.uniajc.queuemasterstate.R
import com.uniajc.queuemasterstate.model.Time
import com.uniajc.queuemasterstate.model.turnPrintables
import kotlinx.android.synthetic.main.activity_main.*
import java.text.SimpleDateFormat
import java.util.*
import kotlin.collections.ArrayList

class MainActivity : AppCompatActivity() {
    private lateinit var stringCc: String
    private lateinit var btNewTurn: Button
    private lateinit var stringTurn: String
    private var bImp: Boolean = false

    @SuppressLint("SetTextI18n")
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        setupActivity()
    }

    private fun setupActivity() {
        Printooth.init(this)
        val etCc = findViewById<TextView>(R.id.tv_cc)
        val tvDate = findViewById<TextView>(R.id.tv_date)
        val tvTurn = findViewById<TextView>(R.id.tv_turn)
        tvDate.text = Time.dateOnString

        stringCc = intent.getStringExtra("t_cc")
        stringTurn = intent.getStringExtra("t_turn")
        bImp = intent.getBooleanExtra("b_imp", false)

        if ((!stringCc.isBlank() || !stringTurn.isBlank()) && bImp)
            print("66:12:7C:0F:54:60")

        btNewTurn = findViewById(R.id.bt_new)

        btNewTurn.setOnClickListener {
            finish()
            finishActivity(2)

        }
        etCc.text = "CC: $stringCc"
        tvTurn.text = stringTurn
    }

    private fun print(_MAC: String) {
        val printing: Printing?
        try {
            Printooth.setPrinter("BlueTooth Printer", _MAC)
            if (Printooth.hasPairedPrinter()) {
                printing = Printooth.printer()
                val printables = turnPrintables(stringTurn)
                printing.print(printables)
            }
        } catch (e: Exception) {
            Toast.makeText(this, e.message, Toast.LENGTH_LONG).show()
        }
    }
}
