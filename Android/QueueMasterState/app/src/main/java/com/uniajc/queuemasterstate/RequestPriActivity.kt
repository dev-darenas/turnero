package com.uniajc.queuemasterstate

import android.content.Intent
import android.support.v7.app.AppCompatActivity
import android.os.Bundle
import android.widget.Button
import android.widget.CheckBox
import android.widget.RadioButton
import android.widget.RadioGroup

class RequestPriActivity : AppCompatActivity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_request_pri)
        val stringCc = intent.getStringExtra("t_cc")
        val radioGroup = findViewById<RadioGroup>(R.id.rg_type)
        val button = findViewById<Button>(R.id.bt_next_02)
        val priority = findViewById<CheckBox>(R.id.cb_priority)
        var string = ""

        if (radioGroup.checkedRadioButtonId == R.id.rb_cash) {
            string = "caja"
        } else if (radioGroup.checkedRadioButtonId == R.id.rb_adviser) {
            string = "asesor"
        }

        button.setOnClickListener {
            if (priority.isChecked)
                switchActivity(stringCc, string, true)
            else {
                switchActivity(stringCc, string, false)
            }
        }

    }

    private fun switchActivity(stringCc: String, service: String, priority: Boolean) {
        val it = Intent(this, RequestLastActivity::class.java)
        it.putExtra("t_cc", stringCc)
        it.putExtra("t_service", service)
        it.putExtra("b_priority", priority)
        startActivity(it)
    }
}
