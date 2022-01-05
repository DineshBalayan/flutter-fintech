package com.debut.sms_retriever

import android.Manifest
import android.accounts.AccountManager
import android.annotation.TargetApi
import android.app.Activity
import android.app.KeyguardManager
import android.content.*
import android.content.pm.PackageManager
import android.graphics.Bitmap
import android.graphics.BitmapFactory
import android.net.Uri
import android.os.Build
import android.provider.MediaStore
import android.util.Log
import android.view.WindowManager
import android.widget.Toast
import androidx.core.app.ActivityCompat
import com.google.android.gms.auth.api.Auth
import com.google.android.gms.auth.api.credentials.Credential
import com.google.android.gms.auth.api.credentials.HintRequest
import com.google.android.gms.auth.api.phone.SmsRetriever
import com.google.android.gms.common.api.CommonStatusCodes
import com.google.android.gms.common.api.GoogleApiClient
import com.google.android.gms.common.api.Status
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.PluginRegistry.ActivityResultListener
import io.flutter.plugin.common.PluginRegistry.Registrar

class SmsRetrieverPlugin : FlutterPlugin, MethodCallHandler, ActivityResultListener ,ActivityAware{

    var act:Activity?=null

    private lateinit var channel : MethodChannel


    private var receiver: MySMSBroadcastReceiver? = null
    var sms: String? = null
    var result: MethodChannel.Result? = null

    private var pendingHintResult: MethodChannel.Result? = null
    private var keyGuardResult: MethodChannel.Result? = null

