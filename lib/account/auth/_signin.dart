import 'dart:convert';
import 'dart:io';

import 'package:apple_sign_in/apple_sign_in.dart';
import 'package:chatty/model/member.dart';
import 'package:chatty/services/_auth.dart';
import 'package:chatty/services/_connect.dart';
import 'package:chatty/services/_notification.dart';
import 'package:chatty/shared/ModalBottomSheet.dart';
import 'package:chatty/shared/widgets/popupLoading.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../config/app_config.dart' as config;
import '../../navigationbar.dart';
import '_forgot_password.dart';
import '_signup.dart';
import '_verify_by_phon.dart';
import 'package:flutter/services.dart';

import 'package:http/http.dart' as http;


class SignInWidget extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => new _LoginSignupPageState();
}

class _LoginSignupPageState extends State<SignInWidget> {


  Member _member = new Member.init();

  // FacebookLogin facebookLogin = FacebookLogin();
  GoogleSignIn googleSignIn = GoogleSignIn();

  final Future<bool> _isAvailableFuture = AppleSignIn.isAvailable();


  // Check if form is valid before perform login or signup

  var _user ;
  bool _recheckload = false;
  var _platform ;

  bool _validateEmail = false;
  bool _validatePassword = false;
  bool _showPassword = false;

