import 'dart:ffi';

import 'package:chatty/account/_home_profile.dart';
import 'package:chatty/chat/_room_chat.dart';
import 'package:chatty/friend/_friend.dart';
import 'package:chatty/friend/_favorite.dart';
import 'package:chatty/friend/_menu_home.dart';
import 'package:chatty/friend/_profile_myfriend.dart';
import 'package:chatty/model/friend.dart';
import 'package:chatty/model/member.dart';
import 'package:chatty/services/_connect.dart';
import 'package:chatty/shared/widgets/mycircleavatar.dart';
import 'package:chatty/shared/widgets/waiting_image_searching.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../config/app_config.dart' as config;


class HomeWidget extends StatefulWidget {
  @override
  _HomeWidgetState createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> with TickerProviderStateMixin {

  Member _member = new Member.init();
  Friend _friend = new Friend.init();
  var _memberInfo ;


  List<Map<String, dynamic>> friendsList = [];
  List<Map<String, dynamic>> favoriteList  = [];

  GlobalKey globalKey = new GlobalKey(debugLabel: 'btm_app_bar');

  @override
  void initState() {

    try{

      _friend.getFriendsList().then((result) {
        setState(() {
          friendsList = result;
        });
      });

      _friend.getFavoriteList().then((result) {
        setState(() {
          favoriteList = result;
        });
      });

      if(Member.photoBgUrl == ""){
        _load_bg_profile();
      }

    }
    catch(e){
      print(e.toString());
    }


    super.initState();
  }

  @override
  void dispose() {

    super.dispose();

  }


  _load_bg_profile() async{

    var _ddd = await firebaseCon.firestore_.collection("Members").document(Member.myUid).get();
    setState(() {
      Member.photoBgUrl = _ddd.data()["ImgBgUrl"];
      Member.StatusProfile = _ddd.data()["StatusProfile"];
    });

  }


  List<Map<String, dynamic>> menuList = [
    {
      'id': '1',
      'imgUrl': 'assets/images/icons/icon-friend.png',
      'name': 'Friends'
    },
    {
      'id': '2',
      'imgUrl': 'assets/images/icons/icon-group.png',
      'name': 'Groups'
    },
    {
      'id': '3',
      'imgUrl': 'assets/images/icons/icon-officials.png',
      'name': 'Officials'
    },
    {
      'id': '4',
      'imgUrl': 'assets/images/icons/icon-sticker.png',
      'name': 'Sticker'
    },
    {
      'id': '5',
      'imgUrl': 'assets/images/icons/icon-service.png',
      'name': 'Service'
    }
  ];


  @override
  Widget build(BuildContext context) {
    double _bar = MediaQuery.of(context).padding.top;

    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

    int _countFriend = friendsList == null ? 0 : friendsList.length;

    return Scaffold(

      appBar: PreferredSize(
          preferredSize: Size.fromHeight(100.0),
          child: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            automaticallyImplyLeading: false, // hides leading widget
            flexibleSpace: Container(
                padding: EdgeInsets.only(left: 0 ,right: 0, top : MediaQuery.of(context).padding.top, bottom: 0),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Theme.of(context).accentColor,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20)),
                ),
                child: Wrap(
                    direction: Axis.horizontal,
                    children: <Widget>[
                      Container(
                        height: 45,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              margin: const EdgeInsets.only(left: 15,top: 0),
                              child: Text(
                                // "CHAT",
                                "CHATTY",
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white ,
                                    fontSize: 16
                                ),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(right: 8,top: 5),
                              child:  Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  IconButton(
                                    padding: EdgeInsets.only(left: 10,right: 15),
                                    onPressed:  ()  {

                                      Navigator.of(context)
                                          .pushNamed('/add_friend', arguments: 1).then((value){



                                           if(value != null){
                                             Map<String, dynamic> _obj = value;
                                             if(_obj["action"] == "addfriend"){

                                               _friend.getFriendsList().then((result) {
                                                 setState(() {
                                                   friendsList = result;
                                                 });
                                               });

                                               // print(value);
                                             }

                                           }

                                           // Map<String, dynamic> _obj = value;

                                           // print(value);

                                           // if(value != null){
                                           //
                                           //   if(_obj["action"] == "add"){
                                           //
                                           //     Navigator.of(context).push(PageRouteBuilder(
                                           //         opaque: false,
                                           //         pageBuilder: (BuildContext context, _, __) =>
                                           //             ProfileMyFriendWidget(
                                           //                 objInfo:_obj["myfriend"]
                                           //             )
                                           //     )
                                           //     );
                                           //
                                           //   }
                                           // }


                                          });
                                    },
                                    icon: new ImageIcon(
                                      AssetImage("assets/images/icons/icon-add-friends.png"),
                                      size: 20,
                                      color: Theme.of(context).primaryColor,
                                    ),
                                  ),
                                  IconButton(
                                    padding: EdgeInsets.only(left: 10,right: 5),
                                    onPressed:  ()  {
                                     // Navigator.of(context)
                                     //     .pushNamed('/setting_profile', arguments: 1);

                                     Navigator.of(context)
                                         .pushNamed('/setting_profile', arguments: 1);

                                    },
                                    icon: new ImageIcon(
                                      AssetImage("assets/images/icons/icon-setting.png"),
                                      size: 20,
                                      color: Theme.of(context).primaryColor,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
//                        height: 50,
                        width: double.infinity,
//                        margin: const EdgeInsets.only(bottom: 4),
                        child:  Stack(
                            children: <Widget>[
                              Align(
                                alignment: Alignment.topLeft,
                                child: Container(
                                  height: 50.0,
                                  width: 50.0,
                                ),
                              ),
                              Align(
                                alignment: Alignment.topCenter,
                                child: Container(
                                  height: 50,
                                  margin : const EdgeInsets.only(top: 0,left: 10, right: 10 , bottom: 8),
                                  padding : const EdgeInsets.only(top: 0,left: 0, right: 0 ,bottom: 0),
                                  child:  Row(children: <Widget>[
                                    Expanded(
                                      child: Container(
                                        height: 40,
                                        margin: EdgeInsets.only(left: 0, right: 0),
                                        width: MediaQuery.of(context).size.width,
                                        decoration: BoxDecoration(
                                          color: Theme.of(context)
                                              .primaryColor
                                              .withOpacity(0.98),
                                          borderRadius: BorderRadius.circular(15),
                                        ),
                                        child: InkWell(
                                          child: Row(
                                            children: <Widget>[
                                              SizedBox(
                                                width: 15,
                                              ),
                                              Icon(Icons.search,
                                                  size: 25, color: Colors.black26),
                                              Expanded(
                                                  child: Text(
                                                    "ค้นหา",
                                                    style: TextStyle(
                                                        color: Colors.black26,
                                                        fontSize: 14),
                                                  )
                                              ),
                                            ],
                                          ),
                                          onTap: (){
                                            Navigator.of(context)
                                                .pushNamed('/searchFriend', arguments: {"":""});
                                          },
                                        )
                                      ),
                                    ),
                                  ]
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.topRight,
                                child: Container(
                                  height: 50.0,
                                  width: 50.0,

                                ),
                              ),
                            ]),
                      ),
                    ])
            ),
          )
      ),
      backgroundColor: config.HexColor("#eeeeee"),
      body: SingleChildScrollView(
        // physics: BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(vertical: 0),
//            shrinkWrap: true,
        primary: false,
          child:  Wrap(
            children: <Widget>[

              Container(
                child: InkWell(
                  onTap: (){
                    Navigator.of(context).push(PageRouteBuilder(
                        opaque: false,
                        pageBuilder: (BuildContext context, _, __) =>
                            homeProfileWidget()
                    )
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: config.HexColor("#eeeeee"),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(0),
                          bottomLeft: Radius.circular(0)),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                    margin: const EdgeInsets.only(left: 0,top: 10,bottom: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Stack(
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
                          ],
                        ),
                        SizedBox(width: 10),
                        Flexible(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Expanded(
                                  child: Container(
                                    height: 50,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Expanded(
                                          child: Text(
                                            Member.myName == null ? "" : Member.myName,
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
                                        ),
                                        Expanded(
                                          child: Text(
                                            Member.StatusProfile == null ? "" : Member.StatusProfile.toString(),
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                            style: Theme.of(context).textTheme.caption.merge(
                                                TextStyle(
                                                  fontWeight: FontWeight.w400 ,
                                                  fontSize: 13,
                                                )),
                                          ),
                                        ),


                                      ],
                                    ),
                                  )
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(top: 10),
                width: double.infinity,
                height: 100,
                color: config.HexColor("#ffffff"),
                child: Container(
                  width: double.infinity,
                  child: Column(
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          padding : const EdgeInsets.only(left: 8,right: 8),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[

                              MenuHomeItemWidget(obj_arr: menuList[0]),
                              MenuHomeItemWidget(obj_arr: menuList[1]),
                              MenuHomeItemWidget(obj_arr: menuList[2]),
                              MenuHomeItemWidget(obj_arr: menuList[3]),
                              MenuHomeItemWidget(obj_arr: menuList[4]),

                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),

              ),
              favoriteList.length > 0 ? Container(
                padding: const EdgeInsets.only(top: 0,bottom: 5),
                width: double.infinity,
                height: 160,
                color: config.HexColor("#ffffff"),
                child: Container(
                  width: double.infinity,
                  child: Column(
                    children: <Widget>[
                      Container(
                        height: 50,
                        margin: const EdgeInsets.only(bottom: 0),
                        color: config.HexColor("#236A68"),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              margin: const EdgeInsets.only(left: 15,top: 0),
                              child: Text(
                                "Favorite Friends",
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white ,
                                    fontSize: 15),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(right: 15,top: 5),
                              child: new ImageIcon(
                                AssetImage("assets/images/icons/icon-drop-up.png"),
                                size: 20,
                                color: Theme.of(context).primaryColor,
                              ),
                            )
                          ],
                        ),
                      ),
                      Expanded(
                        child:  Container(
                          padding : const EdgeInsets.only(left: 8,right: 8),
                          child: favoriteList != null ? ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: favoriteList.length, itemBuilder: (context, index) {
                            var _arr = favoriteList[index];
                            return InkWell(
                                onTap: (){
//                            Navigator.of(context).push(PageRouteBuilder(
//                                opaque: false,
//                                pageBuilder: (BuildContext context, _, __) =>
//                                    ProfileMyFriendWidget()
//                             )
//                            );
                                },
                                child: FavoriteItemWidget(obj_arr: _arr)
                            );
                          }) : Container(
                            child: Center(
                              child: Text(
                                  'Loading...'
                              ),
                            ),
                          ),
                        ) ,
                      )
                    ],
                  ),
                ),

              ) : Container(height: 1,),
              Container(
                height: 50,
                margin: const EdgeInsets.only(top: 0),
                color: config.HexColor("#eeeeee"),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.only(left: 15,top: 0),
                        child: Text(
                          "Friends ( $_countFriend )",
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: config.HexColor("#236A68"),
                              fontSize: 15),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                color: Colors.white,
                margin: const EdgeInsets.only(left: 0,right: 0),
                child: _countFriend > 0 ? ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    primary: false,
                    scrollDirection: Axis.vertical,
                    itemCount: _countFriend, itemBuilder: (context, index) {
                  var _arr = friendsList[index];
                  var _info = friendsList[index]["friend_info"];
                  _info["FriendID"] = friendsList[index]["FriendID"];

                  // print(friendsList[index]);

                  return InkWell(
                    onTap: (){
                      Navigator.of(context).push(PageRouteBuilder(
                          opaque: false,
                          pageBuilder: (BuildContext context, _, __) =>
                              ProfileMyFriendWidget(
                                objInfo: _arr,
                              )
                      )).then((value)  {

                        //print(value);
                        //_scaffoldKey.currentState.widget;

                        if(value != null){

                          Map<String, dynamic> _arr = value;

                          if(_arr["action"] == "chat"){

                            var objInfoFriend;

                            var _arrinfo = _arr["_objRoom"];



                            // if(_arrinfo["RoomType"] == "Friend"){
                            //   _arrinfo["MemberInfo"].forEach((userDetail) {
                            //     if(userDetail["Uid"] != Member.myUid){
                            //       objInfoFriend = userDetail;
                            //     }
                            //   });
                            // }

                            // print(_arrinfo);

                            //
                            // Navigator.of(context)
                            //     .push(MaterialPageRoute(builder: (context) => RoomChatWidget(
                            //     objRoom: _arrinfo,
                            //     infoFriend : objInfoFriend
                            // )));

                          }

                          if(_arr["favoriteRe"] == true){
                            favoriteList = [];
                            _friend.getFavoriteList().then((result) {
                              setState(() {
                                favoriteList = result;
                              });
                            });
                          }


                        }



//                         Navigator.push(
//                             context, CupertinoPageRoute(
//                               builder: (context) => ChatWidget(),
//                             ));

//                        setState(() {
//                          TabsWidget(
//                            currentTab: 0,
//                          );
//                        });

                      });
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      child: Container(
                        color: config.HexColor("#ffffff"),
                        margin: const EdgeInsets.only(bottom: 0,right: 8,left: 8),
                        child: FriendItemWidget(obj_arr: _info),
                      ),
                    ),
                  );
                }) : Container(
                  height: 400,
                  child: Center(
                    child: Text(
                        "ไม่มีรายการ",
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                          color: Colors.black12
                      ),
                    ),
                  ),
                ),

              ),

            ],
          ),
      ),

    );
  }

}

// ignore: must_be_immutable

class MenuTabContent {
  IconData icon;
  String tooTip;
  MenuTabContent.name(this.tooTip);
}

