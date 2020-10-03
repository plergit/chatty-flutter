import 'dart:io';

import 'package:chatty/model/member.dart';
import 'package:chatty/services/_auth.dart';
import 'package:chatty/shared/ModalBottomSheet.dart';
import 'package:chatty/shared/files/imagePicker/imagePicker.dart';
import 'package:chatty/shared/files/uploads/_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../config/app_config.dart' as config;

class ForgotPassWidget extends StatefulWidget {

  @override
  _ForgotPassState createState() => new _ForgotPassState();
}

class _ForgotPassState extends State<ForgotPassWidget> {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Member _member = new Member.init();
  firestoreUploadFile _fileUpload = new firestoreUploadFile();


  @override
  void initState() {

    super.initState();
  }



  TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {

      return new GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(new FocusNode());
          },
          child: Scaffold(
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
                                    "ลืมรหัสผ่าน",
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
          body: new GestureDetector(
              onTap: () {
                FocusScope.of(context).requestFocus(new FocusNode());
              },
              child: Container(
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
                              child: Text("ลืมรหัสผ่าน Chatty",
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


                          _fieldEamil(),

                          _btnSignUp(context)


                        ],
                      ))
              ),
              )
          )
      )
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
          hintText: 'อีเมล',
//          errorText: _validateEmail
//              ? 'value cant be empty'
//              : null,
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

  Widget _btnSignUp(BuildContext context) {
    return InkWell(
        child: Container(
            margin: EdgeInsets.only(top: 16,left: 10 ,right: 10, bottom: 20),
            constraints: BoxConstraints.expand(height: 50),
            child: Text("ส่ง",
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

            padding: EdgeInsets.all(12)),
        onTap: () => sendEamil()
    );
  }


  sendEamil() async {

    String email = emailController.text.trim();

    if(email.isEmpty){

      _modalAlertError(context, "Error", "กรุณาระบุข้อมูล อีเมล");

    } else{

      AuthService().resetPassword(email).then((value) {

        print(value);

        _modalAlertSuccess(context, "สำเร็จ", "ระบบได้ส่งขอมูลไปที่อีเมลของท่านเรียบร้อยแล้ว");

      });

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

      Navigator.pop(context);
      // Navigator.pop(context);

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




