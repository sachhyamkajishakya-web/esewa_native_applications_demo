package com.example.esewa_android_app.utils

import java.util.UUID
import android.content.Context
import android.content.SharedPreferences
import android.util.Log
import androidx.core.content.edit

object UuidHelper {
    fun generateAndSaveRandomUuidInSharedPreference(context: Context) {
        val generatedUuid = UUID.randomUUID().toString()
        Log.d(null, "generated uuid is ---> $generatedUuid")
        val sharedPrefs: SharedPreferences =
            context.getSharedPreferences("MyAppPrefs", Context.MODE_PRIVATE)
        sharedPrefs.edit {
            putString("user_uuid_key", generatedUuid)
            apply()
        }
    }

    fun getSavedUuid(context: Context): String? {
        val sharedPrefs: SharedPreferences =
            context.getSharedPreferences("MyAppPrefs", Context.MODE_PRIVATE)
        return sharedPrefs.getString("user_uuid_key", null)
    }
}
