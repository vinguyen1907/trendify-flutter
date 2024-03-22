package com.example.ecommerce_app
import io.flutter.embedding.android.FlutterFragmentActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugins.GeneratedPluginRegistrant
import vn.zalopay.sdk.ZaloPayError
import vn.zalopay.sdk.ZaloPaySDK
import vn.zalopay.sdk.listeners.PayOrderListener
import io.flutter.plugin.common.MethodChannel
import android.content.Intent
import android.os.Bundle
import io.flutter.Log

class MainActivity: FlutterFragmentActivity() {
  override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        ZaloPaySDK.init(2554, vn.zalopay.sdk.Environment.SANDBOX); // Merchant AppID
    }

    override fun onNewIntent(intent: Intent) {
        super.onNewIntent(intent)
        Log.d("newIntent", intent.toString())
        ZaloPaySDK.getInstance().onResult(intent)
    }

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        GeneratedPluginRegistrant.registerWith(flutterEngine)
        val channelPayOrder = "flutter.native/channelPayOrder"
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, channelPayOrder)
        .setMethodCallHandler { call, result ->
        if (call.method == "payOrder"){
            val token = call.argument<String>("zptoken")
            ZaloPaySDK.getInstance().payOrder(this@MainActivity, token !!, "ecommerce://app",object: PayOrderListener {
                override fun onPaymentCanceled(zpTransToken: String?, appTransID: String?) {
                  result.success("User Canceled")
                }
                override fun onPaymentError(zaloPayErrorCode: ZaloPayError?, zpTransToken: String?, appTransID: String?) {
                  //Redirect to Zalo/ZaloPay Store when zaloPayError == ZaloPayError.PAYMENT_APP_NOT_FOUND
                  result.success("Payment failed")
                }
                override fun onPaymentSucceeded(transactionId: String, transToken: String, appTransID: String?) {
                  result.success("Payment Success")
                }
            })
        }
      }
    }


}
