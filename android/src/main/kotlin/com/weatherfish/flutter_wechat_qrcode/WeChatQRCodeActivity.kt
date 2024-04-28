package com.weatherfish.flutter_wechat_qrcode;

import android.content.Intent
import android.util.Log
import com.king.mlkit.vision.camera.AnalyzeResult
import com.king.wechat.qrcode.scanning.WeChatCameraScanActivity
import java.util.ArrayList

class WeChatQRCodeActivity : WeChatCameraScanActivity() {
    companion object{
        const val TAG = "WeChatQRCodeActivity"
    }

    override fun onScanResultCallback(result: AnalyzeResult<List<String>>) {
        if(result.result.isNotEmpty()){
            cameraScan.setAnalyzeImage(false)
            val intent = Intent()
            intent.putStringArrayListExtra("result", result.result as ArrayList<String>?)
            setResult(RESULT_OK,intent)
            finish()
        }
    }
}