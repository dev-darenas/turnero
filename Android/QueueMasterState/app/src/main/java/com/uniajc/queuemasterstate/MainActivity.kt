package com.uniajc.queuemasterstate

import android.support.v7.app.AppCompatActivity
import android.os.Bundle
import android.widget.Button
import android.widget.TextView
import kotlinx.android.synthetic.main.activity_main.*

class MainActivity : AppCompatActivity() {
    private lateinit var stringCc: String
    private lateinit var btNewTurn: Button
    private lateinit var stringTurn: String

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)
        val etCc = findViewById<TextView>(R.id.tv_cc)

        stringCc = intent.getStringExtra("t_cc")
        stringTurn = intent.getStringExtra("t_turn")

        if(!stringCc.isBlank() || !stringTurn.isBlank()){
            // PRINT
        }

        btNewTurn = findViewById(R.id.bt_new)

        btNewTurn.setOnClickListener {

            finish()
            finishActivity(2)

        }
        etCc.text = "CC: $stringCc"
        tv_turn.text = stringTurn
    }
}
