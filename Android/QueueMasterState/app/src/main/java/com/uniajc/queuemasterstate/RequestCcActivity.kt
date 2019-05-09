package com.uniajc.queuemasterstate

import android.content.Intent
import android.support.v7.app.AppCompatActivity
import android.os.Bundle
import android.widget.*
import android.support.v7.app.AlertDialog
import android.util.Log

import com.android.volley.Request
import com.android.volley.RequestQueue
import com.android.volley.Response
import com.android.volley.toolbox.JsonObjectRequest
import com.android.volley.toolbox.Volley

import org.json.JSONException

import android.widget.Toast
import kotlinx.android.synthetic.main.activity_request_cc.*


class RequestCcActivity : AppCompatActivity() {

    private var sPriority = "null"
    lateinit var sMedia: String
    lateinit var sService: String
    private lateinit var queue: RequestQueue

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_request_cc)

        val etCC = findViewById<EditText>(R.id.et_cc)
        val button = findViewById<Button>(R.id.bt_next_01)
        var stringCc: String
        stringCc = etCC.text.toString()
        /*
        val mediaType = arrayOf("Email", "Telefono")
        media.adapter = ArrayAdapter(this, android.R.layout.simple_spinner_item, mediaType)

        val serviceType = arrayOf("Asesor", "Caja")
        service.adapter = ArrayAdapter(this, android.R.layout.simple_spinner_item, serviceType)

        media.onItemSelectedListener = object : AdapterView.OnItemSelectedListener {
            override fun onNothingSelected(parent: AdapterView<*>?) {}
            // Mensaje de error
            override fun onItemSelected(parent: AdapterView<*>?, view: View?, position: Int, id: Long) {
                if (position == 0) {
                    sMedia = "email"
                    etMedia.text.clear()
                    etMedia.isEnabled = true
                    etMedia.hint = "Correo Electronico"
                    etMedia.inputType = InputType.TYPE_TEXT_VARIATION_EMAIL_ADDRESS
                } else {
                    sMedia = "phone"
                    etMedia.text.clear()
                    etMedia.isEnabled = true
                    etMedia.hint = "Telefono celular"
                    etMedia.inputType = InputType.TYPE_CLASS_PHONE
                }
            }
        }
        service.onItemSelectedListener = object : AdapterView.OnItemSelectedListener {
            override fun onNothingSelected(parent: AdapterView<*>?) {}
            // Mensaje de error
            override fun onItemSelected(parent: AdapterView<*>?, view: View?, position: Int, id: Long) {
                sService = when (position) {
                    0 -> "asesor"
                    else -> "caja"
                }
            }
        }

        cbDisability.setOnCheckedChangeListener { _, b ->
            if (b) {
                cbMayor.isChecked = false
                cbPregnant.isChecked = false
            }
        }
        cbMayor.setOnCheckedChangeListener { _, b ->
            if (b) {
                cbDisability.isChecked = false
                cbPregnant.isChecked = false
            }
        }
        cbPregnant.setOnCheckedChangeListener { _, b ->
            if (b) {
                cbMayor.isChecked = false
                cbDisability.isChecked = false
            }
        }*/

        button.setOnClickListener {
            stringCc = etCC.text.toString()

            /*
            if (cbDisability.isChecked || cbMayor.isChecked || cbPregnant.isChecked) {
                when {
                    cbDisability.isChecked -> sPriority = "isDisability"
                    cbMayor.isChecked -> sPriority = "isMayor"
                    cbPregnant.isChecked -> sPriority = "isPregnant"
                }
            } else {
                sPriority = "null"
            }
            */

            if (!etCC.text.isBlank()) {
                val dialog = AlertDialog.Builder(this)
                dialog.setTitle("¿Es correcto?")
                dialog.setMessage("La cedula que digito es: \n $stringCc \n¿Es correcta?")
                dialog.setCancelable(false)
                dialog.setPositiveButton(
                    "Sí"
                ) { _, _ -> queue = Volley.newRequestQueue(this); getData()
                }
                dialog.setNegativeButton(
                    "No"
                ) { _, _ -> }
                dialog.show()
            } else {
                Toast.makeText(
                    baseContext,
                    "Error, Cedula y correo o número telefonico son obligatorios",
                    Toast.LENGTH_SHORT
                ).show()
            }
        }
    }

    private fun getData() {
        var url = "http://thenecromancer.es/Turnero/pong.php/?cedula=${et_cc.text}"
            Log.i("URL", url)
        var client = false

        val request = JsonObjectRequest(Request.Method.GET, url, null,
            Response.Listener { response ->
                try {
                    val jsonArray = response.getJSONArray("cliente")
                    var cont = 0
                    while (cont < jsonArray.length()) {
                        val jsonObject = jsonArray.getJSONObject(cont)
                        client = jsonObject.getBoolean("estado")
                        cont++
                    }
                    Log.d("Client",client.toString())
                    switchActivity(et_cc.text.toString(), client)
                } catch (e: JSONException) {
                    e.printStackTrace()
                    Toast.makeText(this, e.message, Toast.LENGTH_LONG).show()
                }
            }, Response.ErrorListener {
                Toast.makeText(this, "ERROR: $it", Toast.LENGTH_SHORT).show()
            })
        queue.add(request)

    }


    private fun switchActivity(stringCc: String, client: Boolean) {
        val it = Intent(this, RequestPriActivity::class.java)
        it.putExtra("t_cc", stringCc)
        it.putExtra("b_client", client)
        startActivity(it)
    }
}
