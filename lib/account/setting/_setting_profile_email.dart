
import 'package:chatty/model/member.dart';
import 'package:chatty/services/_auth.dart';
import 'package:chatty/shared/ModalBottomSheet.dart';
import 'package:chatty/shared/widgets/popupLoading.dart';
import 'package:flutter/material.dart';
import '../../config/app_config.dart' as config;

class SettingProfileEmailWidget extends StatefulWidget {

  @override
  _SettingProfileState createState() => new _SettingProfileState();
}

class _SettingProfileState extends State<SettingProfileEmailWidget> {

  TextEditingController emailController = TextEditingController();

  @override
  void initState() {
    super.initState();

    emailController.text = Member.myEmail;

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
                                  "อีเมล์",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w600,
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
            child: Container(
                padding: EdgeInsets.all(12),
                color: Colors.white,
                child: Column(
                  children: [


                    Container(
                      height: 50,
//                        padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16)
                      ),
                      child: TextField(
                        keyboardType: TextInputType.emailAddress,
                        style: TextStyle(color: Theme.of(context).hintColor),
                        controller: emailController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'อีเมล์บัญชีผู้ใช้',
                          prefixIcon: ImageIcon(
                            AssetImage("assets/images/icons/icon_name.png"  ),
                            size: 20,
                            color: Colors.black26,
                          ),
                          suffixIcon: const Icon(Icons.clear, color: Colors.grey,),
                          suffixStyle: const TextStyle(color: Colors.grey),
                          hintStyle: TextStyle(color: Colors.black26 , fontSize: 15),
                        ),
                      ),

                    ),

                    buildButtonSignUp(context),

                  ],
                )
            )
        )
    );


  }




  Widget buildButtonSignUp(BuildContext context) {
    return InkWell(
        child: Container(
            constraints: BoxConstraints.expand(
                height: 50
            ),
            child: Text("เปลี่ยนอีเมล์",
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

          if(emailController.text.isEmpty){
            _modalAlertError(context, "แจ้งเตือน", "กรุณาระบุ อีเมล์บัญชีผู้ใช้ ที่ต้องการ");
          }
          else{
            _modalAlertConfirm(context, "ยืนยันการแก้ไข", "หากต้องการเปลี่ยนแปลง ให้กด ตกลง หรือ ยกเลิก");
          }

        }
    );
  }


  _update_myemail() async {

    _onLoading();
    var _name = emailController.text;
    var _update = await AuthService().updateEmail(_name);
    Navigator.pop(context);

    if(_update == "ok"){
      _modalAlertSuccess(context, "สำเร็จ", "เปลี่ยนแปลงข้อมูลเรียบร้อย");
    }
    else if(_update == "repeatedly"){
      _modalAlertError(context, "แจ้งเตือน", "มี Email นี้ในระบบแล้ว กรุณาใช้ Email อื่น");
    }
    else{
      _modalAlertError(context, "แจ้งเตือน", "ไมสามารถบันทึกข้อมูลได้");
    }

    // if(_update == "ok"){
    //   _modalAlertSuccess(context, "สำเร็จ", "เปลี่ยนแปลงข้อมูลเรียบร้อย");
    // }

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
        }).then((val) {

      if(val["confirm"] == "yes"){
        _update_myemail();
      }

    });
    ;
  }

}

