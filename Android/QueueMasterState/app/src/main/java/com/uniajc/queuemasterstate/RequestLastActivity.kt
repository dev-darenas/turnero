package com.uniajc.queuemasterstate

import android.annotation.SuppressLint
import android.content.Context
import android.content.Intent
import android.support.v7.app.AppCompatActivity
import android.os.Bundle
import android.text.InputType
import android.util.Log
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.*
import com.android.volley.Request
import com.android.volley.RequestQueue
import com.android.volley.Response
import com.android.volley.toolbox.JsonObjectRequest
import com.android.volley.toolbox.Volley
import org.json.JSONException

class RequestLastActivity : AppCompatActivity() {

    private lateinit var queue: RequestQueue

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_request_last)

        val stringCc = intent.getStringExtra("t_cc")
        val stringService = intent.getStringExtra("t_service")
        val booleanPriority = intent.getBooleanExtra("t_priority", false)
        val client = intent.getBooleanExtra("b_client", false)

        val cbImp = findViewById<CheckBox>(R.id.cb_imp) // TO DO !!!!!!!
        val cbEmail = findViewById<CheckBox>(R.id.cb_email)
        val cbSms = findViewById<CheckBox>(R.id.cb_sms)
        val lvText = findViewById<ListView>(R.id.lv_text)
        val generate = findViewById<Button>(R.id.bt_generate)

        if (!client) {
            lvText.adapter = MyCustomAdapter(this, cbEmail.isChecked, cbSms.isChecked)

            cbEmail.setOnCheckedChangeListener { _, _ ->
                lvText.adapter = MyCustomAdapter(this, cbEmail.isChecked, cbSms.isChecked)
            }
            cbSms.setOnCheckedChangeListener { _, _ ->
                lvText.adapter = MyCustomAdapter(this, cbEmail.isChecked, cbSms.isChecked)
            }
        }

        generate.setOnClickListener {
            var email: String? = null
            var phoneNumber: Int? = null
            val count = lvText.childCount
            if (count > 0 && cbEmail.isChecked) {
                email = lvText.getChildAt(0).findViewById<AutoCompleteTextView>(R.id.et_media).text.toString()
            }
            if (count == 1 && !cbEmail.isChecked && cbSms.isChecked) {
                phoneNumber =
                    lvText.getChildAt(0).findViewById<AutoCompleteTextView>(R.id.et_media).text.toString().toInt()
            } else if (count == 2 && cbEmail.isChecked && cbSms.isChecked) {
                phoneNumber =
                    lvText.getChildAt(1).findViewById<AutoCompleteTextView>(R.id.et_media).text.toString().toInt()
            }

            //Toast.makeText(this, "Correo: $email Numero: $phoneNumber", Toast.LENGTH_LONG).show()
            queue = Volley.newRequestQueue(this)
            getData(
                stringCc,
                phoneNumber,
                email,
                stringService,
                booleanPriority,
                false,
                cbEmail.isChecked,
                cbSms.isChecked
            )
        }

    }

    private class MyCustomAdapter(val context: Context, val cbEmail: Boolean, val cbPhone: Boolean) : BaseAdapter() {

        val items = ArrayList(arrayListOf(R.layout.edit_text_media_item, R.layout.edit_text_media_item))

        @SuppressLint("ViewHolder")
        override fun getView(position: Int, convertView: View?, parent: ViewGroup?): View {
            val layoutInflater = LayoutInflater.from(context)

            val item = layoutInflater.inflate(items[position], parent, false)

            val autoCompleteText = item.findViewById<AutoCompleteTextView>(R.id.et_media)

            when {
                cbEmail && position == 0 -> autoCompleteText.inputType = InputType.TYPE_TEXT_VARIATION_EMAIL_ADDRESS
                !cbEmail && cbPhone && position == 0 -> autoCompleteText.inputType = InputType.TYPE_CLASS_PHONE
                cbEmail && cbPhone && position == 1 -> autoCompleteText.inputType = InputType.TYPE_CLASS_PHONE
            }
            return item
        }

        override fun getItem(position: Int): Any {
            return items[position]
        }

        override fun getItemId(position: Int): Long {
            return position.toLong()
        }

        override fun getCount(): Int {
            return if (cbEmail && cbPhone) {
                2
            } else if ((cbEmail && !cbPhone) || (!cbEmail && cbPhone)) {
                1
            } else {
                0
            }
        }
    }

    private fun getData(
        stringCc: String,
        phoneNumber: Int?,
        email: String?,
        stringService: String,
        booleanPriority: Boolean,
        WTPENDIENTE: Boolean,
        bEmail: Boolean,
        bSms: Boolean
    ) {

        val priorityGet = when (booleanPriority) {
            true -> 1; false -> 0
        }
        val whatsGet = when (WTPENDIENTE) {
            true -> 1; false -> 0
        }
        val emailGet = when (bEmail) {
            true -> 1; false -> 0
        }
        val smsGet = when (bSms) {
            true -> 1; false -> 0
        }

        var url = "http://thenecromancer.es/Turnero/pong.php/?cedula=$stringCc&celular=$phoneNumber" +
                "&correo=$email&tiposervicio=$stringService&prioridad=$priorityGet" +
                "&notificacion_whatsapp=$whatsGet&notificacion_email=$emailGet&notificacion_sms=$smsGet"
        Log.i("URL", url)
        var turn = ""

        val request = JsonObjectRequest(Request.Method.GET, url, null,
            Response.Listener { response ->
                try {
                    val jsonArray = response.getJSONArray("turno")
                    var cont = 0
                    while (cont < jsonArray.length()) {
                        val jsonObject = jsonArray.getJSONObject(cont)
                        turn = jsonObject.getString("turn")
                        cont++
                    }
                    switchActivity(stringCc, turn)
                } catch (e: JSONException) {
                    e.printStackTrace()
                    Toast.makeText(this, e.message, Toast.LENGTH_LONG).show()
                }
            }, Response.ErrorListener {
                Toast.makeText(this, "ERROR: $it", Toast.LENGTH_SHORT).show()
            })
        queue.add(request)

    }

    private fun switchActivity(stringCc: String, turn: String) {
        val it = Intent(this, MainActivity::class.java)
        it.putExtra("t_cc", stringCc)
        it.putExtra("t_turn", turn)
        startActivity(it)
    }
}
