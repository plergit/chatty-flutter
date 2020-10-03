import 'dart:io';

import 'package:chatty/model/member.dart';
import 'package:chatty/services/_auth.dart';
import 'package:chatty/shared/ModalBottomSheet.dart';
import 'package:chatty/shared/files/imagePicker/imagePicker.dart';
import 'package:chatty/shared/files/uploads/_firestore.dart';
import 'package:country_list_pick/country_list_pick.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class VerifySignUpWidget extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => new _SignupState();
}

class _SignupState extends State<VerifySignUpWidget> {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Member _member = new Member.init();
  firestoreUploadFile _fileUpload = new firestoreUploadFile();

  String _dialCode = "+66";
  bool _validatePhone = true;
  String _errorPhone = "Value cant be empty";

  TextEditingController phone_ = TextEditingController();
  TextEditingController verifyCode_ = TextEditingController();



  @override
  void initState() {

    super.initState();
  }




  File _image;
//  Map<String, dynamic> _fileImgItem ;

  @override
  Widget build(BuildContext context) {

      return Scaffold(
//          appBar: AppBar(
//            title: Text("Sign up", style: TextStyle(color: Colors.black54)),
//          ),
          appBar: PreferredSize(
              preferredSize: Size.fromHeight(55.0),
              child: AppBar(
                elevation: 0,
                backgroundColor: Colors.green[50],
                automaticallyImplyLeading: false, // hides leading widget
                flexibleSpace: Container(
                    decoration: BoxDecoration(
                      color: Colors.green[50],
//                    color: Colors.green,
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
          body: new GestureDetector(
              onTap: () {
                FocusScope.of(context).requestFocus(new FocusNode());
              },
              child: Container(
              color: Colors.green[50],
              child: Center(
                child: SingleChildScrollView(
                    child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
//                        gradient: LinearGradient(
//                            colors: [Colors.yellow[100], Colors.green[100]]
//                        )
                    ),
                    margin: EdgeInsets.all(2),
                    padding: EdgeInsets.all(10),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[



                        Container(
                          margin: EdgeInsets.only(left: 10, right: 10),
                          decoration: BoxDecoration(
                            color: Theme.of(context)
                                .primaryColor
                                .withOpacity(1.0),
                            borderRadius: BorderRadius.circular(25),
                            boxShadow: [
                              BoxShadow(
                                  color: Theme.of(context)
                                      .hintColor
                                      .withOpacity(0.15),
                                  offset: Offset(0, 2),
                                  blurRadius: 6)
                            ],
                          ),
                          child: Row(
                            children: [

                              Container(

                                child: CountryListPick(

                                  initialSelection: _dialCode,
                                  onChanged: (CountryCode code) {
                                    _dialCode = code.code;
                                  },
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  child: TextField(
                                    keyboardType: TextInputType.phone,
                                    style: TextStyle(
                                        color: Theme.of(context).hintColor,
                                        fontSize: 16
                                    ),
                                    controller: phone_,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: '00-000-0000',
                                      errorText: _validatePhone == false
                                          ? _errorPhone
                                          : null,
                                      hintStyle: TextStyle(
                                          color: Colors.black54,
                                          fontSize: 16
                                      ),
                                    ),

                                  ),
                                ),
                              ),

                              Container(
                                decoration: BoxDecoration(
                                  color: Theme.of(context)
                                      .focusColor
                                      .withOpacity(1.0),
                                  borderRadius: BorderRadius.circular(24),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Theme.of(context)
                                            .hintColor
                                            .withOpacity(0.15),
                                        offset: Offset(0, 2),
                                        blurRadius: 6)
                                  ],
                                ),
                                child: IconButton(
                                  onPressed: () {
                                    requestVerifyCode();
                                  },
                                  color: Colors.deepOrange,
                                  icon: Icon(Icons.arrow_forward),
                                ),
                              )


                            ],
                          ),

                        ),




                      ],
                    ))
                ),
              ))
          )
      );


  }



  Widget buildButtonSignUp(BuildContext context) {
    return InkWell(
        child: Container(
            constraints: BoxConstraints.expand(height: 50),
            child: Text("Sign up",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, color: Colors.white)),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16), color: Colors.green[200]),
            margin: EdgeInsets.only(top: 16),
            padding: EdgeInsets.all(12)),
        onTap: () {

        }
    );
  }


  Widget buildOtherLine() {
    return Container(
        margin: EdgeInsets.only(top: 16),
        child: Row(children: <Widget>[
          Expanded(child: Divider(color: Colors.green[800])),
          Padding(
              padding: EdgeInsets.all(6),
              child: Text("ข้อมูลสำหรับเข้าระบบ",
                  style: TextStyle(
                      color: Colors.black87,
                      fontSize: 15
                  )
              )),
          Expanded(child: Divider(color: Colors.green[800])),
        ]));
  }





  requestVerifyCode() async {



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




