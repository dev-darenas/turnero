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

    private lateinit var queue: RequestQueue
    private lateinit var etCC: EditText

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_request_cc)

        etCC = findViewById<EditText>(R.id.et_cc)
        val button = findViewById<Button>(R.id.bt_next_01)
        var stringCc: String
        stringCc = etCC.text.toString()

        button.setOnClickListener {
            stringCc = etCC.text.toString()

            if (!etCC.text.isBlank()) {
                val dialog = AlertDialog.Builder(this)
                dialog.setTitle("¿Es correcto?")
                dialog.setMessage("La cedula que digito es: \n $stringCc \n¿Es correcta?")
                dialog.setCancelable(false)
                dialog.setPositiveButton(
                    "Sí"
                ) { _, _ ->
                    queue = Volley.newRequestQueue(this); getData()
                }
                dialog.setNegativeButton(
                    "No"
                ) { _, _ -> }
                dialog.show()
            } else {
                Toast.makeText(
                    baseContext,
                    "Error, el ingreso de la cedula es obligatorio",
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
                    Log.d("Client", client.toString())
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
        startActivityForResult(it, 0)
    }
    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        if(requestCode == 0){
            etCC.text.clear()
        }
    }
}
