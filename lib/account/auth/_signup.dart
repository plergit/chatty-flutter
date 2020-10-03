import 'dart:io';

import 'package:chatty/model/member.dart';
import 'package:chatty/services/_auth.dart';
import 'package:chatty/shared/ModalBottomSheet.dart';
import 'package:chatty/shared/files/imagePicker/imagePicker.dart';
import 'package:chatty/shared/files/uploads/_firestore.dart';
import 'package:chatty/shared/widgets/popupLoading.dart';
import 'package:country_list_pick/country_list_pick.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../config/app_config.dart' as config;

class SignUpWidget extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => new _SignupState();
}

class _SignupState extends State<SignUpWidget> {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  Member _member = new Member.init();
  String _dialCode = "+66";


  @override
  void initState() {

    super.initState();


  }


  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmController = TextEditingController();

//  File _image;
//  Map<String, dynamic> _fileImgItem ;

  @override
  Widget build(BuildContext context) {

      return new GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(
                new FocusNode()
            );
          },
          child : Scaffold(
          appBar: PreferredSize(
              preferredSize: Size.fromHeight(55.0),
              child: AppBar(
                elevation: 0,
                backgroundColor: Colors.white,
                automaticallyImplyLeading: false, // hides leading widget
                flexibleSpace: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border(
                        bottom: BorderSide(
                          color: Colors.black12,
                          width: 0.5,
                        ),
                      ),
                    ),
                    padding: EdgeInsets.only(
                        left: 0,
                        right: 0,
                        top: MediaQuery.of(context).padding.top,
                        bottom: 0),
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          height: 45,
                          width: double.infinity,
                          child: Stack(children: <Widget>[
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Container(
                                  margin : EdgeInsets.only(left: 50,right: 0),
                                  child: Text(
                                    "สมัครสมาชิกใหม่",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w500,
                                        color: Theme.of(context).accentColor),
                                  )
                              ),
                            ),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Container(
                                height: 50.0,
                                width: 50.0,
                                child: IconButton(
                                  alignment: Alignment.center,
                                  icon: new ImageIcon(
                                    AssetImage(
                                        "assets/images/icons/icon-close.png"
                                    ),
                                    size: 18,
                                    color: Colors.black38,
                                  ),
                                  onPressed: () => {
                                    Navigator.pop(context, {"action": "close"}),
                                  },
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                            ),
                          ]),
                        ),
                      ],
                    )),
              )),
          body: Container(
              child: SingleChildScrollView(
                  child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
//                        gradient: LinearGradient(
//                            colors: [Colors.yellow[100], Colors.green[100]]
//                        )
                      ),
                      margin: EdgeInsets.all(0),
                      padding: EdgeInsets.all(24),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[

                          Container(
                              margin: EdgeInsets.only(top: 6 ,left: 0 ,right: 20),
                              constraints: BoxConstraints.expand(height: 80),
                              child: Text("สมัครสมาชิก Chatty",
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

                          _fieldUsername(),
                          _fieldEamil(),
                          _fieldPhone(),

                          _otherLine(),

                          _fieldPassword(),
                          _fieldPasswordConfirm(),

                          _fieldAccept(),

                          _btnSignUp(context)


                        ],
                      ))
              ),
          )
      ));

  }


  Container _fieldUsername() {
    return Container(
      margin: EdgeInsets.only(left: 10 ,right: 10, bottom: 20),
      child: TextField(
        keyboardType: TextInputType.emailAddress,
        style: TextStyle(color: Theme.of(context).hintColor),
        controller: usernameController,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: 'ชื่อบัญชีผู้ใช้',
          prefixIcon: ImageIcon(
            AssetImage("assets/images/icons/icon_name.png"  ),
            size: 20,
            color: Colors.black26,
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
  Container _fieldEamil() {
    return Container(
      margin: EdgeInsets.only(left: 10 ,right: 10, bottom: 20),
      child: TextField(
        keyboardType: TextInputType.emailAddress,
        style: TextStyle(color: Theme.of(context).hintColor),
        controller: emailController,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: 'อีเมล์',
//          errorText: _validateEmail
//              ? 'value cant be empty'
//              : null,
          prefixIcon: ImageIcon(
            AssetImage("assets/images/icons/icon_@.png"  ),
            size: 20,
            color: Colors.black26,
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




  Container _fieldPhone() {
    return Container(
      margin: EdgeInsets.only(left: 10 ,right: 10, bottom: 20),
      child: Row(
        children: [

          Container(
//            width: 70,
            child: CountryListPick(
              initialSelection: _dialCode,
              onChanged: (CountryCode code) {
                _dialCode = code.code;
              },
            ),
          ),
          Expanded(
            child: TextField(
              keyboardType: TextInputType.phone,
              style: TextStyle(color: Theme.of(context).hintColor),
              controller: phoneController,
              decoration: InputDecoration(
                border: InputBorder.none,

                hintStyle: TextStyle(color: Colors.black26 , fontSize: 15),
              ),
            ),
          ),



        ],
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

  bool _showPassword = false;

  Container _fieldPassword() {
    return Container(
      margin: EdgeInsets.only(left: 10 ,right: 10, bottom: 10),
      child: TextField(
        keyboardType: TextInputType.name,
        style: TextStyle(color: Theme.of(context).hintColor),
        controller: passwordController,
        obscureText: !_showPassword,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: 'รหัสผ่าน 8 ตัวขึ้นไป',

          prefixIcon: ImageIcon(
            AssetImage("assets/images/icons/icon_key.png"  ),
            size: 20,
            color: Colors.black26,
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
  Container _fieldPasswordConfirm() {
    return Container(
      margin: EdgeInsets.only(left: 10 ,right: 10, bottom: 10),
      child: TextField(
        keyboardType: TextInputType.name,
        style: TextStyle(color: Theme.of(context).hintColor),
        controller: confirmController,
        obscureText: !_showPassword,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: 'รหัสผ่านอีกครั้ง',

          prefixIcon: ImageIcon(
            AssetImage("assets/images/icons/icon_lock.png"  ),
            size: 20,
            color: Colors.black26,
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

  bool isSelectedAccept = false;

  Container _fieldAccept() {
    return Container(
      margin: EdgeInsets.only(top: 10,left: 10 ,right: 10, bottom: 10),
      child: Row(
        children: [

           InkWell(

             child: Container(
               width: 30,
               height: 30,
               margin: EdgeInsets.only(right: 10),
               decoration: BoxDecoration(
                 color: isSelectedAccept == true ? Theme.of(context).accentColor.withOpacity(0.2) : Theme.of(context).primaryColor.withOpacity(1.0),
                 boxShadow: [
                   BoxShadow(color: Theme.of(context).hintColor.withOpacity(0.50), offset: Offset(0, 0), blurRadius: 1)
                 ],
                 shape: BoxShape.circle,
               ),
             ),
             onTap: (){
                setState(() {
                  isSelectedAccept = isSelectedAccept == true ? false : true;
                });

             },
           ),


          Padding(
              padding: EdgeInsets.all(6),
              child: Text("ยอมรับเงื่อนไข การใช้งานระบบ",
                  style: TextStyle(
                      color: Colors.black87,
                      fontSize: 15
                  )
              )
          ),


        ],
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor.withOpacity(0.0),
        borderRadius: BorderRadius.circular(0),

        boxShadow: [
          BoxShadow(color: Theme.of(context).hintColor.withOpacity(0.0), offset: Offset(0, 0), blurRadius: 0)
        ],

      ),

    );
  }

  Widget _otherLine() {
    return Container(

        margin: EdgeInsets.only(top: 16,left: 30 ,right: 30, bottom: 20),
        child: Row(children: <Widget>[
          Expanded(child: Divider(color: Colors.black54)),
          Padding(
              padding: EdgeInsets.all(6),
              child: Text("รหัสเข้าระบบ",
                  style: TextStyle(
                      color: Colors.black87,
                      fontSize: 15
                  )
              )),
          Expanded(child: Divider(color: Colors.black54)),
        ]));
  }

  Widget _btnSignUp(BuildContext context) {
    return InkWell(
        child: Container(
            constraints: BoxConstraints.expand(height: 50),
            child: Text("สมัครสมาชิก",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.white
                )
            ),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: config.HexColor("#79B5B4")
            ),
            margin: EdgeInsets.only(top: 16),
            padding: EdgeInsets.all(12)),
        onTap: () => signUp());
  }


  signUp() async {

//    _dialCode



    String username = usernameController.text.trim();
    String email = emailController.text.trim();
    String phone = phoneController.text.trim();
    String password = passwordController.text.trim();
    String confirmPassword = confirmController.text.trim();
    String country = _dialCode;

    //print(email);

    if(username == "" && email == "" && phone == "" && password == "" && confirmPassword == ""){
      _modalAlertError(context, "แจ้งเตือน", "กรุณาระบุข้อมูลให้ครบถ่วน");
    }
    else if(username == ""){
      _modalAlertError(context, "แจ้งเตือน", "กรุณาระบุข้อมูล ชื่อผู้ใช้งาน");
    }
    else if(phone == ""){
      _modalAlertError(context, "แจ้งเตือน", "กรุณาระบุข้อมูล หมายเลขโทรศัพ");
    }
    else if(password == ""){
      _modalAlertError(context, "แจ้งเตือน", "กรุณาระบุข้อมูล รหัสผ่าน");
    }
    else if(confirmPassword == ""){
      _modalAlertError(context, "แจ้งเตือน", "กรุณาระบุข้อมูลยืนยัน ยืนยันรหัสผ่าน");
    }
    else if(password != confirmPassword){
      _modalAlertError(context, "แจ้งเตือน", "กรุณาระบุข้อมูล ยืนยันรหัสผ่าน ไม่ตรงกัน");
    }
    else{

      if (password == confirmPassword && password.length >= 8) {

        _onLoading();


        _auth.createUserWithEmailAndPassword(email: email, password: password)
        .then((user) async {

          User userInfo = _auth.currentUser;
          // UserUpdateInfo userUpdateInfo = new UserUpdateInfo();

          var date = new DateTime.now();
          String member_id = "M-${date.millisecondsSinceEpoch}";
          _member.MemberID = member_id;
          _member.Uid = user.user.uid;
          _member.FullName = username;
          _member.Email = user.user.email;
          _member.Country = country;
          _member.MobilePhone = phone;
          //userUpdateInfo.displayName = username;

          userInfo.updateEmail(user.user.email);
          userInfo.updateProfile(displayName: username);
          await userInfo.reload();


          await AuthService().registerUser(_member.toJson());
             //print("Sign up user successful.");
          Navigator.pop(context);
            _modalAlertSuccess(context, "Successful", "Sign up user successful.");
        }).catchError((error) {
          Navigator.pop(context);
          _modalAlertError(context, "Error", error.message);
          print(error.message);
        });


      } else {

        _modalAlertError(context, "แจ้งเตือน", "ข้อมูลรหัสผ่านจะต้องมีความยาว 8 ตัวอักษรขึ้นไป");

      }


    }

  }


  void _onLoading() {

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => PopupLoading(),
    );

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

      Navigator.pop(context);


      print(val);

    });
    ;
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

}




