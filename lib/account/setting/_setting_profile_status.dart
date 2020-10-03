
import 'package:chatty/model/member.dart';
import 'package:chatty/services/_auth.dart';
import 'package:chatty/shared/ModalBottomSheet.dart';
import 'package:chatty/shared/widgets/popupLoading.dart';
import 'package:flutter/material.dart';
import '../../config/app_config.dart' as config;

class SettingProfileStatusWidget extends StatefulWidget {

  @override
  _SettingProfileStatusState createState() => new _SettingProfileStatusState();
}

class _SettingProfileStatusState extends State<SettingProfileStatusWidget> {

  TextEditingController statusController = TextEditingController();


  @override
  void initState() {
    super.initState();

    statusController.text = Member.StatusProfile;

  }



  bool _clickpost = false;

  @override
  Widget build(BuildContext context) {

    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
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
                      bottom: 0
                  ),
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
                                  "สถานะ",
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
                            child: InkWell(
                                child: Container(
                                    constraints: BoxConstraints.expand(
                                        height: 35,
                                        width: 70
                                    ),
                                    child: Text("บันทึก",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600,
                                        )
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(16), color: config.HexColor("#79B5B4"),
                                    ),
                                    margin: EdgeInsets.only(right: 15),
                                    padding: EdgeInsets.all(5)),
                                    onTap: () {

                                      _modalAlertConfirm(context, "ยืนยันการแก้ไข", "หากต้องการเปลี่ยนแปลง ให้กด ตกลง หรือ ยกเลิก");

                                    }
                            ),
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
                margin: EdgeInsets.all(20),
                height: 400,
                width: width,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20),
                      topLeft: Radius.circular(20),
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                  ),
                  boxShadow: [
                    BoxShadow(color: Colors.black26, spreadRadius: 0.0, blurRadius: 2),
                  ],
                ),
                child: Column(
                  children: [

                    Expanded(
                      child: Container(
                        margin: EdgeInsets.all(5),
                        child: TextField(
                          controller: statusController,
                          style: TextStyle(fontSize: 14),
                          minLines: 3,
                          maxLines: 50,
                          autocorrect: false,
                          decoration: InputDecoration(
                            hintText: 'สถานะ',
                            filled: true,
                            fillColor: Colors.white,
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,

                          ),
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
//                    color: Colors.green,
                        border: Border(
                          top: BorderSide(
                            color: Colors.black26,
                            width: 0.5,
                          ),
                        ),
                      ),
                      margin: EdgeInsets.all(5),
                      child: Row(
                        children: [

                          Expanded(
                            child: Container(
                              child: Row(
                                children: [
                                  Checkbox(
                                    value: _clickpost,
                                    onChanged: (bool value) {
                                      setState(() {
                                        _clickpost = value;
                                      });
                                    },
                                  ),
                                  Align(
                                    child: Text("โพสต์ไปที่โมเมนต์"),
                                  )
                                ],
                              )
                            ),
                          ),
                          Container(
                            child: IconButton(
                              alignment: Alignment.center,
                              icon: new ImageIcon(
                                AssetImage(
                                    "assets/images/icons/ic-emoji-btn.png"),
                                size: 25,
                                color: Theme.of(context).accentColor,
                              ),
                              onPressed: (){

                              },
                            ),
                          )
                        ],
                      ),
                    )

                  ],
                )
            )
        )
    );

  }

  _update_status() async {

    var _status = statusController.text;
    _onLoading();
    var _update = await AuthService().updateStatus(_status);
    Navigator.pop(context);
    if(_update == "ok"){
      _modalAlertSuccess(context, "สำเร็จ", "เปลี่ยนแปลงข้อมูลเรียบร้อย");
    }

  }

  void _onLoading() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => PopupLoading(),
    );
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

      print(val);

      if(val["confirm"] == "yes"){
        _update_status();
      }




//      Navigator.pop(context);

//      Navigator.pushReplacement(
//          context, MaterialPageRoute( builder: (context) => TabsWidget(
//        currentTab: 0,
//      )
//      ));


//

      print(val);

    });
    ;
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


