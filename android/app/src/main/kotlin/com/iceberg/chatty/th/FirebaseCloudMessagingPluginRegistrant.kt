package com.iceberg.chatty.th

import com.dexterous.flutterlocalnotifications.FlutterLocalNotificationsPlugin
import io.flutter.Log
import io.flutter.plugin.common.PluginRegistry
import io.flutter.plugins.firebasemessaging.FirebaseMessagingPlugin

class FirebaseCloudMessagingPluginRegistrant {

    companion object {

        fun registerWith(registry: PluginRegistry) {
            if (alreadyRegisteredWith(registry)) {
//                Log.d("Local Plugin", "Already Registered");
                return
            }
//            FirebaseMessagingPlugin
//            FlutterLocalNotificationsPlugin

            FirebaseMessagingPlugin.registerWith(registry.registrarFor("io.flutter.plugins.firebasemessaging.FirebaseMessagingPlugin"));
            FlutterLocalNotificationsPlugin.registerWith(registry.registrarFor("com.dexterous.flutterlocalnotifications.FlutterLocalNotificationsPlugin"));


//            FlutterLocalNotificationsPlugin.registerWith(registry.registrarFor("io.flutter.plugins.firebombing.FirebaseMessagingPlugin"))
//            FirebaseMessagingPlugin.registerWith(registry.registrarFor("io.flutter.plugins.firebasemessaging.FirebaseMessagingPlugin"))
//            Log.d("Local Plugin", "Registered");
        }

        private fun alreadyRegisteredWith(registry: PluginRegistry): Boolean {
            val key = FirebaseCloudMessagingPluginRegistrant::class.java.canonicalName
            if (registry.hasPlugin(key)) {
                return true
            }
            registry.registrarFor(key)
            return false
        }

    }
}

//object FirebaseCloudMessagingPluginRegistrant {
//    fun registerWith(registry: PluginRegistry) {
//        if (alreadyRegisteredWith(registry)) {
//            return
//        }
//        FirebaseMessagingPlugin.registerWith(registry.registrarFor("io.flutter.plugins.firebasemessaging.FirebaseMessagingPlugin"))
//    }
//
//    private fun alreadyRegisteredWith(registry: PluginRegistry): Boolean {
//        val key = FirebaseCloudMessagingPluginRegistrant::class.java.canonicalName
//        if (registry.hasPlugin(key)) {
//            return true
//        }
//        registry.registrarFor(key)
//        return false
//    }
//}