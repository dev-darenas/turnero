package com.uniajc.queuemasterstate

import android.annotation.SuppressLint
import android.content.Context
import android.content.Intent
import android.support.v7.app.AppCompatActivity
import android.os.Bundle
import android.text.InputType
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.*

class RequestLastActivity : AppCompatActivity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_request_last)

        val stringCc = intent.getStringExtra("t_cc")
        val stringService = intent.getStringExtra("t_service")
        val stringPriority = intent.getStringExtra("t_priority")

        val cbImp = findViewById<CheckBox>(R.id.cb_imp)
        val cbEmail = findViewById<CheckBox>(R.id.cb_email)
        val cbSms = findViewById<CheckBox>(R.id.cb_sms)
        val lvText = findViewById<ListView>(R.id.lv_text)

        lvText.adapter = MyCustomAdapter(this, cbEmail.isChecked, cbSms.isChecked)

        cbEmail.setOnCheckedChangeListener { _, _ ->  lvText.adapter = MyCustomAdapter(this, cbEmail.isChecked, cbSms.isChecked)}
        cbSms.setOnCheckedChangeListener { _, _ ->  lvText.adapter = MyCustomAdapter(this, cbEmail.isChecked, cbSms.isChecked)}


        when {
            cbEmail.isChecked -> {

            }
            cbSms.isChecked -> {

            }
        }
    }

    private class MyCustomAdapter(val context: Context, val cbEmail: Boolean, val cbPhone: Boolean): BaseAdapter() {

        val items = listOf<Int>(InputType.TYPE_TEXT_VARIATION_EMAIL_ADDRESS, InputType.TYPE_CLASS_PHONE)

        @SuppressLint("ViewHolder")
        override fun getView(position: Int, convertView: View?, parent: ViewGroup?): View {
            val layoutInflater = LayoutInflater.from(context)



            val item = layoutInflater.inflate(R.layout.edit_text_media_item, parent, false)

            val autoCompleteText = item.findViewById<AutoCompleteTextView>(R.id.et_media)

            when{
                cbEmail -> autoCompleteText.inputType = InputType.TYPE_CLASS_PHONE
                cbPhone -> autoCompleteText.inputType = InputType.TYPE_TEXT_VARIATION_EMAIL_ADDRESS
            }

            return item
        }

        override fun getItem(position: Int): Any {
            return "TEST STRING"
        }

        override fun getItemId(position: Int): Long {
            return position.toLong()
        }

        override fun getCount(): Int {
            return if(cbEmail && cbPhone){
                2
            } else if((cbEmail && !cbPhone) ||(!cbEmail && cbPhone)){
                1
            } else{
                0
            }
        }
    }

    private fun switchActivity(stringCc: String, turn: String) {
        val it = Intent(this, MainActivity::class.java)
        it.putExtra("t_cc", stringCc)
        it.putExtra("t_turn", turn)
        startActivity(it)
    }
}
