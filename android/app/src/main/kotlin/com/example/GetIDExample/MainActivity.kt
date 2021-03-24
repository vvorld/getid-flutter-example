package com.example.GetIDExample
import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import android.app.Activity
import android.os.Bundle
import com.sdk.getidlib.config.GetIDSDK
import com.sdk.getidlib.model.app.auth.Token
import java.util.*

class MainActivity: FlutterActivity() {
    private val CHANNEL = "samples.getid.dev/getid"

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
    super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler {
            call, result ->
            if (call.method == "launchGetID") {
                val apiURL: String? = call.argument("apiURL")
                val token: String? = call.argument("token")
                val flowName: String? = call.argument("flowName")
                launchGetID(apiURL!!, token!!, flowName!!)
                result.success(true)
            } else {
                result.notImplemented()
            }
        }
    }

    private fun launchGetID(apiURL: String, token: String, flowName: String) {
        GetIDSDK().startVerificationFlow(
            context = applicationContext,
            apiUrl = apiURL,
            auth = Token(token),
            flowName = flowName
        )
    }
}