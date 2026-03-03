package com.example.esewa_android_app.utils

import android.content.Context
import androidx.appcompat.app.AlertDialog

object DialogHelper {

    fun showAlertDialog(context: Context) {
        val builder = AlertDialog.Builder(context)
        builder.setTitle("Error")
        builder.setMessage("Invalid username and password")


        builder.setPositiveButton("OK") { dialog, which ->

            dialog.cancel()
        }


        // Create and show the dialog
        val dialog: AlertDialog = builder.create()
        dialog.show()

    }
}