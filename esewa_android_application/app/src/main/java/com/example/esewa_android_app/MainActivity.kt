package com.example.esewa_android_app

import android.content.Intent
import android.os.Bundle
import androidx.activity.enableEdgeToEdge
import androidx.appcompat.app.AppCompatActivity
import androidx.core.view.ViewCompat
import androidx.core.view.WindowInsetsCompat
import com.example.esewa_android_app.utils.UuidHelper
import com.getkeepsafe.relinker.BuildConfig
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.embedding.engine.FlutterEngineCache
import io.flutter.embedding.engine.dart.DartExecutor
import io.flutter.plugin.common.MethodChannel


class MainActivity : AppCompatActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        enableEdgeToEdge()
        setContentView(R.layout.activity_main)
        ViewCompat.setOnApplyWindowInsetsListener(findViewById(R.id.main)) { v, insets ->
            val systemBars = insets.getInsets(WindowInsetsCompat.Type.systemBars())
            v.setPadding(systemBars.left, systemBars.top, systemBars.right, systemBars.bottom)
            insets
        }

        // create and warm up the flutter engine
        val flutterEngine = FlutterEngine(this)
        flutterEngine.dartExecutor.executeDartEntrypoint(
            DartExecutor.DartEntrypoint.createDefault()
        )


        // cache the engine so any activity can use it
        FlutterEngineCache
            .getInstance()
            .put("android_flutter_engine", flutterEngine)

        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            "com.example.esewa/config"
        ).setMethodCallHandler { call, result ->
            if (call.method == "getConfig") {
                result.success(
                    mapOf(
                        "uuid" to UuidHelper.getSavedUuid(this),
                        "platform" to "android",
                        "environment" to "develop"
                    )
                )
            } else if (call.method == "selectedItem") {
                val rawArgs = call.arguments
                if (rawArgs is Map<*, *>) {
                    val item = rawArgs.entries.associate {
                        it.key.toString() to (it.value ?: "")
                    }
                    runOnUiThread {
                        val intent = Intent(this, SelectedItemActivity::class.java).apply {
                            putExtra("title", item["title"].toString())
                            putExtra("category", item["category"].toString())
                            putExtra("description", item["description"].toString())
                            putExtra("price", item["price"].toString())
                            putExtra("image", item["image"].toString())
                            //  clear Flutter activity from back stack
                            flags = Intent.FLAG_ACTIVITY_CLEAR_TOP or Intent.FLAG_ACTIVITY_NEW_TASK
                        }
                        startActivity(intent)
                    }
                }
                result.success(null)
            } else {
                result.notImplemented()
            }
        }


        val savedUuid = UuidHelper.getSavedUuid(this)
        // simple navigation
        if (savedUuid.isNullOrEmpty()) {
            // navigate and clear back stack (can't go back)
            startActivity(Intent(this, LoginActivity::class.java).apply {
                flags = Intent.FLAG_ACTIVITY_NEW_TASK or Intent.FLAG_ACTIVITY_CLEAR_TASK
            })
        } else {
            startActivity(
                FlutterActivity
                    .withCachedEngine("android_flutter_engine")
                    .build(this)
            )
        }
    }
}