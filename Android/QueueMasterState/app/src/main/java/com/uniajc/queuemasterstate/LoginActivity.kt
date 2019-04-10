package com.uniajc.queuemasterstate

import android.content.Intent
import android.support.v7.app.AppCompatActivity
import android.os.Bundle
import android.widget.*

class LoginActivity : AppCompatActivity() {

    private lateinit var stringCc: String

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_login)
        stringCc = ""
        val ed = findViewById<EditText>(R.id.et_cc)
        val button = findViewById<Button>(R.id.bt_sign_in)
        button.setOnClickListener {
            stringCc = ed.text.toString()
            if(checkInf(stringCc)){
                val it = Intent(this, MainActivity::class.java)
                it.putExtra("t_cc",stringCc)
                startActivity(it)
            }
            else{
                Toast.makeText(this,"Cedula no registrada en los turnos actuales, por favor vuelva a intentar", Toast.LENGTH_LONG).show()
            }
        }
    }

    fun checkInf(cc: String):Boolean{
        return true
    }
}
