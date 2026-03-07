package com.example.esewa_android_app

import android.os.Bundle
import android.widget.Button
import android.widget.RelativeLayout
import android.widget.TextView
import androidx.appcompat.app.AppCompatActivity
import com.bumptech.glide.Glide
import com.example.esewa_android_app.utils.DialogHelper

class SelectedItemActivity : AppCompatActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_selected_item)

        val title = intent.getStringExtra("title") ?: ""
        val category = intent.getStringExtra("category") ?: ""
        val description = intent.getStringExtra("description") ?: ""
        val price = intent.getStringExtra("price") ?: ""
        val image = intent.getStringExtra("image") ?: ""

        findViewById<TextView>(R.id.itemTitle).text = "$title"
        findViewById<TextView>(R.id.itemCategory).text = "$category"
        findViewById<TextView>(R.id.itemDescription).text = "$description"
        findViewById<TextView>(R.id.itemPrice).text = "Total Price: $$price"
        val loginButton = findViewById<Button>(R.id.payButton)

        // Load image from URL using Glide
        Glide.with(this)
            .load(image)
            .placeholder(android.R.drawable.ic_menu_gallery)
            .error(android.R.drawable.ic_menu_report_image)
            .centerCrop()
            .into(findViewById(R.id.itemImage))

        loginButton.setOnClickListener {
            DialogHelper.paymentConfirmAlertDialog(this);
        }
    }
}