  @override
  void initState() {

    if (Platform.isAndroid) {
      _platform = "Android";
    }
    else if(Platform.isIOS){
      _platform = "IOS";

      AppleSignIn.onCredentialRevoked.listen((_) {
        print("Credentials revoked");
      });

    }

//    checkAuth().then((value) => null)

    checkAuth().then((result) {
      setState(() {
        _user = result;

        if(_user != null){
          Navigator.pushReplacement(
              context, MaterialPageRoute( builder: (context) => TabsWidget(
              currentTab: 0,
            )
          ));
        }

        _recheckload = true;

      });
    });


    super.initState();
  }




  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {

    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    if (_recheckload == true && _user == null) {
      return new Scaffold(

        appBar: PreferredSize(
          preferredSize: Size.fromHeight(100.0),
          child: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            automaticallyImplyLeading: false, // hides leading widget
            flexibleSpace: Container(
                padding: EdgeInsets.only(left: 0 ,right: 0, top : MediaQuery.of(context).padding.top, bottom: 0),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Theme
                      .of(context)
                      .accentColor,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20)),
                ),
                child: Wrap(
                    direction: Axis.horizontal,
                    children: <Widget>[

                      Container(
                        height: 100,
                        width: 200,
                        padding: const EdgeInsets.only(left: 30,top: 10,bottom: 10),
                        child: Container(
                          margin: const EdgeInsets.only(left: 0,top: 0),
                          decoration: new BoxDecoration(
                            image: new DecorationImage(
                              image: new AssetImage(
                                  "assets/images/icons/icon-logo&text.png",
                              ),
                              fit: BoxFit.fitWidth,
                            ),
                          ),
                        ),
                      ),

                    ])
            ),
          )
      ),
        body: new GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus(new FocusNode());
            },
            child: SingleChildScrollView(
                child: Container(
                  color: Colors.transparent,
                  child: Container(
//                     height: 300,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
//                          gradient: LinearGradient(
//                              colors: [Colors.yellow[100], Colors.green[100]]
//                          )
                      ),
                      child: Column(

                        children: <Widget>[

                          Container(
                              margin: EdgeInsets.only(top: 16 ,left: 20 ,right: 20),
                              constraints: BoxConstraints.expand(height: 80),
                              child: Text("เข้าสู่ระบบ",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      fontSize: 28,
                                      color: Colors.black54,
                                  )
                              ),
                              decoration: BoxDecoration(
//                                  borderRadius: BorderRadius.circular(16), color: Colors.green[400]
                              ),

                              padding: EdgeInsets.all(12)
                          ),

                          buildTextFieldEmail(),
                          buildTextFieldPassword(),
                          Container(
                            width: 250,
                            height: 40,
                            margin: const EdgeInsets.only(top: 10, bottom: 10 , left: 10 ,right: 10),
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                            ),
                            child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Container(
                                    margin: const EdgeInsets.only(left: 10, right: 15),
                                    height: 30,
                                    child: InkWell(
                                      onTap: () {
//                                        ForgotPassWidget
                                        Navigator.push(
                                            context, MaterialPageRoute(builder: (context) => ForgotPassWidget()));
                                      },
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          'ลืมรหัสผ่าน',
                                          style: Theme.of(context)
                                              .textTheme
                                              .body1
                                              .merge(
                                            TextStyle(
                                                color: Theme.of(context)
                                                    .hintColor
                                                    .withOpacity(0.8),
                                                fontSize: 15
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: 1,
                                    height: 30,
                                    decoration: BoxDecoration(
                                      border: Border(
                                        right: BorderSide(
                                          color: Colors.black12,
                                          width: 0.5,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(
                                        left: 15, right: 10),
                                    height: 30,
                                    child: InkWell(
                                      // padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                                      onTap: () {

//                                            Navigator.of(context)
//                                                .pushNamed('/SignUpPhone');

                                        Navigator.push(
                                            context, MaterialPageRoute(builder: (context) => SignUpWidget()));

                                      },
                                      child: Align(
                                          alignment: Alignment.centerRight,
                                          child: Text(
                                            'สมัครสมาชิก',
                                            style: Theme.of(context)
                                                .textTheme
                                                .body1
                                                .merge(
                                              TextStyle(
                                                  color: Theme.of(context)
                                                      .hintColor
                                                      .withOpacity(0.8),
                                                  fontSize: 15),
                                            ),
                                          )),
                                    ),
                                  ),
                                ]
                            ),

                          ),

                          buildButtonSignIn(),


                          buildOtherLine(),

                          _auth_facebook(),
//                          _auth_apple(),
//                          _auth_google(),

                          _platform == "IOS" ? _auth_apple() : _auth_google()
//                          buildButtonRegister()

                        ],
                      ))
                )
            )
        ),
    );
    } else {
      return Container(
      color: Colors.white,
      child: Center(
        child: Text("Loading...",
        style: TextStyle(
            fontSize: 15,
            color: Colors.black38
        ),
        ),
      ),
    );
    }

  }


  Future checkAuth() async {
    User user = firebaseCon.auth_.currentUser;
    return user;
  }


  Widget buildButtonSignIn() {
    return InkWell(
      child: Container(
          margin: EdgeInsets.only(top: 16 ,left: 20 ,right: 20),
          constraints: BoxConstraints.expand(height: 50),
          child: Text("เข้าสู่ระบบ",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18, color: Colors.white)),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: config.HexColor("#79B5B4")
          ),
          padding: EdgeInsets.all(12)
      ),
      onTap: () {
        signIn();
//        _modalAlertError(context, "uuuuu", "uuuuuu");
      },
    );
  }

  Container buildTextFieldEmail() {
    return Container(
      margin: EdgeInsets.only(left: 20 ,right: 20),
      child: TextField(
        keyboardType: TextInputType.emailAddress,
        style: TextStyle(color: Theme.of(context).hintColor),
        controller: emailController,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: 'อีเมล',
          errorText: _validateEmail
              ? 'value cant be empty'
              : null,
          prefixIcon: const Icon(
            Icons.account_circle,
            color: Colors.black26,
            size: 23,
          ),
          hintStyle: TextStyle(color: Colors.black26 , fontSize: 15),
        ),
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor.withOpacity(1.0),
        borderRadius: BorderRadius.circular(25),

        boxShadow: [
          BoxShadow(color: Theme.of(context).hintColor.withOpacity(0.10), offset: Offset(0, 0), blurRadius: 4)
        ],

      ),

    );
  }

  Container buildTextFieldPassword() {
    return Container(
      margin: EdgeInsets.only(top: 12,left: 20 ,right: 20),
      child: TextField(
        keyboardType: TextInputType.emailAddress,
        style: TextStyle(color: Theme.of(context).hintColor),
        controller: passwordController,
        obscureText: !_showPassword,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: 'รหัสผ่าน',
          errorText: _validatePassword
              ? 'value cant be empty'
              : null,
          prefixIcon: const Icon(
            Icons.security,
            color: Colors.black26,
            size: 23,
          ),
          suffixIcon: IconButton(
            onPressed: () {
              setState(() {
                _showPassword = !_showPassword;
              });
            },
            color: Colors.black26,
            icon: Icon(_showPassword
                ? Icons.visibility_off
                : Icons.visibility),
          ),
          hintStyle: TextStyle(color: Colors.black26, fontSize: 15),
        ),
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor.withOpacity(1.0),
        borderRadius: BorderRadius.circular(25),

        boxShadow: [
          BoxShadow(color: Theme.of(context).hintColor.withOpacity(0.10), offset: Offset(0, 0), blurRadius: 4)
        ],

      ),
    );

  }


  Widget buildOtherLine() {
    return Container(

        margin: EdgeInsets.only(top: 20, left: 30 ,right: 30,bottom: 10),
        child: Center(
          child: Row(children: <Widget>[
            Expanded(child: Divider(color: Colors.black54)),
            Padding(
                padding: EdgeInsets.all(6),
                child: Text("หรือ",
                    style: TextStyle(
                        color: Colors.black87,
                        fontSize: 18
                    )
                )
            ),
            Expanded(child: Divider(color: Colors.black54)),
          ]),
        ));
  }

    Widget _auth_app() {

    return InkWell(
        child: Container(
            constraints: BoxConstraints.expand(height: 50),
            child: Text("Sign up",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, color: Colors.white)),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16), color: Colors.orange[200]),
            margin: EdgeInsets.only(top: 12),
            padding: EdgeInsets.all(12)
        ),
        onTap: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => VerifySignUpWidget()));
        });

  }



    Widget _auth_facebook() {
      return InkWell(
        child: Container(
            constraints: BoxConstraints.expand(
                height: 50
            ),
            child: Text("Sign in with Facebook",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, color: Colors.white)),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Color(0xFF1877F2)
            ),
            margin: EdgeInsets.only(top: 10, left: 20 ,right: 20),
            padding: EdgeInsets.all(12)
        ),
        onTap: () async{


           // await _facebooklogOut();

          _onLoading();

          _facebooklogIn().then((User user) async {



            //print(user);

            if(user != null){

              var date = new DateTime.now();
              String member_id = "M-${date.millisecondsSinceEpoch}";
              _member.MemberID = member_id;
              _member.Uid = user.uid;
              _member.FullName = user.displayName;
              _member.Email = user.email;
              _member.Country = "";
              _member.MobilePhone = user.phoneNumber;

              var _e = await AuthService().registerInApp(_member.toJson());

              await AuthService().loadUserInfo(user);

              Navigator.pop(context);

              if(_e == "ok"){
                _modalAlertSuccess(context, "Successful", "Sign In successful.");
              }

            }


          });

          // Navigator.push(
          //     context, MaterialPageRoute(builder: (context) => VerifySignUpWidget())
          // );

    });
    }

    Widget _auth_google() {
      return InkWell(
          child: Container(
              margin: EdgeInsets.only(top: 10, left: 20 ,right: 20 ,bottom: 10),
              constraints: BoxConstraints.expand(height: 50),
              child: Text("Sign in with Google",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.black87
                  )
              ),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black
                            .withOpacity(0.15),
                        offset: Offset(0, 0),
                        blurRadius: 2)
                  ],
              ),
              padding: EdgeInsets.all(12)
          ),
          onTap: () {

            // _googlelogOut();

            _onLoading();

            _googlelogIn().then((User user) async {



              if(user != null){

                var date = new DateTime.now();
                String member_id = "M-${date.millisecondsSinceEpoch}";
                _member.MemberID = member_id;
                _member.Uid = user.uid;
                _member.FullName = user.displayName;
                _member.Email = user.email;
                _member.Country = "";
                _member.MobilePhone = user.phoneNumber;

                var _e = await AuthService().registerInApp(_member.toJson());

                await AuthService().loadUserInfo(user);

                Navigator.pop(context);

                if(_e == "ok"){
                  _modalAlertSuccess(context, "Successful", "Sign In successful.");
                }

              }
              else{
                Navigator.pop(context);
              }


            });


            // Navigator.push(
            //     context, MaterialPageRoute(builder: (context) => VerifySignUpWidget()));
          });
    }

    Widget _auth_apple() {

      return InkWell(
          child: Container(
              margin: EdgeInsets.only(top: 10, left: 20 ,right: 20 ,bottom: 10),
              constraints: BoxConstraints.expand(height: 50),
              child: Text("Sign in with Apple",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18, color: Colors.white)),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16), color: Colors.black
              ),
              padding: EdgeInsets.all(12)
          ),
          onTap: () {


            _onLoading();

            _applesignIn().then((User user) async {



              if(user != null){

                var date = new DateTime.now();
                String member_id = "M-${date.millisecondsSinceEpoch}";
                _member.MemberID = member_id;
                _member.Uid = user.uid;
                _member.FullName = user.displayName;
                _member.Email = user.email;
                _member.Country = "";
                _member.MobilePhone = user.phoneNumber;

                var _e = await AuthService().registerInApp(_member.toJson());

                await AuthService().loadUserInfo(user);

                if(_e == "ok"){
                  _modalAlertSuccess(context, "Successful", "Sign In successful.");
                }

                Navigator.pop(context);

              }

            });


            // Navigator.push(
            //     context, MaterialPageRoute(builder: (context) => VerifySignUpWidget()));
          });

    }

    Future signIn() async {


       // print(emailController.text.isEmpty);


      if(emailController.text.isEmpty){
        _modalAlertError(context, "Error", "กรุณาระบุ username");
      }
      else if(passwordController.text.isEmpty){
        _modalAlertError(context, "Error", "กรุณาระบุ password");
      }
      else{

        _onLoading();

        await firebaseCon.auth_.signInWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
        ).then((user) async {

          Navigator.pop(context);

//      print("signed in ${user.user}");

          Member.myUid = user.user.uid;
          Member.myName = user.user.displayName;
          Member.photoUrl = user.user.photoURL;

          await AuthService().loadUserInfo(user.user);

          //NotificationService().registerNotification();
          NotificationService().configureDidReceiveLocal();

          _modalAlertSuccess(context, "Successful", "Sign In successful.");

//         print("signed in");

        }).catchError((error) {
          print(error.message);
          Navigator.pop(context);
          _modalAlertError(context, "Error", error.message);
        });

      }




    }



  Future<User> _facebooklogIn() async {


    var fbLogin = FacebookLogin();

    var result = await fbLogin.logIn(['email', 'public_profile']);


    switch (result.status) {

      case FacebookLoginStatus.error:
        print("Error");
        Navigator.pop(context);
        return null;
        break;
      case FacebookLoginStatus.cancelledByUser:
        print("CancelledByUser");
        Navigator.pop(context);
        return null;
        break;
      case FacebookLoginStatus.loggedIn:
        print("LoggedIn");


        try {

          FacebookAccessToken myToken = result.accessToken;
          AuthCredential credential =
          FacebookAuthProvider.credential(myToken.token);

          var authResult =   await firebaseCon.auth_.signInWithCredential(credential);

          final User firebaseUser = authResult.user;
          final User currentUser = firebaseCon.auth_.currentUser;
          assert(firebaseUser.uid == currentUser.uid);


          Member.myUid = firebaseUser.uid;
          Member.myName = firebaseUser.displayName;
          Member.photoUrl = firebaseUser.photoURL;

          return firebaseUser;

        } catch (e) {
          print(e.toString());
          Navigator.pop(context);

          _modalAlertError(context, "Error", "มีการใช้งาน accout นี้แล้วในระบบ");

          return null;
        }

        break;

    }


  }


  Future<User> _googlelogIn() async {

    GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    final GoogleSignInAuthentication gsa =
    await googleSignInAccount.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
      idToken: gsa.idToken,
      accessToken: gsa.accessToken,
    );

    var authResult = await firebaseCon.auth_.signInWithCredential(credential);
    final User firebaseUser = authResult.user;
    final User currentUser = await firebaseCon.auth_.currentUser;
    assert(firebaseUser.uid == currentUser.uid);

    Member.myUid = firebaseUser.uid;
    Member.myName = firebaseUser.displayName;
    Member.photoUrl = firebaseUser.photoURL;

    return firebaseUser;


  }


  Future<User> _applesignIn() async {

    final AuthorizationResult appleResult = await AppleSignIn.performRequests([
      AppleIdRequest(requestedScopes: [Scope.email, Scope.fullName])
    ]);


    switch (appleResult.status) {
      case AuthorizationStatus.authorized:

        final AuthCredential credential = OAuthProvider('apple.com').credential(
          accessToken: String.fromCharCodes(appleResult.credential.authorizationCode),
          idToken: String.fromCharCodes(appleResult.credential.identityToken),
        );


        var authResult = await firebaseCon.auth_.signInWithCredential(credential);
        final User firebaseUser = authResult.user;
        final User currentUser = await firebaseCon.auth_.currentUser;
        assert(firebaseUser.uid == currentUser.uid);

        Member.myUid = firebaseUser.uid;
        Member.myName = firebaseUser.displayName;
        Member.photoUrl = firebaseUser.photoURL;

        return firebaseUser;
        break;

      case AuthorizationStatus.error:
        print("Sign in failed: ${appleResult.error.localizedDescription}");
        Navigator.pop(context);
        return null;
        break;

      case AuthorizationStatus.cancelled:
        print('User cancelled');
        Navigator.pop(context);
        return null;
        break;
    }





  }


  void _modalAlertSuccess(context, String title, String description) {

    showModalBottomSheet(
        context: context,
        isDismissible: false,
        elevation: 0,
        useRootNavigator: false,
        backgroundColor: Colors.transparent,
        builder: (BuildContext bc) {
          return modalBottomCostom(
            typeModel: "success",
            context: context,
            title: title,
            description: description,
            iconIn: Icons.check_circle,
            colorIcon: Colors.green,
          );
        }).then((val) {

//      Navigator.pop(context);

      Navigator.pushReplacement(
          context, MaterialPageRoute( builder: (context) => TabsWidget(
        currentTab: 0,
      )
      ));


      print(val);

    });
  }

  void _modalAlertError(context, String title, String description)  {

  showModalBottomSheet(
      context: context,
      isDismissible: false,
      elevation: 0,
      useRootNavigator: false,
      backgroundColor: Colors.transparent,
      builder: (BuildContext bc) {
        return modalBottomCostom(
          typeModel: "error",
          context: context,
          title: title,
          description: description,
          iconIn: Icons.error,
          colorIcon: Colors.red,
        );
      }).then((val) {
//        return val;
      });
  }

  void _onLoading() {

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => PopupLoading(),
    );

  }

}



