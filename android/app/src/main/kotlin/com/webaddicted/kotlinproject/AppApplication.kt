package com.webaddicted.kotlinproject

import io.flutter.app.FlutterApplication
import io.flutter.plugin.common.PluginRegistry
import io.flutter.plugins.GeneratedPluginRegistrant
import com.facebook.FacebookSdk

/**
 * Created by Deepak Sharma(Webaddicted) on 05-05-2020.
 */
class AppApplication : FlutterApplication(){
    override fun onCreate() {
        super.onCreate()
//        FirebaseApp.initializeApp(this)
        FacebookSdk.sdkInitialize(this)

    }

//    override fun registerWith(registry: PluginRegistry?) {
//        GeneratedPluginRegistrant.registerWith(registry)
//    }

}