import 'package:chatty/model/member.dart';
import 'package:chatty/services/_auth.dart';
import 'package:chatty/services/_connect.dart';
import 'package:chatty/shared/ModalBottomSheet.dart';
import 'package:chatty/shared/_pinTextField.dart';
import 'package:country_list_pick/country_list_pick.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../config/app_config.dart' as config;

class SettingProfilePhoneWidget extends StatefulWidget {

  @override
  _SettingProfileState createState() => new _SettingProfileState();
}

class _SettingProfileState extends State<SettingProfilePhoneWidget> {

  TextEditingController phoneController = TextEditingController();

  String _dialCode = "+66";
  String verificationCode ;
  String verifyPinCode;

  @override
  void initState() {
    super.initState();

    // emailController.text = Member.myEmail;

     verificationCode = "";
     verifyPinCode = "";

  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(55.0),
            child: AppBar(
              elevation: 0,
              backgroundColor: Theme.of(context).primaryColor,
              automaticallyImplyLeading: false, // hides leading widget
              flexibleSpace: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
//                    color: Colors.green,
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.black38,
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
                                  "หมายเลขโทรศัพท์",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w600,
                                      color: Theme.of(context).accentColor
                                  ),
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
                                  color: Colors.black,
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
            child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child : Container(
                padding: EdgeInsets.all(12),
                color: Colors.white,
                child: Column(
                  children: [

                    SizedBox(
                      height: 20,
                    ),

                    Container(
                      padding: EdgeInsets.all(20),
                      child: Image(
                        image: AssetImage(
                            "assets/images/icons/icon-sms-phone.png",
                        ),
                      ),
                      alignment: Alignment.center,
                    ),

                    SizedBox(
                      height: 20,
                    ),

                    Container(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        "หมายเลขโทรศัพท์ที่ใช้ลงทะเบียน",
                          style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w600,
                          color: Theme.of(context).accentColor
                          ),
                      ),
                    ),

                    SizedBox(
                      height: 25,
                    ),

                    _fieldPhone(),

                    SizedBox(
                      height: 20,
                    ),
                    verificationCode == "" ? Container() :

                    SizedBox(
                      child: Column(
                        children: [

                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "CODE OTP",
                            style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.w600,
                                color: Theme.of(context).accentColor
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          _fieldPin(),

                        ],
                      ),
                    ),

                    SizedBox(
                      height: 25,
                    ),

                    Container(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        "Lorem Ipsum คือ เนื้อหาจำลองแบบเรียบๆที่ใช้กันในธุรกิจงานพิมพ์หรืองานเรียงพิมพ์ ตั้งแต่ศตวรรษที่ 16",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w600,
                            color: Theme.of(context).accentColor
                        ),
                      ),
                    ),

                    SizedBox(
                      height: 25,
                    ),

                    verificationCode == null ? Container() : buildButtonSignUp(context),

                  ],
                )
            )
            )
        )
    );

  }



  Container _fieldPhone() {
    return Container(
      margin: EdgeInsets.only(left: 0 ,right: 0, bottom: 5),
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
              maxLength: 9,
              decoration: InputDecoration(
                border: InputBorder.none,
                counterText: '',
                hintStyle: TextStyle(color: Colors.black26 , fontSize: 16),
              ),

            ),
          ),

          Container(
            width: 60,
            height: 50,
            child: InkWell(
                child: Container(

                    constraints: BoxConstraints.expand(
                        height: 40

                    ),
                    child: Text("ส่ง",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        )
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: config.HexColor("#79B5B4"),
                    ),
                    margin: EdgeInsets.only(top: 0),
                    padding: EdgeInsets.all(12)
                ),
                onTap: () {

                  if(phoneController.text.isEmpty){
                    _modalAlertError(context, "แจ้งเตือน", "กรุณาระบุ เบอร์โทรศัพท์ที่ต้องการ");
                  }
                  else{
                    verification_phone();
                  }

                }
            ),
          )

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

  Container _fieldPin(){
    return Container(
      child:  PinEntryTextField(
        colorBg: Theme.of(context)
            .accentColor.withOpacity(0.2),
        showFieldAsBox: true,
        fields: 6,
        onSubmit: (String pin) {
          verifyPinCode = pin;
        },

      ),
      decoration: BoxDecoration(

      ),
    );
  }

  Widget buildButtonSignUp(BuildContext context) {
    return InkWell(
        child: Container(
            constraints: BoxConstraints.expand(
                height: 50
            ),
            child: Text("เปลี่ยนเบอร์โทรศัพท์",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                )
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16), color: config.HexColor("#79B5B4"),
            ),
            margin: EdgeInsets.only(top: 16),
            padding: EdgeInsets.all(12)),
        onTap: () {

          // print(verifyPinCode);

          if(verifyPinCode == null || verifyPinCode == ""){
            _modalAlertError(context, "แจ้งเตือน", "กรุณาระบุ Code OTP");
          }
          else{
            _modalAlertConfirm(context, "ยืนยันการแก้ไข", "หากต้องการเปลี่ยนแปลง ให้กด ตกลง หรือ ยกเลิก");
          }

        }
    );
  }


  verification_phone() async {

    var _phone = phoneController.text;
    var phoneNumber = "$_dialCode$_phone";

    await firebaseCon.auth_.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      timeout: const Duration(seconds: 30),
      verificationFailed: (FirebaseAuthException e) {
        if (e.code == 'invalid-phone-number') {
          // print('The provided phone number is not valid.');
        }
        // Handle other errors
      }, verificationCompleted: (PhoneAuthCredential phoneAuthCredential) {

      print("dddd1 $phoneAuthCredential");

    }, codeAutoRetrievalTimeout: (String verificationId) {

      print("dddd2 $verificationId");

    }, codeSent: (verificationId, [forceResendingToken]) async {

      print("dddd3 $verificationId --- $forceResendingToken");

      setState(() {
        verificationCode = verificationId;
      });

    },

    );

  }


  verification_otp(String _smsCode) async {

    String smsCode = _smsCode;
    final AuthCredential credential = PhoneAuthProvider.credential(verificationId: verificationCode, smsCode: smsCode);
    await firebaseCon.auth_.currentUser.updatePhoneNumber(credential);

    if(firebaseCon.auth_.currentUser.phoneNumber != null){
       Member.myMobilePhone = firebaseCon.auth_.currentUser.phoneNumber;
      _modalAlertSuccess(context, "สำเร็จ", "เปลี่ยนแปลงข้อมูลเรียบร้อย");
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

  void _modalAlertConfirm(context, String title, String description) {

    showModalBottomSheet(
        context: context,
        isDismissible: false,
        elevation: 0,
        useRootNavigator: false,
        backgroundColor: Colors.transparent,
        builder: (BuildContext bc) {
          return modalBottomCostom(
            typeModel: "confirm",
            context: context,
            title: title,
            description: description,
            iconIn: Icons.check,
            colorIcon: Colors.green,
          );
        }).then((val) async {

      if(val["confirm"] == "yes") {

        await verification_otp(verifyPinCode);

       }

    });
    ;
  }

}