    private val EMAIL_HINT_REQUEST = 117
    private val PHONE_HINT_REQUEST = 489
    private val KEY_GUARD_REQUEST = 65

   

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        when (call.method) {
            "requestPhoneHint" -> {
                requestPhoneHint(result)
            }
            "shareToWhatsApp" -> {
                shareToWhatsApp(call.argument<String>("path"), call.argument<String>("text"), result)
            }
            "getAppSignature" -> {
                val signature = AppSignatureHelper(act!!).getAppSignatures()[0]
                result.success(signature);
            }
            "startListening" -> {
                receiver = MySMSBroadcastReceiver()
                this.act!!.registerReceiver(receiver, IntentFilter(SmsRetriever.SMS_RETRIEVED_ACTION))
                startListening()
                this.result = result
            }
            "checkPermissions" -> {
                result.success(checkPermissions())
            }
            "hasCameraPermission" -> {
                result.success(checkCameraPermissions())
            }
            "hasContactPermission" -> {
                result.success(checkContactPermissions())
            }
            "unlockApp" -> {
                callKeyGuardIntent(result)
            }
            "isDeviceLocked" -> {
                result.success((this.act!!.getSystemService(Context.KEYGUARD_SERVICE) as KeyguardManager).isKeyguardSecure)
            }
            "stopListening" -> unregister(result)
            "keepScreenOn" -> onMethodCallTurnOn(call, result)
            else -> result.notImplemented()
        }
    }

    private fun onMethodCallTurnOn(call: MethodCall, result: MethodChannel.Result) {
        val window = act!!.window

        if (window == null) {
            result.error("not-found-activity", "Not found 'activity'.", null)
            return
        }

        val turnOn = call.argument<Boolean>("turnOn");
        if (turnOn == true) {
            window.addFlags(WindowManager.LayoutParams.FLAG_KEEP_SCREEN_ON)
        } else {
            window.clearFlags(WindowManager.LayoutParams.FLAG_KEEP_SCREEN_ON)
        }

        result.success(true);
    }

    private fun keepScreenOff() {

    }

    private fun callKeyGuardIntent(result: MethodChannel.Result) {
        keyGuardResult = result
        val km = this.act!!.getSystemService(Context.KEYGUARD_SERVICE) as KeyguardManager
        if (km.isKeyguardSecure) {
            var authIntent: Intent? = null
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP) {
                authIntent = km.createConfirmDeviceCredentialIntent(
                        "Unlock BankSathi", "Confirm your screen lock pattern, PIN, or password")
            }
            if (authIntent != null) {
                try {
                    this.act!!.startActivityForResult(authIntent, KEY_GUARD_REQUEST)
                } catch (e: Exception) {
                    e.printStackTrace()
                    result.error("0", "sported Filled", e.toString())
                }
            }
        } else {
            result.error("1", "Device Not Locked", null)
        }
    }


    private fun shareToWhatsApp(picPath: String?, text: String?, result: MethodChannel.Result) {
        val bitmap: Bitmap = BitmapFactory.decodeFile(picPath)
        val intent = Intent(Intent.ACTION_SEND)
        intent.type = "image/*"
        val path: String = MediaStore.Images.Media.insertImage(this.act!!?.contentResolver, bitmap, "ic_launcher_round", "null")
        val imageUri = Uri.parse(path)
        intent.putExtra(Intent.EXTRA_STREAM, imageUri)
        intent.putExtra(Intent.EXTRA_TEXT, text)
        intent.addFlags(Intent.FLAG_GRANT_READ_URI_PERMISSION)

        if (isPackageInstalled("com.whatsapp", this.act!!)) {
            intent.setPackage("com.whatsapp");
            this.act!!.startActivity(Intent.createChooser(intent, "Share Image"));
            result.success(true)
        } else {
            Toast.makeText(this.act!!, "Please Install Whatsapp", Toast.LENGTH_LONG).show()
            result.success(false)
        }
    }

    private fun isPackageInstalled(packagename: String, context: Context): Boolean {
        val pm = context.packageManager
        return try {
            pm.getPackageInfo(packagename, PackageManager.GET_ACTIVITIES)
            true
        } catch (e: PackageManager.NameNotFoundException) {
            false
        }
    }

    private fun checkPermissions(): Int {
        if (this.act!! == null) {
            throw ActivityNotFoundException()
        }
        val locationPermissionState = ActivityCompat.checkSelfPermission(act!!,
                Manifest.permission.ACCESS_FINE_LOCATION)

        return if (locationPermissionState == PackageManager.PERMISSION_GRANTED) {
            1
        } else if (!ActivityCompat.shouldShowRequestPermissionRationale(act!!, Manifest.permission.ACCESS_FINE_LOCATION)) {
            2
        } else {
            0
        }

    }

    private fun checkContactPermissions(): Int {
        if (this.act!! == null) {
            throw ActivityNotFoundException()
        }
        val locationPermissionState = ActivityCompat.checkSelfPermission(act!!,
                Manifest.permission.READ_CONTACTS)

        return if (locationPermissionState == PackageManager.PERMISSION_GRANTED) {
            1
        } else {
            0
        }
    }

    private fun checkCameraPermissions(): Int {
        if (this.act!! == null) {
            throw ActivityNotFoundException()
        }
        val cameraPermission = ActivityCompat.checkSelfPermission(act!!,
                Manifest.permission.CAMERA)

        val microPhonePermission = ActivityCompat.checkSelfPermission(act!!,
                Manifest.permission.RECORD_AUDIO)


        return if (cameraPermission == PackageManager.PERMISSION_GRANTED) {
            if (microPhonePermission == PackageManager.PERMISSION_GRANTED) {
                1
            } else if (!ActivityCompat.shouldShowRequestPermissionRationale(act!!, Manifest.permission.RECORD_AUDIO)) {
                2
            } else {
                0
            }
        } else if (!ActivityCompat.shouldShowRequestPermissionRationale(act!!, Manifest.permission.CAMERA)) {
            2
        } else {
            0
        }

    }


    private fun startListening() {
        val client = SmsRetriever.getClient(this.act!! /* context */)
        val task = client.startSmsRetriever()
        task.addOnSuccessListener {
            Log.e(javaClass::getSimpleName.name, "task started")
        }
        task.addOnFailureListener {
            Log.e(javaClass::getSimpleName.name, "task starting failed")
        }


    }

    private fun unregister(result: MethodChannel.Result) {
        try {
            this.act!!.unregisterReceiver(receiver)
        } catch (e: Exception) {
        } finally {
            result.success(true)
        }
    }

    inner class MySMSBroadcastReceiver : BroadcastReceiver() {


        override fun onReceive(context: Context, intent: Intent) {
            if (SmsRetriever.SMS_RETRIEVED_ACTION == intent.action) {
                val extras = intent.extras
                val status = extras!!.get(SmsRetriever.EXTRA_STATUS) as Status

                when (status.statusCode) {
                    CommonStatusCodes.SUCCESS -> {
                        // Get SMS message contents
                        sms = extras.get(SmsRetriever.EXTRA_SMS_MESSAGE) as String
                        try {
                            result?.success(sms)
                        } catch (e: java.lang.Exception) {
                        }
                    }
                    CommonStatusCodes.TIMEOUT -> {
                    }
                }
            }
        }
    }

    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?): Boolean {
        if (requestCode == PHONE_HINT_REQUEST && data != null) {
            if (resultCode == Activity.RESULT_OK) {
                val credential: Credential? = data.getParcelableExtra(Credential.EXTRA_KEY) as Credential?
                val phoneNumber = credential?.id
                pendingHintResult?.success(phoneNumber)
            } else {
                pendingHintResult?.success(null)
            }
            return true
        } else if (requestCode == EMAIL_HINT_REQUEST && data != null) {
            if (resultCode == Activity.RESULT_OK) {
                val accountType = data.getStringExtra(AccountManager.KEY_ACCOUNT_TYPE)
                val accountName = data.getStringExtra(AccountManager.KEY_ACCOUNT_NAME)
                pendingHintResult?.success(listOf(accountName, accountType))
            } else {
                pendingHintResult?.success(null)
            }
            return true
        } else if (requestCode == KEY_GUARD_REQUEST) {
            return if (resultCode == Activity.RESULT_OK) {
                Thread { runOnUiThread("true", true) }.start()
                true
            } else {
                runOnUiThread("false", false)
                false
            }
        }
        return false
    }

    private fun runOnUiThread(authStatets: String?, success: Boolean) {
        this.act!!.runOnUiThread {
            when {
                success -> {
                    keyGuardResult?.success(authStatets)
                }
                authStatets != null -> {
                    keyGuardResult?.error("2", authStatets, "Auth Failed")
                }
                else -> {
                    keyGuardResult?.notImplemented()
                }
            }
        }
    }


    @TargetApi(Build.VERSION_CODES.ECLAIR)
    fun requestPhoneHint(result: MethodChannel.Result) {
        pendingHintResult = result
        io.flutter.Log.d(ContentValues.TAG, "Account Picker on Activity Result phone hint")
        io.flutter.Log.d(ContentValues.TAG, PHONE_HINT_REQUEST.toString())
        val hintRequest = HintRequest.Builder()
                .setPhoneNumberIdentifierSupported(true)
                .build()
        val mCredentialsClient = GoogleApiClient.Builder(act!!)
                .addApi(Auth.CREDENTIALS_API)
                .build()
        val intent = Auth.CredentialsApi.getHintPickerIntent(
                mCredentialsClient, hintRequest)
        try {
            act!!.startIntentSenderForResult(intent.intentSender,
                    PHONE_HINT_REQUEST, null, 0, 0, 0)
        } catch (e: IntentSender.SendIntentException) {
            e.printStackTrace()
            io.flutter.Log.d(ContentValues.TAG, e.message!!)
        }
    }

    override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "sms_retriever")
        channel.setMethodCallHandler(this)
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }


    override fun onAttachedToActivity(binding: ActivityPluginBinding) {
        act = binding.activity
        binding.addActivityResultListener(this)
    }
    override fun onDetachedFromActivityForConfigChanges() {
        act = null;
    }
    override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
        act = binding.activity
        binding.addActivityResultListener(this)
    }
    override fun onDetachedFromActivity() {
        act = null;
    }

    
}

