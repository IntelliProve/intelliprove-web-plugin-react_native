package com.intelliproverxpoc

import android.content.Context
import com.facebook.react.bridge.JavaScriptModule
import com.facebook.react.bridge.ReactApplicationContext
import com.facebook.react.bridge.ReactContextBaseJavaModule
import com.facebook.react.bridge.ReactMethod
import com.facebook.react.modules.core.DeviceEventManagerModule
import com.intelliprove.webview.IntelliWebViewActivity
import com.intelliprove.webview.IntelliWebViewDelegate

class WebViewModule(reactContext: ReactApplicationContext) : ReactContextBaseJavaModule(reactContext), IntelliWebViewDelegate,
    JavaScriptModule {
    override fun getName(): String {
        return "WebViewModule"
    }

    @ReactMethod
    fun presentWebView(urlString: String) {
        currentActivity?.let {
            IntelliWebViewActivity.start(it, urlString, this)
        }
    }

    override fun didReceivePostMessage(postMessage: String) {
        reactApplicationContext
            .getJSModule(DeviceEventManagerModule.RCTDeviceEventEmitter::class.java)
            .emit("IntelliWebViewPostMessage", postMessage)
    }
}