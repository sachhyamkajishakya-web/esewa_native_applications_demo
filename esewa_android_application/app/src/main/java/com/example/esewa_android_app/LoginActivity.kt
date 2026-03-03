package com.example.esewa_android_app

import android.os.Bundle
import android.text.Editable
import android.text.TextWatcher
import android.util.Log
import android.widget.Button
import android.widget.EditText
import androidx.activity.enableEdgeToEdge
import androidx.appcompat.app.AppCompatActivity
import androidx.core.view.ViewCompat
import androidx.core.view.WindowInsetsCompat
import com.example.esewa_android_app.utils.DialogHelper
import com.example.esewa_android_app.utils.UuidHelper
import com.google.android.material.textfield.TextInputLayout
import java.util.regex.Pattern
import kotlin.text.Typography.bullet

class LoginActivity : AppCompatActivity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        enableEdgeToEdge()
        setContentView(R.layout.activity_login)
        ViewCompat.setOnApplyWindowInsetsListener(findViewById(R.id.main)) { v, insets ->
            val systemBars = insets.getInsets(WindowInsetsCompat.Type.systemBars())
            v.setPadding(systemBars.left, systemBars.top, systemBars.right, systemBars.bottom)
            insets
        }
        val username = findViewById<EditText>(R.id.username)
        val password = findViewById<EditText>(R.id.password)
        val usernameInputLayout = findViewById<TextInputLayout>(R.id.usernameInputLayout)
        val passwordInputLayout = findViewById<TextInputLayout>(R.id.passwordInputLayout)
        val loginButton = findViewById<Button>(R.id.login_button)

        //  remove the error message when username is being changed
        username.addTextChangedListener(object : TextWatcher {
            override fun beforeTextChanged(s: CharSequence?, start: Int, count: Int, after: Int) {}

            override fun onTextChanged(s: CharSequence?, start: Int, before: Int, count: Int) {

                usernameInputLayout.error = null
            }

            override fun afterTextChanged(s: Editable?) {}
        })
        //  remove the error message when password is being changed
        password.addTextChangedListener(object : TextWatcher {
            override fun beforeTextChanged(s: CharSequence?, start: Int, count: Int, after: Int) {}

            override fun onTextChanged(s: CharSequence?, start: Int, before: Int, count: Int) {
                passwordInputLayout.error = null
            }

            override fun afterTextChanged(s: Editable?) {}
        })

        loginButton.setOnClickListener {
            val savedUuid = UuidHelper.getSavedUuid(this)
            if (savedUuid.isNullOrEmpty()) {
                if (checkUsernameAndPassword(
                        usernameInputLayout,
                        passwordInputLayout,
                        username,
                        password
                    )
                ) {
                    Log.d(null, "Valid username and password")
                    UuidHelper.generateAndSaveRandomUuidInSharedPreference(this)
                }
            } else {
                // start flutter activity
                Log.d(null, "starting flutter activity")
            }

        }
    }

    private fun checkUsernameAndPassword(
        usernameInputLayout: TextInputLayout,
        passwordInputLayout: TextInputLayout,
        username: EditText,
        password: EditText
    ): Boolean {
        val usernameText = username.text.toString()
        val passwordText = password.text.toString()
        if (usernameText.isEmpty()) {
            usernameInputLayout.error = getString(R.string.requiredUsernameValidationMessage)
            return false
        } else if (!(usernameText.matches("[a-zA-Z0-9 ]+".toRegex()))) {
            usernameInputLayout.error = getString(R.string.invalidUsernameValidationMessage)
            return false
        } else if (usernameText.length !in 3..20) {
            usernameInputLayout.error = getString(R.string.usernameLengthValidationMessage)
        }
        if (password.text.isEmpty()) {
            passwordInputLayout.error = getString(R.string.requiredPasswordValidationMessage)
            return false
        } else if (!isPasswordValid(passwordText)) {
            passwordInputLayout.error =
                getString(
                    R.string.invalidPasswordErrorMessage,
                    bullet,
                    bullet,
                    bullet,
                    bullet,
                    bullet
                )
            return false
        }

        if (usernameText != "Demo Esewa User" && passwordText != "esewa2026@Demo") {
            DialogHelper.showAlertDialog(this)
            return false
        }
        return true
    }

    //function that checks validation for password regex
    fun isPasswordValid(password: String): Boolean {
        val passwordRegex = Pattern.compile(
            "^" +          // Start of the line
                    "(?=.*[0-9])" +    // At least 1 digit
                    "(?=.*[a-z])" +    // At least 1 lowercase letter
                    "(?=.*[A-Z])" +    // At least 1 uppercase letter
                    "(?=.*[!@#$%^&+=])" + // At least 1 special character (customize allowed chars as needed)
                    ".{8,}" +          // At least 8 characters long
                    "$"                // End of the line
        )
        return passwordRegex.matcher(password).matches()
    }
}