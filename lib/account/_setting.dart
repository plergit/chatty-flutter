import 'package:chatty/model/member.dart';
import 'package:chatty/shared/ModalBottomSheet.dart';
import 'package:chatty/shared/RaisedGradientButton.dart';
import 'package:chatty/shared/widgets/mycircleavatar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../config/app_config.dart' as config;
import '../main.dart';
import 'auth/_signin.dart';

class SettingProfileWidget extends StatefulWidget {
  @override
  _SettingProfileState createState() => _SettingProfileState();
}

class _SettingProfileState extends State<SettingProfileWidget> {

  Member _member = new Member.init();

  @override
  void initState() {

    super.initState();
  }



  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: Scaffold(
          appBar: PreferredSize(
              preferredSize: Size.fromHeight(55.0),
              child: AppBar(
                elevation: 0,
                backgroundColor: Theme.of(context).accentColor,
                automaticallyImplyLeading: false, // hides leading widget
                flexibleSpace: Container(
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
                                    "ตั้งค่า",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w600,
                                        color: Theme.of(context).primaryColor),
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
                                        "assets/images/icons/icon-back.png"),
                                    size: 20,
                                    color: Theme.of(context).primaryColor,
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
          body: ListView(
            physics: BouncingScrollPhysics(),
            children: <Widget>[
              Container(
                  color: config.HexColor("#f1f1f1"),
                  width: double.infinity,
                  padding: const EdgeInsets.only(left: 20,right: 0 ,top: 8, bottom: 8),
                  height: 40,
                  child: Text(
                    "ข้อมูลของฉัน",
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                        color: Colors.black87

                    ),
                  ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: config.HexColor("#ffffff"),
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
                      child: MyCircleAvatar(
                        imgUrl: Member.photoUrl,
                        width: 50,
                        height: 50,
                      ),
                    ),
                    SizedBox(width: 10),
                    Flexible(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Expanded(
                              child: Container(
                                  height: 50,
                                  child:Container(
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          "โปรไฟล์",
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
                          ),
                          Expanded(
                              child: InkWell(
                                onTap: (){
                                  Navigator.of(context).pushNamed('/profile', arguments: 1);
                                },
                                child: Container(
                                    height: 50,
                                    child:Container(
                                        child: Align(
                                          alignment: Alignment.centerRight,
                                          child: Text(
                                            Member.myName,
                                            overflow: TextOverflow.fade,
                                            softWrap: false,
                                            maxLines: 1,
                                            style: Theme.of(context).textTheme.body2.merge(
                                                TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 15,
                                                  color: Colors.teal[200],
                                                )
                                            ),
                                          ),
                                        )
                                    )
                                ),
                              )
                          ),
                          Container(
                            margin: const EdgeInsets.only(left: 5),
                            child: ImageIcon(
                              AssetImage(
                                  "assets/images/icons/icon-drop-right.png"),
                                  size: 15,
                                  color: Theme.of(context).accentColor,
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      margin: const EdgeInsets.only(left: 15,bottom: 0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                      ),
                      child: InkWell(
                        child: SizedBox(
                          height: 65,
                          width: double.infinity,
                          child: Container(
                            width: 150,
                            child: Row(
                              crossAxisAlignment:
                              CrossAxisAlignment.center,
                              mainAxisAlignment:
                              MainAxisAlignment.start,
                              children: <Widget>[
                                SizedBox(width: 8),
                                ImageIcon(
                                  AssetImage("assets/images/icons/icon-pass.png"),
                                  size: 20,
                                  color: Theme.of(context).accentColor,
                                ),
                                SizedBox(width: 15),
                                Expanded(
                                  child:  Text(
                                    'รหัสผ่าน',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        onTap: () async {

                        },
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      margin: const EdgeInsets.only(left: 15,bottom: 0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                      ),
                      child: InkWell(
                        child: SizedBox(
                          height: 65,
                          width: double.infinity,
                          child: Container(
                            width: 150,
                            child: Row(
                              crossAxisAlignment:
                              CrossAxisAlignment.center,
                              mainAxisAlignment:
                              MainAxisAlignment.start,
                              children: <Widget>[
                                SizedBox(width: 8),
                                ImageIcon(
                                  AssetImage("assets/images/icons/icon-qr.png"),
                                  size: 20,
                                  color: Theme.of(context).accentColor,
                                ),
                                SizedBox(width: 15),
                                Expanded(
                                  child:  Text(
                                    'QR Code',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        onTap: () async {

                        },
                      ),
                    ),
                  ],
                ),
              ),

              Container(
                color: config.HexColor("#f1f1f1"),
                width: double.infinity,
                padding: const EdgeInsets.only(left: 20,right: 0 ,top: 8, bottom: 8),
                height: 40,
                child: Text(
                  "ตั้งค่าทั้วไป",
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                      color: Colors.black87

                  ),
                ),
              ),
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      margin: const EdgeInsets.only(left: 15,bottom: 0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                      ),
                      child: InkWell(
                        child: SizedBox(
                          height: 65,
                          width: double.infinity,
                          child: Container(
                            width: 150,
                            child: Row(
                              crossAxisAlignment:
                              CrossAxisAlignment.center,
                              mainAxisAlignment:
                              MainAxisAlignment.start,
                              children: <Widget>[
                                SizedBox(width: 8),
                                ImageIcon(
                                  AssetImage("assets/images/icons/icon-noti.png"),
                                  size: 20,
                                  color: Theme.of(context).accentColor,
                                ),
                                SizedBox(width: 15),
                                Expanded(
                                  child:  Text(
                                    'การแจ้งเตือน',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        onTap: () async {

                        },
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      margin: const EdgeInsets.only(left: 15,bottom: 0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                      ),
                      child: InkWell(
                        child: SizedBox(
                          height: 65,
                          width: double.infinity,
                          child: Container(
                            width: 150,
                            child: Row(
                              crossAxisAlignment:
                              CrossAxisAlignment.center,
                              mainAxisAlignment:
                              MainAxisAlignment.start,
                              children: <Widget>[
                                SizedBox(width: 8),
                                ImageIcon(
                                  AssetImage("assets/images/icons/icon-picn-video.png"),
                                  size: 20,
                                  color: Theme.of(context).accentColor,
                                ),
                                SizedBox(width: 15),
                                Expanded(
                                  child:  Text(
                                    'รูป & วีดีโอ',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        onTap: () async {

                        },
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      margin: const EdgeInsets.only(left: 15,bottom: 0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                      ),
                      child: InkWell(
                        child: SizedBox(
                          height: 65,
                          width: double.infinity,
                          child: Container(
                            width: 150,
                            child: Row(
                              crossAxisAlignment:
                              CrossAxisAlignment.center,
                              mainAxisAlignment:
                              MainAxisAlignment.start,
                              children: <Widget>[
                                SizedBox(width: 8),
                                ImageIcon(
                                  AssetImage("assets/images/icons/icon-moment.png"),
                                  size: 20,
                                  color: Theme.of(context).accentColor,
                                ),
                                SizedBox(width: 15),
                                Expanded(
                                  child:  Text(
                                    'โมเมนต์',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        onTap: () async {

                        },
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      margin: const EdgeInsets.only(left: 15,bottom: 0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                      ),
                      child: InkWell(
                        child: SizedBox(
                          height: 65,
                          width: double.infinity,
                          child: Container(
                            width: 150,
                            child: Row(
                              crossAxisAlignment:
                              CrossAxisAlignment.center,
                              mainAxisAlignment:
                              MainAxisAlignment.start,
                              children: <Widget>[
                                SizedBox(width: 8),
                                ImageIcon(
                                  AssetImage("assets/images/icons/icon-lang.png"),
                                  size: 20,
                                  color: Theme.of(context).accentColor,
                                ),
                                SizedBox(width: 15),
                                Expanded(
                                  child:  Text(
                                    'ภาษา',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black
                                    ),
                                  ),
                                ),
                                Container(
                                  child:  Text(
                                    'ไทย',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.teal[300]
                                    ),
                                  ),
                                ),
                                SizedBox(width: 5),
                                ImageIcon(
                                  AssetImage(
                                      "assets/images/icons/icon-drop-right.png"),
                                  size: 15,
                                  color: Theme.of(context).accentColor,
                                ),
                                SizedBox(width: 25),
                              ],
                            ),
                          ),
                        ),
                        onTap: () async {

                        },
                      ),
                    ),
                  ],
                ),
              ),

              Container(
                color: config.HexColor("#f1f1f1"),
                width: double.infinity,
                padding: const EdgeInsets.only(left: 20,right: 0 ,top: 8, bottom: 8),
                height: 40,
                child: Text(
                  "อื่่นๆ",
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                      color: Colors.black87

                  ),
                ),
              ),
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      margin: const EdgeInsets.only(left: 15,bottom: 0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                      ),
                      child: InkWell(
                        child: SizedBox(
                          height: 65,
                          width: double.infinity,
                          child: Container(
                            width: 150,
                            child: Row(
                              crossAxisAlignment:
                              CrossAxisAlignment.center,
                              mainAxisAlignment:
                              MainAxisAlignment.start,
                              children: <Widget>[
                                SizedBox(width: 8),
                                ImageIcon(
                                AssetImage("assets/images/icons/icon-about.png"),
                                size: 20,
                                color: Theme.of(context).accentColor,
                              ),
                                SizedBox(width: 15),
                                Expanded(
                                  child:  Text(
                                    'เกียวกับ Chatty',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        onTap: () async {

                        },
                      ),
                    ),
                  ],
                ),
              ),

              InkWell(
                onTap: () {
                  _modalAlertConfirm(context, "ยืนยันการออกจากระบบ", "หากต้องการออกจากระบบ ให้กด ตกลง หรือ ยกเลิกเพื่อใช้งานต่อ");
                },
                child: new Container(
                  //width: 100.0,
                  height: 46.0,
                  margin: EdgeInsets.only(top: 10, bottom: 15 ,left: 20 , right: 20),
                  decoration: new BoxDecoration(
                    color: Colors.white,
                    border: new Border.all(color: Colors.teal[200], width: 2.0),
                    borderRadius: new BorderRadius.circular(15.0),
                  ),
                  child: new Center(child: new Text(
                    'ออกจากระบบ',
                    style: new TextStyle(
                        fontSize: 18.0,
                        color: Colors.teal[200]
                    ),
                  ),
                  ),
                ),
              ),

            ],
          ),

        ));
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;


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
            signOut(context);
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

  void signOut(BuildContext context) {
    _auth.signOut();

    Navigator.of(context).pop();
    Navigator.of(context).pop();

//    Navigator.push(
//      context,
//      MaterialPageRoute(builder: (context) => SignInWidget()),
//    );
//    runApp(MaterialApp(home: SplashScreen()));

    // Navigator.pushAndRemoveUntil(
    //     context,
    //     PageRouteBuilder(pageBuilder: (BuildContext context, Animation animation,
    //         Animation secondaryAnimation) {
    //       return SignInWidget();
    //     }, transitionsBuilder: (BuildContext context, Animation<double> animation,
    //         Animation<double> secondaryAnimation, Widget child) {
    //       return new SlideTransition(
    //         position: new Tween<Offset>(
    //           begin: const Offset(1.0, 0.0),
    //           end: Offset.zero,
    //         ).animate(animation),
    //         child: child,
    //       );
    //     }), (Route route) => false);

//    Navigator.pushAndRemoveUntil(
//        context,
//        ModalRoute.withName("/SplashScreen"),
//        ModalRoute.withName("/Home")
//    );

   Navigator.of(context).push(PageRouteBuilder(
       opaque: false,
       pageBuilder: (BuildContext context, _, __) =>
           SignInWidget()
   ));


  }



}



class MenuTabContent {
  String menuName;
  MenuTabContent.name(this.menuName);
}

