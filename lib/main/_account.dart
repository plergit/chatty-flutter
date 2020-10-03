import 'dart:io';

import 'package:chatty/model/member.dart';
import 'package:chatty/services/_connect.dart';
import 'package:chatty/shared/files/imagePicker/imagePicker.dart';
import 'package:chatty/shared/widgets/mycircleavatar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:qr_mobile_vision/qr_camera.dart';
import '../config/app_config.dart' as config;

import 'package:path/path.dart' as Path;


class AccountWidget extends StatefulWidget {
  @override
  _AccountWidgetState createState() => _AccountWidgetState();
}

class _AccountWidgetState extends State<AccountWidget>  {

  Member _member = new Member.init();


  File _imageBgProfile;
  Map<String, dynamic> _objBgProfileImg ;

  String _dateView = "-";

  @override
  initState() {
    super.initState();


    if(Member.dateOfBirth != null){
      var _day = Member.dateOfBirth.day.toString();
      var _month = Member.dateOfBirth.month.toString();
      var _year = Member.dateOfBirth.year.toString();
      _dateView = "$_day/$_month/$_year";
    }


  }



  @override
  void dispose() {
    super.dispose();
  }


  _load_bg_profile() async{

    var _ddd = await firebaseCon.firestore_.collection("Members").doc(Member.myUid).get();
    Member.photoBgUrl = _ddd.data()["photoBgUrl"];

  }


  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;


