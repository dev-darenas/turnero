package com.uniajc.queuemasterstate

import android.annotation.SuppressLint
import android.content.Context
import android.content.Intent
import android.os.Bundle
import android.support.v7.app.AppCompatActivity
import android.text.InputType
import android.util.Log
import android.util.Patterns
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
        val booleanPriority = intent.getBooleanExtra("b_priority", false)
        val client = intent.getBooleanExtra("b_client", false)

        val cbImp = findViewById<CheckBox>(R.id.cb_imp)
        val cbEmail = findViewById<CheckBox>(R.id.cb_email)
        val cbSms = findViewById<CheckBox>(R.id.cb_sms)
        val cbWhats = findViewById<CheckBox>(R.id.cb_whats)
        val lvText = findViewById<ListView>(R.id.lv_text)
        val generate = findViewById<Button>(R.id.bt_generate)

        if (!client) {
            lvText.adapter = MyCustomAdapter(this, cbEmail.isChecked, cbSms.isChecked, cbWhats.isChecked)

            cbEmail.setOnCheckedChangeListener { _, _ ->
                lvText.adapter = MyCustomAdapter(this, cbEmail.isChecked, cbSms.isChecked, cbWhats.isChecked)
            }
            cbSms.setOnCheckedChangeListener { _, _ ->
                lvText.adapter = MyCustomAdapter(this, cbEmail.isChecked, cbSms.isChecked, cbWhats.isChecked)
            }
            cbWhats.setOnCheckedChangeListener { _, _ ->
                lvText.adapter = MyCustomAdapter(this, cbEmail.isChecked, cbSms.isChecked, cbWhats.isChecked)
            }
        }

        generate.setOnClickListener {
            var email = "null"
            var phoneNumber: String? = null
            val count = lvText.childCount
            if (count > 0 && cbEmail.isChecked) {
                email = lvText.getChildAt(0).findViewById<AutoCompleteTextView>(R.id.et_media).text.toString()
            }
            if (count == 1 && !cbEmail.isChecked && (cbSms.isChecked || cbWhats.isChecked)) {
                val stringTemp = lvText.getChildAt(0).findViewById<AutoCompleteTextView>(R.id.et_media).text.toString()
                phoneNumber = when {
                    stringTemp.isBlank() -> "0"
                    else -> stringTemp
                }

            } else if (count == 2 && cbEmail.isChecked && (cbSms.isChecked || cbWhats.isChecked)) {
                val stringTemp = lvText.getChildAt(1).findViewById<AutoCompleteTextView>(R.id.et_media).text.toString()
                phoneNumber = when {
                    stringTemp.isBlank() -> "0"
                    else -> stringTemp
                }
            }
            fun makeVolleyRequest() {
                queue = Volley.newRequestQueue(this)
                getData(
                    stringCc,
                    phoneNumber,
                    email,
                    stringService,
                    booleanPriority,
                    cbWhats.isChecked,
                    cbEmail.isChecked,
                    cbSms.isChecked,
                    cbImp.isChecked
                )
            }
            if (!client) {
                if (((cbEmail.isChecked && !email.isBlank()) || !cbEmail.isChecked) && (((cbSms.isChecked || cbWhats.isChecked) && phoneNumber != "0") || (!cbSms.isChecked && !cbWhats.isChecked))) {
                    if (isCorrectEmail(email) && cbEmail.isChecked)
                        makeVolleyRequest()
                    else if(cbEmail.isChecked)
                        Toast.makeText(this, "Correo no valido, por favor verificar", Toast.LENGTH_LONG).show()
                    else
                        makeVolleyRequest()
                } else {
                    Toast.makeText(
                        this,
                        "Error, todos los campos de texto deben de ser llenados",
                        Toast.LENGTH_SHORT
                    ).show()
                }
            } else {
                makeVolleyRequest()
            }

            //Toast.makeText(this, "Correo: $email Numero: $phoneNumber", Toast.LENGTH_LONG).show()
        }
    }

    private class MyCustomAdapter(
        val context: Context,
        val cbEmail: Boolean,
        val cbPhone: Boolean,
        val cbWhats: Boolean
    ) : BaseAdapter() {

        val items = ArrayList(arrayListOf(R.layout.edit_text_media_item, R.layout.edit_text_media_item))

        @SuppressLint("ViewHolder")
        override fun getView(position: Int, convertView: View?, parent: ViewGroup?): View {
            val layoutInflater = LayoutInflater.from(context)

            val item = layoutInflater.inflate(items[position], parent, false)

            val autoCompleteText = item.findViewById<AutoCompleteTextView>(R.id.et_media)

            when {
                cbEmail && position == 0 -> {
                    autoCompleteText.inputType = InputType.TYPE_TEXT_VARIATION_EMAIL_ADDRESS; autoCompleteText.hint =
                        "Escriba su dirección de email..."
                }
                !cbEmail && (cbPhone || cbWhats) && position == 0 -> {
                    autoCompleteText.inputType = InputType.TYPE_CLASS_PHONE; autoCompleteText.hint =
                        "Escriba su número telefonico..."
                }
                cbEmail && (cbPhone || cbWhats) && position == 1 -> {
                    autoCompleteText.inputType = InputType.TYPE_CLASS_PHONE; autoCompleteText.hint =
                        "Escriba su número telefonico..."
                }
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
            return if (cbEmail && (cbPhone || cbWhats)) {
                2
            } else if ((cbEmail && !cbPhone && !cbWhats) || (!cbEmail && (cbPhone || cbWhats))) {
                1
            } else {
                0
            }
        }
    }

    private fun getData(
        stringCc: String,
        phoneNumber: String?,
        email: String?,
        stringService: String,
        booleanPriority: Boolean,
        bWhats: Boolean,
        bEmail: Boolean,
        bSms: Boolean,
        bImp: Boolean
    ) {

        val priorityGet = when (booleanPriority) {
            true -> 2; false -> 0
        }
        val whatsGet = when (bWhats) {
            true -> 1; false -> 0
        }
        val emailGet = when (bEmail) {
            true -> 1; false -> 0
        }
        val smsGet = when (bSms) {
            true -> 1; false -> 0
        }

        val url = "http://5.189.167.158/Turnero/pong.php/?cedula=$stringCc&celular=$phoneNumber" +
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
                    switchActivity(stringCc, turn, bImp)
                } catch (e: JSONException) {
                    e.printStackTrace()
                    Toast.makeText(this, e.message, Toast.LENGTH_LONG).show()
                }
            }, Response.ErrorListener {
                Toast.makeText(this, "ERROR: $it", Toast.LENGTH_SHORT).show()
            })
        queue.add(request)

    }

    private fun switchActivity(stringCc: String, turn: String, bImp: Boolean) {
        val it = Intent(this, MainActivity::class.java)
        it.putExtra("t_cc", stringCc)
        it.putExtra("t_turn", turn)
        it.putExtra("b_imp", bImp)
        startActivityForResult(it, 2)
    }

    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        if (requestCode == 2) {
            finish()
            finishActivity(1)
        }
    }

    private fun isCorrectEmail(email: String): Boolean {
        val pattern = Patterns.EMAIL_ADDRESS
        return pattern.matcher(email).matches()
    }
}
