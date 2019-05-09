package com.uniajc.queuemasterstate

import android.content.Intent
import android.support.v7.app.AppCompatActivity
import android.os.Bundle
import android.util.Log
import android.widget.*
import kotlinx.android.synthetic.main.activity_request_pri.*

class RequestPriActivity : AppCompatActivity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_request_pri)
        val stringCc = intent.getStringExtra("t_cc")
        val client = intent.getBooleanExtra("b_client",false)
        val radioGroup = findViewById<RadioGroup>(R.id.rg_type)
        val button = findViewById<Button>(R.id.bt_next_02)
        val priority = findViewById<CheckBox>(R.id.cb_priority)
        radioGroup.check(R.id.rb_cash)

        button.setOnClickListener {

            val id: Int = radioGroup.checkedRadioButtonId
            val radio:RadioButton = findViewById(id)

            Log.d("RADIO", "Opcion = ${radio.text}")

            if (priority.isChecked)
                switchActivity(stringCc, radio.text.toString(), true, client)
            else {
                switchActivity(stringCc, radio.text.toString(), false, client)
            }
        }

    }

    private fun switchActivity(stringCc: String, service: String, priority: Boolean, client: Boolean) {
        val it = Intent(this, RequestLastActivity::class.java)
        it.putExtra("t_cc", stringCc)
        it.putExtra("t_service", service)
        it.putExtra("b_priority", priority)
        it.putExtra("b_client", client)
        startActivity(it)
    }
}
