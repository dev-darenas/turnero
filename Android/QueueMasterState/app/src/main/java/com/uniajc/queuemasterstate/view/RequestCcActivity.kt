package com.uniajc.queuemasterstate.view

import android.content.ContentValues
import android.content.Intent
import android.os.Bundle
import android.support.v7.app.AlertDialog
import android.support.v7.app.AppCompatActivity
import android.util.Log
import android.widget.Button
import android.widget.EditText
import android.widget.TextView
import android.widget.Toast
import com.android.volley.Request
import com.android.volley.RequestQueue
import com.android.volley.Response
import com.android.volley.toolbox.JsonObjectRequest
import com.android.volley.toolbox.Volley
import com.andxpar.biblioparcial.data.getDB
import kotlinx.android.synthetic.main.activity_request_cc.*
import org.json.JSONException
import android.view.LayoutInflater
import com.uniajc.queuemasterstate.R


class RequestCcActivity : AppCompatActivity() {

    private lateinit var queue: RequestQueue
    private lateinit var etCC: EditText
    private lateinit var txtStatus: TextView
    private lateinit var txtURL: TextView
    private var status = 0

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_request_cc)

        val db = getDB(this)
        val cursor = db.rawQuery("select * from Local", null)
        if (cursor.moveToFirst()) {
            URL = cursor.getString(0)
        }
        cursor.close()
        db.close()

        status = 0
        txtStatus = findViewById(R.id.txtStatus)
        etCC = findViewById(R.id.et_cc)
        val bNext = findViewById<Button>(R.id.bt_next_01)
        var stringCc: String
        stringCc = etCC.text.toString()
        val hideButton = findViewById<Button>(R.id.hideAll)
        val changeButton = findViewById<Button>(R.id.bt_changeURL)
        txtURL = findViewById(R.id.tv_url)
        txtURL.text = URL

        var cont = 0
        hideButton.setOnClickListener {
            if (cont == 0) {
                status = 1
                findViewById<TextView>(R.id.txtStatus).text = "1"
                cont++
            } else {
                status = 2
                findViewById<TextView>(R.id.txtStatus).text = "2"
                cont++
            }

        }

        bNext.setOnClickListener {
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

        changeButton.setOnClickListener {
            showAlert()
        }

    }

    private fun showAlert() {
        var inputText = ""
        // get prompts.xml view
        val li = LayoutInflater.from(this)
        val promptsView = li.inflate(R.layout.prompts, null)

        val alertDialogBuilder = AlertDialog.Builder(
            this
        )

        // set prompts.xml to alertdialog builder
        alertDialogBuilder.setView(promptsView)

        val userInput = promptsView.findViewById(R.id.editTextDialogUserInput) as EditText

        // set dialog message
        alertDialogBuilder
            .setCancelable(false)
            .setPositiveButton(
                "OK"
            ) { _, _ ->
                // get user input and set it to result
                // edit text
                URL = userInput.text.toString()
                val db = getDB(this)
                db.delete("Local", "",null)
                val values = ContentValues()
                values.put("URL", URL)
                db.insert("Local", null, values)
                db.close()
                txtURL.text = URL
            }
            .setNegativeButton(
                "Cancel"
            ) { dialog, _ ->
                dialog.cancel()
            }

        // create alert dialog
        val alertDialog = alertDialogBuilder.create()

        // show it
        alertDialog.show()
    }

    private fun getData() {
        val url = "${URL}index.php/?cedula=${et_cc.text}"
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
                    switchActivity(et_cc.text.toString(), client, status)
                } catch (e: JSONException) {
                    e.printStackTrace()
                    Toast.makeText(this, e.message, Toast.LENGTH_LONG).show()
                }
            }, Response.ErrorListener {
                Toast.makeText(this, "ERROR: $it", Toast.LENGTH_LONG).show()
            })
        queue.add(request)

    }


    private fun switchActivity(stringCc: String, client: Boolean, status: Int) {
        val it = Intent(this, RequestPriActivity::class.java)
        it.putExtra("t_cc", stringCc)
        it.putExtra("b_client", client)
        it.putExtra("status", status)
        startActivityForResult(it, 0)
    }

    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        if (requestCode == 0) {
            etCC.text.clear()
        }
    }

    companion object {
        var URL = "https://declarative-lots.000webhostapp.com/turns_generator/index.php/"
    }

}
