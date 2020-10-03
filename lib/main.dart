import 'dart:async';
import 'package:chatty/services/_connect.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import './config/app_config.dart' as config;
import 'account/auth/_signin.dart';
import 'model/member.dart';
import 'navigationbar.dart';
import 'route_page.dart';
import 'services/_auth.dart';
import 'services/_notification.dart';

import 'package:google_map_location_picker/generated/l10n.dart' as location_picker;


void main()  {
  runApp(myApp());
}

class myApp extends StatelessWidget {
  @override
  Widget build(BuildContext context)  {
    //mContext = context;
    return MaterialApp(
      home : SplashScreen(),
      title: 'Chatty',
      initialRoute: '/',

      // localizationsDelegates: const [
      //   location_picker.S.delegate,
      // ],
      // supportedLocales: const <Locale>[
      //   Locale('en', ''),
      //   Locale('th', ''),
      // ],

      onGenerateRoute: RouteGenerator.generateRoute,
      debugShowCheckedModeBanner: false,

      darkTheme: ThemeData(
        fontFamily: 'Prompt',
        primaryColor: Color(0xFF252525),
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Color(0xFF2C2C2C),
        accentColor: config.Colors().mainDarkColor(1),
        hintColor: config.Colors().secondDarkColor(1),
        focusColor: config.Colors().accentDarkColor(1),
        backgroundColor: Colors.white,
        textTheme: TextTheme(
          button: TextStyle(color: Color(0xFF252525)),
          headline: TextStyle(fontSize: 20.0, color: config.Colors().secondDarkColor(1)),
          display1: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w200, color: config.Colors().secondDarkColor(1)),
          display2: TextStyle(fontSize: 13.0, fontWeight: FontWeight.w300, color: config.Colors().secondDarkColor(1)),
          display3: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w400, color: config.Colors().mainDarkColor(1)),
          display4: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w500, color: config.Colors().secondDarkColor(1)),
          subhead: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w500, color: config.Colors().secondDarkColor(1)),
          title: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600, color: config.Colors().secondDarkColor(1)),
          body1: TextStyle(fontSize: 12.0, color: config.Colors().secondDarkColor(1)),
          body2: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w600, color: config.Colors().secondDarkColor(1)),
          caption: TextStyle(fontSize: 12.0, color: config.Colors().secondDarkColor(0.7)),
          subtitle: TextStyle(fontSize: 12.0, color: config.Colors().secondDarkColor(0.7)),
        ),
      ),

      theme: ThemeData(
        fontFamily: 'Prompt',
        primaryColor: Colors.white,
        brightness: Brightness.light,
        accentColor: config.Colors().mainColor(1),
        focusColor: config.Colors().accentColor(1),
        hintColor: config.Colors().secondColor(1),
        backgroundColor: Colors.white,
        textTheme: TextTheme(
          button: TextStyle(color: Colors.white),
          headline: TextStyle(fontSize: 20.0, color: config.Colors().secondColor(1)),
          display1: TextStyle(fontSize: 10.0, fontWeight: FontWeight.w200, color: config.Colors().secondColor(1)),
          display2: TextStyle(fontSize: 11.0, fontWeight: FontWeight.w300, color: config.Colors().secondColor(1)),
          display3: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w400, color: config.Colors().secondColor(1)),
          display4: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w400, color: config.Colors().secondColor(1)),
          subhead: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w500, color: config.Colors().secondColor(1)),
          title: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w600, color: config.Colors().secondColor(1)),
          body1: TextStyle(fontSize: 12.0, color: config.Colors().secondColor(1)),
          body2: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w600, color: config.Colors().secondColor(1)),
          caption: TextStyle(fontSize: 12.0, color: config.Colors().secondColor(0.6)),
          subtitle: TextStyle(fontSize: 12.0, color: config.Colors().secondDarkColor(0.7)),
        ),
      ),

    );
  }

}


class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() =>
      _SplashScreenState();
}


class _SplashScreenState
    extends State<SplashScreen> {
  @override


  void _Navigator() async {

    // FirebaseAuth _auth = FirebaseAuth.instance;
    //

      var value = firebaseCon.auth_.currentUser;

      if(value != null){

          Member.myUid = value.uid;
          Member.myName = value.displayName;
          Member.photoUrl = value.photoURL;

          //NotificationService().registerNotification();
          NotificationService().configureDidReceiveLocal();

          await AuthService().loadUserInfo(value);

          Navigator.of(context).pushReplacement(
          PageRouteBuilder(pageBuilder: (_, __, ____) => TabsWidget(
            currentTab: 0,
              )
            )
          );
        }
        else{
          Navigator.of(context).pushReplacement(PageRouteBuilder(
          pageBuilder: (_, __, ___) => new SignInWidget())
          );
        }



  }

  /// Set timer SplashScreenTemplate1
  _timer() async {
    return Timer(Duration(milliseconds: 2300), _Navigator);
  }



  @override
  void initState() {

    Firebase.initializeApp().whenComplete(() {
      print("completed");
      // setState(() {
      _timer();
      // registerNotification();
      // configLocalNotification();
      // });
    });

    super.initState();

  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                    "assets/images/logo/rectangle.png"
                ),
                fit: BoxFit.fill)
             ),
        child: Center(
          child: Container(
          width: 130,
          height: 150,
          child: Image(
            image: AssetImage("assets/images/logo/logo-2.png"),
            fit: BoxFit.fill,
          ),
        ),
      ),
      )
    );
  }
  
}
