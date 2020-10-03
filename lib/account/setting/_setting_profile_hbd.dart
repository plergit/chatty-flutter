
import 'package:chatty/model/member.dart';
import 'package:chatty/services/_auth.dart';
import 'package:chatty/shared/ModalBottomSheet.dart';
import 'package:chatty/shared/widgets/popupLoading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import '../../config/app_config.dart' as config;

class SettingProfileBirthdayWidget extends StatefulWidget {

  @override
  _SettingProfileBirthdayState createState() => new _SettingProfileBirthdayState();
}

class _SettingProfileBirthdayState extends State<SettingProfileBirthdayWidget> {


  TextEditingController txthbd = TextEditingController();

  bool _clickView = false;

  String _dateView = "วันเดือนปีเกิด";
  DateTime _dateSave ;


  @override
  void initState() {


    if(Member.dateOfBirth != null){
      var _day = Member.dateOfBirth.day.toString();
      var _month = Member.dateOfBirth.month.toString();
      var _year = Member.dateOfBirth.year.toString();
      _dateView = "$_day/$_month/$_year";
    }

    super.initState();

  }




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
                                  "วันเกิด",
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

                                  if(_dateSave != null){
                                    _modalAlertConfirm(context, "ยืนยันการแก้ไข", "หากต้องการเปลี่ยนแปลง ให้กด ตกลง หรือ ยกเลิก");
                                  }
                                  else{
                                    _modalAlertError(context, "แจ้งเตือน", "กรุณาระบุ วันเดือนปีเกิด");
                                  }

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
                margin: EdgeInsets.all(0),
//                height: 200,
                width: width,
                decoration: BoxDecoration(
                  color: Colors.white,
//                  borderRadius: BorderRadius.only(
//                    topRight: Radius.circular(20),
//                    topLeft: Radius.circular(20),
//                    bottomLeft: Radius.circular(20),
//                    bottomRight: Radius.circular(20),
//                  ),
                  boxShadow: [
                    BoxShadow(color: Colors.black26, spreadRadius: 0.0, blurRadius: 0),
                  ],
                ),
                child: Column(
                  children: [


                    Container(
                      height:70,
                      decoration: BoxDecoration(
                        color: Colors.white,
//                    color: Colors.green,
                        border: Border(
                          bottom : BorderSide(
                            color: Colors.black26,
                            width: 0.5,
                          ),
                        ),
                      ),
                      margin: EdgeInsets.all(5),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 15,
                          ),
                          Expanded(
                            child: Container(
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(_dateView),
                                )
                            ),
                          ),
                          Container(
                            child: IconButton(
                              alignment: Alignment.center,
                              icon: new ImageIcon(
                                AssetImage(
                                    "assets/images/icons/icon-calendar.png"),
                                size: 25,
                                color: Theme.of(context).accentColor,
                              ),
                              onPressed: (){

                                DatePicker.showDatePicker(context,
                                    showTitleActions: true,
                                    // minTime: DateTime(2018, 3, 5),
                                    maxTime: DateTime(DateTime.now().year, 12, DateTime.now().day) ,
                                    onChanged: (date) {
                                      print('change $date');
                                    }, onConfirm: (date) {

                                      var _day = date.day.toString();
                                      var _month = date.month.toString();
                                      var _year = date.year.toString();

                                      setState(() {
                                        _dateView = "$_day/$_month/$_year";
                                        _dateSave = date;
                                      });

                                      print('confirm $date ');
                                    }, currentTime: DateTime.now(),
                                    locale: LocaleType.th
                                );

                              },
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      height:70,
                      decoration: BoxDecoration(
                        color: Colors.white,
//                    color: Colors.green,
                        border: Border(
                          bottom : BorderSide(
                            color: Colors.black26,
                            width: 0.5,
                          ),
                        ),
                      ),
                      margin: EdgeInsets.all(5),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            child: Container(
                                child: Row(
                                  children: [
                                    Align(
                                      child: Text("แสดงวันเกิด"),
                                    )
                                  ],
                                )
                            ),
                          ),
                          Container(
                            child: Checkbox(
                              value: _clickView,
                              onChanged: (bool value) {
                                setState(() {
                                    _clickView = value;
                                });
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

      // print(val);

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


  _update_birthday() async {

    var _birthday = _dateSave;
    _onLoading();
    var _update = await AuthService().updateBirthday(_birthday);
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

      // print(val);

      if(val["confirm"] == "yes"){
        _update_birthday();
      }


//      Navigator.pop(context);
//      Navigator.pushReplacement(
//          context, MaterialPageRoute( builder: (context) => TabsWidget(
//        currentTab: 0,
//      )
//      ));


      print(val);

    });
    ;
  }


}


