import 'package:chatty/model/member.dart';
import 'package:chatty/shared/RaisedGradientButton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../config/app_config.dart' as config;
import 'setting/_setting_profile_email.dart';
import 'setting/_setting_profile_hbd.dart';
import 'setting/_setting_profile_id.dart';
import 'setting/_setting_profile_name.dart';
import 'setting/_setting_profile_phone.dart';
import 'setting/_setting_profile_status.dart';

class ProfileWidget extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<ProfileWidget> {



  Member _member = new Member.init();
  //var _memberInfo ;

  @override
  void initState() {

    //_memberInfo = _member.getMember();

    super.initState();
  }

  String _dateView = "-";

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {




    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;


      if(Member.dateOfBirth != null){
        var _day = Member.dateOfBirth.day.toString();
        var _month = Member.dateOfBirth.month.toString();
        var _year = Member.dateOfBirth.year.toString();
        _dateView = "$_day/$_month/$_year";
      }



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
                                    "โปรไฟล์",
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
                child: InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => SettingProfileNameWidget()));
                  },
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
                                    Member.myName,
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
                )
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
                child: InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => SettingProfileStatusWidget()));
                    },
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
                                  Member.StatusProfile == null ? "" : Member.StatusProfile.toString(),
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
                )),
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
                child: InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => SettingProfilePhoneWidget()));
                    },
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
                                  Member.myMobilePhone == "" ? "-" : Member.myMobilePhone,
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
                )),
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
                child: InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => SettingProfileBirthdayWidget()));
                    },
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
                )),
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
                child: InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => SettingProfileIdWidget()));
                    },
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
                )),
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
                child: InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => SettingProfileEmailWidget()));
                    },
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
                                  Member.myEmail == null ? "-" : Member.myEmail,
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
                )),
              ),

            ],
          ),

        ));
  }


}



class MenuTabContent {
  String menuName;
  MenuTabContent.name(this.menuName);
}

