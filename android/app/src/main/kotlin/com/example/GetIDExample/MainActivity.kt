package com.example.GetIDExample
import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import android.app.Activity
import android.os.Bundle
import com.sdk.getidlib.config.ConfigurationPreset
import com.sdk.getidlib.config.FlowScreens
import com.sdk.getidlib.config.GetIDFactory
import com.sdk.getidlib.config.VerificationTypesEnum
import java.util.*

class MainActivity: FlutterActivity() {
    private val CHANNEL = "samples.getid.dev/getid"

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
    super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler {
            call, result ->
            if (call.method == "launchGetID") {
                val token: String? = call.argument("token")
                val apiURL: String? = call.argument("apiURL")
                launchGetID(token!!, apiURL!!)
                result.success(true)
            } else {
                result.notImplemented()
            }
        }
    }

    private fun launchGetID(token: String, apiURL: String) {
        val config = ConfigurationPreset().apply {
            flowItems = listOf(
                FlowScreens.SCREEN_CONSENT,
                FlowScreens.SCREEN_DOCUMENT,
                FlowScreens.SCREEN_SELFIE
            )
            verificationTypes =
                arrayListOf(
                    VerificationTypesEnum.FACE_MATCHING,
                    VerificationTypesEnum.DATA_EXTRACTION
                )
        }
        val getIDFactory = GetIDFactory()
        getIDFactory.setup(
            applicationContext, config, token, apiURL, listOf(
                Locale.ENGLISH
            )
        )
    }
}