    return Scaffold(
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(50.0),
            child: AppBar(
              elevation: 1,
              backgroundColor: Theme.of(context).accentColor,
              automaticallyImplyLeading: false, // hides leading widget
              flexibleSpace: Container(
                  padding: EdgeInsets.only(
                      left: 4,
                      right: 5,
                      top: MediaQuery.of(context).padding.top,
                      bottom: 0),
                  width: MediaQuery.of(context).size.width,
                  child: Wrap(direction: Axis.horizontal, children: <Widget>[
                    Container(
                      height: 50,
                      width: double.infinity,
                      child: Stack(children: <Widget>[
                        Align(
                          alignment: Alignment.topLeft,
                          child: Container(
                            height: 50.0,
                            width: 90.0,
                            child: Center(
                                child: Text(
                                  "Account",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w600,
                                      color: Theme.of(context).primaryColor),
                                ),
                              ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.topCenter,
                          child: Container(
                              height: 50.0,
                              width: 150.0,
                          ),
                        ),
                        Align(
                          alignment: Alignment.topRight,
                          child: Container(
                            height: 50.0,
                            width: 50.0,
                            child: IconButton(
                              padding: EdgeInsets.only(left: 10,right: 5),
                              onPressed:  ()  {

                                Navigator.of(context).pushNamed('/setting_profile', arguments: 1);

                              },
                              icon: new ImageIcon(
                                AssetImage("assets/images/icons/icon-setting.png"),
                                size: 20,
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                          ),
                        ),
                      ]),
                      ),
                    ])
              ),
            )
        ),
//        backgroundColor: Theme.of(context).backgroundColor,
        body: new GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(new FocusNode());
          },
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            padding: EdgeInsets.symmetric(vertical: 0),
//            shrinkWrap: true,
            primary: false,
            child: Wrap(
              direction: Axis.vertical,
              crossAxisAlignment: WrapCrossAlignment.start,
              children: <Widget>[

                Container(
                    height: 200.0,
                    width: width,
                    color: Colors.white,
                    margin: const EdgeInsets.only(bottom: 0),
                    child: Stack(

                      children: <Widget>[

                        Member.photoBgUrl != null ? Container(
                          alignment: Alignment.topCenter,
                          height: 150.0,
                          width: width,
                          decoration: new BoxDecoration(
                            color: Colors.black38.withOpacity(0.15),
                            image: new DecorationImage(
                              image: NetworkImage(Member.photoBgUrl),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ) : Container(
                          alignment: Alignment.topCenter,
                          height: 150.0,
                          width: width,
                          decoration: new BoxDecoration(
                            image: new DecorationImage(
                              image: new AssetImage("assets/images/bg-profile.png"),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),

                        Container(
                          alignment: Alignment.topCenter,
                          height: 150.0,
                          width: width,
                          decoration: new BoxDecoration(
                            color: Colors.black12.withOpacity(0.4),
                          ),
                        ),
                        Positioned(
                          bottom: 50,
                          right: 10,
                          width: 30,
                          height: 30,
                          child: Container(
                            decoration: BoxDecoration(
                              color:  Colors.black45,
                              shape: BoxShape.circle,
                            ),
                            child: IconButton(
                              padding: EdgeInsets.only(left: 5,right: 5,top: 5,bottom: 5),
                              onPressed:  ()  {

                                showModalBottomSheet(

                                    context: context,
                                    isDismissible: false,
                                    elevation: 0,
                                    useRootNavigator: false,
                                    backgroundColor: Colors.transparent,
                                    builder: (BuildContext bc) {
                                      return ImagePickerWidget(
                                        context: context,
                                      );
                                    }).then((val) async{

                                  if(val != null)
                                  {
                                    //print(val);
                                    Navigator.of(context)
                                        .pushNamed('/settingImageProfile', arguments: {
                                          "_file" : val,
                                          "_type" : "bg"
                                        }).then((value) => {

                                          setState(() {

                                          }),

                                        });
                                  }
                                });


                              },
                              icon: Icon(
                                Icons.camera_alt,
                                color: Theme.of(context).primaryColor,
                                size: 20,
                              ),
                            ),
                          ),
                        ),

                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            height: 110,
                            width: 110,
                            padding: const EdgeInsets.all(4.0),
                            margin: const EdgeInsets.only(bottom : 6.0),
                            decoration: BoxDecoration(
                              color: Theme.of(context)
                                  .primaryColor
                                  .withOpacity(1.0),
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                    color: Theme.of(context)
                                        .hintColor
                                        .withOpacity(0.10),
                                    offset: Offset(0, 2),
                                    blurRadius: 4
                                )

                              ],
                            ),
                            child: Stack(
                              children: <Widget>[

                                Container(
                                  width: 120,
                                  height: 120,
                                  child: MyCircleAvatar(
                                    imgUrl: Member.photoUrl,
                                     width: 119,
                                     height: 119,
                                  ),

                                ),

                                Positioned(
                                  bottom : 0,
                                  right: 0,
                                  left: 0,
                                  height: 40,
                                  child: Container(
                                    decoration: BoxDecoration(
//                                      color:  Colors.black38,
                                    ),
                                    child: IconButton(
                                      padding: EdgeInsets.only(left: 5,right: 5,top: 5,bottom: 5),
                                      onPressed:  ()  {

                                        showModalBottomSheet(
                                            context: context,
                                            isDismissible: false,
                                            elevation: 0,
                                            useRootNavigator: false,
                                            backgroundColor: Colors.transparent,
                                            builder: (BuildContext bc) {
                                              return ImagePickerWidget(
                                                context: context,
                                              );
                                            }).then((val) async{

                                          if(val != null)
                                          {
//                                  print(val);
                                            Navigator.of(context)
                                                .pushNamed('/settingImageProfile', arguments: {
                                              "_file" : val,
                                              "_type" : "logo"
                                            }).then((value) => {
                                              setState(() {

                                              }),
                                            });

                                          }
                                        });
                                      },
                                      icon: Icon(
                                        Icons.camera_alt,
                                        color: Theme.of(context).primaryColor,
                                        size: 20,
                                      ),
                                    ),
                                  ),
                                )

                              ],
                            ),
                          )
                        ),

                      ],
                    )
                ),

                Stack(
                  children: <Widget>[
                    Container(
                      height: 80,
                      padding : const EdgeInsets.only(bottom: 15,top: 15),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border(
                          bottom: BorderSide(
                            color: Colors.black12,
                            width: 0.5,
                          ),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Expanded(
                            child: Container(

                              margin: const EdgeInsets.only(left: 20,bottom: 0),
                              child: Text(
                                "ชื่อ",
                                style: TextStyle(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                              child:Container(
                                width: width,
                                margin: const EdgeInsets.only(left: 15,bottom: 0),
                                child: Container(
                                  width: 150,
                                  child: Row(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                    MainAxisAlignment.start,
                                    children: <Widget>[
                                      SizedBox(width: 5),
                                      Text(
                                        Member.myName == null ? "-" : Member.myName,
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400,
                                            color: Theme.of(context).accentColor
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              )
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      bottom: 10,
                      right: 25,
                      width: 55,
                      height: 60,
                      child: InkWell(
                        onTap: (){
//                          print("sssss");
                          _recheck_on_qr = false;
                          _showDialog();

                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.black12,
                            //border: new Border.all(color: Colors.teal[200], width: 1.4),
                            borderRadius: new BorderRadius.circular(15.0),
                          ),
                          child: Column(
                            children: <Widget>[
                              Expanded(
                                child: Container(
                                  padding : const EdgeInsets.only(bottom: 0,top: 3),
                                  child: ImageIcon(
                                    AssetImage("assets/images/icons/icon-qr-code.png"),
                                    size: 35,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              Container(
                                padding : const EdgeInsets.only(bottom: 3,top: 3),
                                child: Text("My QR"),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),

                  ],
                ),

                Container(
                  height: 80,
                  padding : const EdgeInsets.only(bottom: 15,top: 15),
                  decoration: BoxDecoration(
                    color: Colors.white,
//                    color: Colors.green,
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.black12,
                        width: 0.5,
                      ),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(
                        child: Container(

                          margin: const EdgeInsets.only(left: 20,bottom: 0),
                          child: Text(
                            "สถานะ",
                            style: TextStyle(
                                fontSize: 14.0,
                                fontWeight: FontWeight.w400,
                                color: Colors.black
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                          child:Container(
                            width: width,
                            margin: const EdgeInsets.only(left: 15,bottom: 0),
                            child: Container(
                              width: 150,
                              child: Row(
                                crossAxisAlignment:
                                CrossAxisAlignment.center,
                                mainAxisAlignment:
                                MainAxisAlignment.start,
                                children: <Widget>[
                                  SizedBox(width: 5),
                                  Text(
                                   Member.StatusProfile == null || Member.StatusProfile == "" ? "สถานะ?" : Member.StatusProfile,
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                        color: Theme.of(context).accentColor
                                    ),
                                  )
                                ],
                              ),
                            ),
                          )
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 80,
                  padding : const EdgeInsets.only(bottom: 15,top: 15),
                  decoration: BoxDecoration(
                    color: Colors.white,
//                    color: Colors.green,
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.black12,
                        width: 0.5,
                      ),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(
                        child: Container(

                          margin: const EdgeInsets.only(left: 20,bottom: 0),
                          child: Text(
                            "หมายเลขโทรศัพท์",
                            style: TextStyle(
                                fontSize: 14.0,
                                fontWeight: FontWeight.w400,
                                color: Colors.black
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                          child:Container(
                            width: width,
                            margin: const EdgeInsets.only(left: 15,bottom: 0),
                            child: Container(
                              width: 150,
                              child: Row(
                                crossAxisAlignment:
                                CrossAxisAlignment.center,
                                mainAxisAlignment:
                                MainAxisAlignment.start,
                                children: <Widget>[
                                  SizedBox(width: 5),
                                  Text(
                                    Member.myMobilePhone == "" || Member.myMobilePhone == null ? "-" : Member.myMobilePhone,
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                        color: Theme.of(context).accentColor
                                    ),
                                  )
                                ],
                              ),
                            ),
                          )
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 80,
                  padding : const EdgeInsets.only(bottom: 15,top: 15),
                  decoration: BoxDecoration(
                    color: Colors.white,
//                    color: Colors.green,
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.black12,
                        width: 0.5,
                      ),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(
                        child: Container(

                          margin: const EdgeInsets.only(left: 20,bottom: 0),
                          child: Text(
                            "วันเกิด",
                            style: TextStyle(
                                fontSize: 14.0,
                                fontWeight: FontWeight.w400,
                                color: Colors.black
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                          child:Container(
                            width: width,
                            margin: const EdgeInsets.only(left: 15,bottom: 0),
                            child: Container(
                              width: 150,
                              child: Row(
                                crossAxisAlignment:
                                CrossAxisAlignment.center,
                                mainAxisAlignment:
                                MainAxisAlignment.start,
                                children: <Widget>[
                                  SizedBox(width: 5),
                                  Text(
                                    _dateView,
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                        color: Theme.of(context).accentColor
                                    ),
                                  )
                                ],
                              ),
                            ),
                          )
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 80,
                  padding : const EdgeInsets.only(bottom: 15,top: 15),
                  decoration: BoxDecoration(
                    color: Colors.white,
//                    color: Colors.green,
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.black12,
                        width: 0.5,
                      ),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(
                        child: Container(

                          margin: const EdgeInsets.only(left: 20,bottom: 0),
                          child: Text(
                            "ID",
                            style: TextStyle(
                                fontSize: 14.0,
                                fontWeight: FontWeight.w400,
                                color: Colors.black
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                          child:Container(
                            width: width,
                            margin: const EdgeInsets.only(left: 15,bottom: 0),
                            child: Container(
                              width: 150,
                              child: Row(
                                crossAxisAlignment:
                                CrossAxisAlignment.center,
                                mainAxisAlignment:
                                MainAxisAlignment.start,
                                children: <Widget>[
                                  SizedBox(width: 5),
                                  Text(
                                    Member.myMemberID == null ? '-' : Member.myMemberID,
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                        color: Theme.of(context).accentColor
                                    ),
                                  )
                                ],
                              ),
                            ),
                          )
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 80,
                  padding : const EdgeInsets.only(bottom: 15,top: 15),
                  decoration: BoxDecoration(
                    color: Colors.white,
//                    color: Colors.green,
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.black12,
                        width: 0.5,
                      ),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(
                        child: Container(

                          margin: const EdgeInsets.only(left: 20,bottom: 0),
                          child: Text(
                            "อีเมล์",
                            style: TextStyle(
                                fontSize: 14.0,
                                fontWeight: FontWeight.w400,
                                color: Colors.black
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                          child:Container(
                            width: width,
                            margin: const EdgeInsets.only(left: 15,bottom: 0),
                            child: Container(
                              width: 150,
                              child: Row(
                                crossAxisAlignment:
                                CrossAxisAlignment.center,
                                mainAxisAlignment:
                                MainAxisAlignment.start,
                                children: <Widget>[
                                  SizedBox(width: 5),
                                  Text(
                                      Member.myEmail == null ? '-' : Member.myEmail,
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                        color: Theme.of(context).accentColor
                                    ),
                                  )
                                ],
                              ),
                            ),
                          )
                      ),
                    ],
                  ),
                ),

              ],
            )



          ),
        )
    );
  }


  _qrCallback(String code) {
    // setState(() {
    //   _camState = false;
    // });
  }


 Widget _read_qr = Center(
   child: SizedBox(
   height: 300,
   width: 300,
     child: QrCamera(
       onError: (context, error) => Text(
         error.toString(),
         style: TextStyle(color: Colors.red),
       ),
       qrCodeCallback: (code) {
         // _qrCallback(code);
       },
       // child:
     ),
   ),
 );

 Widget _view_qr = Center(
   child: SizedBox(
     height: 300,
     width: 300,
     child:  QrImage(
       data: Member.myUid,
       version: QrVersions.auto,
       size: 250.0,
     ),
   ),
 );

  bool _recheck_on_qr = false;

  Widget popup_qr(BuildContext context, double _height, double _width){

    //print(_recheck_on_qr);

    Widget _w = Container(
//  height: _height ,
      height: 500 ,
      width: _width ,
      color: Colors.transparent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[

          Container(
            decoration: BoxDecoration(
              color: Colors.transparent,
              border: Border(
                bottom: BorderSide(
                  color: Colors.black26,
                  width: 0.5,
                ),
              ),
            ),

            padding: EdgeInsets.symmetric(horizontal: 13, vertical: 13),
            margin: const EdgeInsets.only(left: 0,top: 1,bottom: 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  width: 50,
                  height: 50,
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    backgroundImage: NetworkImage(Member.photoUrl),
                  ),
                ),
                SizedBox(width: 10),
                Container(
                    height: 50,
                    color: Colors.transparent,
                    child:Container(
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            Member.myName == null ? "-" : Member.myName,
                            overflow: TextOverflow.fade,
                            softWrap: false,
                            maxLines: 1,
                            style: Theme.of(context).textTheme.body2.merge(
                                TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15,
                                    color: Colors.black87
                                )
                            ),
                          ),
                        )
                    )
                )
              ],
            ),
          ),


          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Center(
               child: _recheck_on_qr == false ? _view_qr : _read_qr
              ),
            ),
          ),

          Container(
              color: config.HexColor("#f1f1f1"),
              width: double.infinity,
              padding: const EdgeInsets.only(left: 0,right: 0 ,top: 8, bottom: 8),
              height: 60,
              child: Row(

                children: <Widget>[
                  Expanded(
                    child: Container(
                      child: Center(
                        child: ImageIcon(
                          AssetImage("assets/images/icons/icon-download.png"),
                          size: 20,
                          color: Theme.of(context).accentColor,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      child: Center(
                        child: ImageIcon(
                          AssetImage("assets/images/icons/icon-sheard.png"),
                          size: 20,
                          color: Theme.of(context).accentColor,
                        ),
                      ),
                    ),
                  ),
                ],
              )
          ),
          InkWell(
            onTap: (){

              // print(_recheck_on_qr);

//              _recheck_on_qr = true;
            setState(() {
                _recheck_on_qr == false
                    ? _recheck_on_qr = true
                    : _recheck_on_qr = false;
                Navigator.of(context).pop();
                _showDialog();

              });

            },
            child: Container(

                color: Colors.transparent,
                width: double.infinity,
                padding: const EdgeInsets.only(left: 0,right: 0 ,top: 8, bottom: 8),
                height: 60,
                child: Align(

                  alignment: AlignmentDirectional.center,

                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[

                      ImageIcon(
                        AssetImage("assets/images/icons/search-by-qr-code.png"),
                        size: 20,
                        color: Theme.of(context).accentColor,
                      ),

                      Container(
                        margin: const EdgeInsets.only(left: 10),
                        child: Center(
                          child: Text(
                              _recheck_on_qr == false ? "แสกน QR Code" : "QR Code ของฉัน"
                          ),
                        ),
                      )

                    ],
                  ),
                )
            ),
          )

        ],
      ),
    );
    return _w;
  }


  Future<Null> _showDialog() async {

    return showDialog(
        context: context,
        builder: (_) => new AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius:
                BorderRadius.all(
                    Radius.circular(20.0))),
            contentPadding: EdgeInsets.all(0.0),
            content: Builder(
                builder: (context) {
                  // Get available height and width of the build area of this widget. Make a choice depending on the size.
                  var _height = MediaQuery.of(context).size.height;
                  var _width = MediaQuery.of(context).size.width;

                  return popup_qr(context ,_height,_width);
                }
            )
        )
    );
  }






}
