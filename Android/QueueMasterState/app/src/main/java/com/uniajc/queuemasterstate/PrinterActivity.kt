package com.uniajc.queuemasterstate

import android.support.v7.app.AppCompatActivity
import android.os.Bundle
import android.bluetooth.BluetoothDevice
import android.bluetooth.BluetoothAdapter
import android.content.Intent
import android.widget.TextView
import android.widget.EditText
import android.bluetooth.BluetoothSocket
import android.os.Handler
import android.widget.Button
import java.io.IOException
import java.io.InputStream
import java.io.OutputStream
import java.util.*

class PrinterActivity : AppCompatActivity() {

    var bluetoothAdapter: BluetoothAdapter? = null
    lateinit var bluetoothSocket: BluetoothSocket
    lateinit var bluetoothDevice: BluetoothDevice

    lateinit var outputStream: OutputStream
    lateinit var inputStream: InputStream
    lateinit var thread: Thread

    lateinit var readBuffer: ByteArray
    var readBufferPosition: Int = 0
    @Volatile
    var stopWorker: Boolean = false

    lateinit var lblPrinterName: TextView
    lateinit var textBox: EditText
    lateinit var stringTurn:String
    lateinit var nombre: EditText

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_printer)

        //stringTurn = intent.getStringExtra("turn")

        // Create object of controls
        val btnConnect = findViewById<Button>(R.id.btnConnect)
        val btnDisconnect = findViewById<Button>(R.id.btnDisconnect)
        val btnPrint = findViewById<Button>(R.id.btnPrint)

        textBox = findViewById(R.id.txtText)
        nombre = findViewById(R.id.et_nombre)

        lblPrinterName = findViewById(R.id.lblPrinterName)

        btnConnect.setOnClickListener {
            try {
                findBluetoothDevice()
                val handler = Handler()
                handler.postDelayed({
                    // Actions to do after 3 seconds
                    openBluetoothPrinter()
                }, 3000)


            } catch (ex: Exception) {
                ex.printStackTrace()
            }
        }
        btnDisconnect.setOnClickListener {
            try {
                disconnectBT()
            } catch (ex: Exception) {
                ex.printStackTrace()
            }
        }
        btnPrint.setOnClickListener {
            try {
                printData()
            } catch (ex: Exception) {
                ex.printStackTrace()
            }
        }

    }

    private fun findBluetoothDevice() {
        try {
            bluetoothAdapter = BluetoothAdapter.getDefaultAdapter()
            if (bluetoothAdapter == null) {
                lblPrinterName.text = "No Bluetooth Adapter found"
            }
            if (bluetoothAdapter!!.isEnabled) {
                val enableBT = Intent(BluetoothAdapter.ACTION_REQUEST_ENABLE)
                startActivityForResult(enableBT, 0)
            }

            val pairedDevice = bluetoothAdapter!!.bondedDevices

            if (pairedDevice.size > 0) {
                var text = "No se encuentra"
                for (pairedDev in pairedDevice) {

                    //Name
                    if (pairedDev.name == nombre.toString()) {
                        bluetoothDevice = pairedDev
                        text = "Bluetooth Printer Attached: " + pairedDev.name
                        break
                    }
                }
                lblPrinterName.text = text
            }
            else{
                lblPrinterName.text = "No hay dispositivos vinculados"
            }
        } catch (ex: Exception) {
            ex.printStackTrace()
            lblPrinterName.text = "Error trayendo impresora"
        }

    }

    // Open Bluetooth Printer

    @Throws(IOException::class)
    fun openBluetoothPrinter() {
        try {

            //Standard uuid from string //
            val uuidSting = UUID.fromString("00001101-0000-1000-8000-00805f9b34fb")
            bluetoothSocket = bluetoothDevice.createRfcommSocketToServiceRecord(uuidSting)
            bluetoothSocket.connect()
            outputStream = bluetoothSocket.outputStream
            inputStream = bluetoothSocket.inputStream

            beginListenData()

        } catch (ex: Exception) {
            ex.printStackTrace()
            lblPrinterName.text = "Error conectando"
        }

    }

    private fun beginListenData() {
        try {

            val handler = Handler()
            val delimiter: Byte = 10
            stopWorker = false
            readBufferPosition = 0
            readBuffer = ByteArray(1024)

            thread = Thread(Runnable {
                while (!Thread.currentThread().isInterrupted && !stopWorker) {
                    try {
                        val byteAvailable = inputStream.available()
                        if (byteAvailable > 0) {
                            val packetByte = ByteArray(byteAvailable)
                            inputStream.read(packetByte)

                            for (i in 0 until byteAvailable) {
                                val b = packetByte[i]
                                if (b == delimiter) {
                                    val encodedByte = ByteArray(readBufferPosition)
                                    System.arraycopy(
                                        readBuffer, 0,
                                        encodedByte, 0,
                                        encodedByte.size
                                    )
                                    val data = String(encodedByte, charset("US-ASCII"))
                                    readBufferPosition = 0
                                    handler.post(Runnable { lblPrinterName.text = data })
                                } else {
                                    readBuffer[readBufferPosition++] = b
                                }
                            }
                        }
                    } catch (ex: Exception) {
                        stopWorker = true
                    }
                }
            })

            thread.start()
        } catch (ex: Exception) {
            ex.printStackTrace()
        }

    }

    // Printing Text to Bluetooth Printer //
    @Throws(IOException::class)
    private fun printData() {
        try {
            var msg = textBox.text.toString()
            msg += "\n"
            outputStream.write(msg.toByteArray())
            lblPrinterName.text = "Printing Text..."
        } catch (ex: Exception) {
            ex.printStackTrace()
        }

    }

    // Disconnect Printer //
    @Throws(IOException::class)
    private fun disconnectBT() {
        try {
            stopWorker = true
            outputStream.close()
            inputStream.close()
            bluetoothSocket.close()
            lblPrinterName.text = "Printer Disconnected."
        } catch (ex: Exception) {
            ex.printStackTrace()
        }

    }
}
