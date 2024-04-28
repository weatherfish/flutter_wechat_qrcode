package com.weatherfish.flutter_wechat_qrcode

import android.app.Activity
import android.content.Intent
import android.graphics.BitmapFactory
import com.king.wechat.qrcode.WeChatQRCodeDetector
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.FlutterPlugin.FlutterPluginBinding
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.PluginRegistry.ActivityResultListener
import org.opencv.OpenCV

/**
 * FlutterWechatQrcodePlugin
 */
class FlutterWechatQrcodePlugin : FlutterPlugin, MethodCallHandler,
    ActivityAware, ActivityResultListener {
    private var channel: MethodChannel? = null
    private var curActivity: Activity? = null
    private var pendingResult: MethodChannel.Result? = null
    private var activityPluginBinding: ActivityPluginBinding? = null
    override fun onAttachedToEngine(flutterPluginBinding: FlutterPluginBinding) {
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "flutter_wechat_qrcode")
        channel!!.setMethodCallHandler(this)

        //初始化OpenCV
        OpenCV.initAsync(flutterPluginBinding.applicationContext)
        //初始化WeChatQRCodeDetector
        WeChatQRCodeDetector.init(flutterPluginBinding.applicationContext)
    }

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        when (call.method) {
            "getPlatformVersion" -> {
                result.success("Android ${android.os.Build.VERSION.RELEASE}")
            }

            "scanImage" -> {
                val path = call.argument<String>("path")
                val bitmap = BitmapFactory.decodeFile(path)
                val results = WeChatQRCodeDetector.detectAndDecode(bitmap)
                result.success(results)
            }

            "scanCamera" -> {
                pendingResult = result
                val intent = Intent(curActivity, WeChatQRCodeActivity::class.java);
                curActivity?.startActivityForResult(intent, RC_BARCODE_CAPTURE);
            }

            else -> {
                result.notImplemented()
            }
        }
    }

    override fun onDetachedFromEngine(binding: FlutterPluginBinding) {
        channel!!.setMethodCallHandler(null)
    }

    override fun onAttachedToActivity(binding: ActivityPluginBinding) {
        curActivity = binding.activity
        activityPluginBinding = binding
        binding.addActivityResultListener(this)
    }
    override fun onDetachedFromActivityForConfigChanges() {}
    override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {}
    override fun onDetachedFromActivity() {
        activityPluginBinding?.removeActivityResultListener(this)
    }
    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?): Boolean {
        if (requestCode == RC_BARCODE_CAPTURE) {
            if (resultCode == Activity.RESULT_OK) {
                try {
                    val results = data!!.getStringArrayListExtra("result")
                    pendingResult?.success(results)
                } catch (exp: Exception) {
                    exp.printStackTrace()
                    pendingResult?.success(null)
                }
            } else {
                pendingResult?.success(null)
            }
            return true
        }
        return false
    }

    companion object {
        private const val RC_BARCODE_CAPTURE = 8901
    }
}
