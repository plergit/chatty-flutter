

import 'dart:convert';
import 'dart:io';

import 'package:chatty/model/member.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';


import '_connect.dart';

class NotificationService {


  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();


  void configureDidReceiveLocal()  async {

    var android = new AndroidInitializationSettings('@drawable/ic_noti');
    var iOS = new IOSInitializationSettings();

    var initializationSettings = new InitializationSettings(android, iOS);
    _flutterLocalNotificationsPlugin.initialize(initializationSettings, onSelectNotification: onSelectNotification);

      if (Platform.isIOS) {
        _firebaseMessaging.requestNotificationPermissions(
            const IosNotificationSettings(sound: true, badge: true, alert: true,provisional: true,)
        );
        _firebaseMessaging.onIosSettingsRegistered
            .listen((IosNotificationSettings settings) {
          print("Settings registered: $settings");
        });
        // _firebaseMessaging.requestNotificationPermissions(IosNotificationSettings());
      }


      _firebaseMessaging.configure(onMessage: (Map<String, dynamic> message) async {

        print("onMessage tetkilendi: $message");
        //sendNotification();
      },
      onBackgroundMessage: Platform.isIOS?null:isBackgroundMessageHandler,
        // onBackgroundMessage: (Map<String, dynamic> message) async {
//print("onBackgroundMessage: $message");

        //   sendNotification();
        //
        // },
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch tetiklendi: $message");
        //sendNotification();
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume tetiklendi: $message");
        //sendNotification();
      },
    );


    if(firebaseCon.auth_.currentUser.uid != null){

      var _platform = "Android";
      if(Platform.isIOS){
        _platform = "IOS";
      }

    _firebaseMessaging.getToken().then((token) {

      print(token.toString());

        firebaseCon.firestore_
            .collection('Members')
            .doc(Member.myUid)
            .update({'pushToken': {
              "Token":token,
              "Platform":_platform
        }});
      }).catchError((err) {
        print(err.message.toString());
      });
    }


  }




  Future onDidReceiveLocalNotification(int id, String title, String body, String payload) async {
    // display a dialog with the notification details, tap ok to go to another page

    print(" Notification payload ");

  }

  Future onSelectNotification(String payload) async {

    if (payload != null) {
//    debugPrint('notification payload: ' + payload);
    }

    print(" Notification ---- message: ");

//  await Navigator.push(mContext,
//    new MaterialPageRoute(builder: (context) => new SecondScreen(payload) ),
//  );

  }

  Future showNotificationWithDefaultSound(String title, String message) async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'dexterous.com.flutter.local_notifications', 'channel_name', 'channel_description',
        importance: Importance.Max, priority: Priority.High);
    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics
    );
    await _flutterLocalNotificationsPlugin.show(
      0,
      '$title',
      '$message',
      platformChannelSpecifics,
      payload: 'Default_Sound',
    );
  }




  sendNotification() async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails('10000',
        'FLUTTER_NOTIFICATION_CHANNEL', 'FLUTTER_NOTIFICATION_CHANNEL_DETAIL',
        importance: Importance.Max, priority: Priority.High);
    var iOSPlatformChannelSpecifics = IOSNotificationDetails();

    var platformChannelSpecifics = NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);

    await _flutterLocalNotificationsPlugin.show(111, 'Hello.',
        'This is a your notifications. ', platformChannelSpecifics,
        payload: 'I just haven\'t Met You Yet');
  }



  static Future<dynamic> isBackgroundMessageHandler(Map<String, dynamic> message) {
    print("_backgroundMessageHandler");
    if (message.containsKey('data'))  {
      // Handle data message
      final dynamic data = message['data'];

      //NotificationService().sendNotification();

      print("_backgroundMessageHandler data: ${data}");
    }

    if (message.containsKey('notification')) {
      // Handle notification message
      // NotificationService().sendNotification();
      final dynamic notification = message['notification'];

      //NotificationService().sendNotification();

        print("_backgroundMessageHandler notification: ${notification}");
      }
    }



  }