package com.uniajc.queuemasterstate

import android.content.Intent
import android.os.Bundle
import android.support.v7.app.AppCompatActivity
import android.util.Log
import android.widget.Button
import android.widget.CheckBox
import android.widget.RadioButton
import android.widget.RadioGroup

class RequestPriActivity : AppCompatActivity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_request_pri)
        val stringCc = intent.getStringExtra("t_cc")
        val client = intent.getBooleanExtra("b_client", false)
        val status = intent.getIntExtra("status", 0)
        val radioGroup = findViewById<RadioGroup>(R.id.rg_type)
        val button = findViewById<Button>(R.id.bt_next_02)
        val priority = findViewById<CheckBox>(R.id.cb_priority)
        radioGroup.check(R.id.rb_cash)

        button.setOnClickListener {

            val id: Int = radioGroup.checkedRadioButtonId
            val radio: RadioButton = findViewById(id)

            Log.d("RADIO", "Opcion = ${radio.text}")

            if (priority.isChecked)
                switchActivity(stringCc, radio.text.toString(), true, client, status)
            else {
                switchActivity(stringCc, radio.text.toString(), false, client, status)
            }
        }

    }

    private fun switchActivity(stringCc: String, service: String, priority: Boolean, client: Boolean, status: Int) {
        val it = Intent(this, RequestLastActivity::class.java)
        it.putExtra("t_cc", stringCc)
        it.putExtra("t_service", service)
        it.putExtra("b_priority", priority)
        it.putExtra("b_client", client)
        it.putExtra("status", status)
        startActivityForResult(it, 1)
    }

    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        if (requestCode == 1) {
            finish()
            finishActivity(0)
        }
    }
}
