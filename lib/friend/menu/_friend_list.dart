
import 'package:chatty/main/_home.dart';
import 'package:chatty/model/friend.dart';
import 'package:chatty/model/member.dart';
import 'package:flutter/material.dart';

import '../../config/app_config.dart' as config;
import '../_favorite.dart';
import '../_friend.dart';
import '../_profile_myfriend.dart';


class MyFriendWidget extends StatefulWidget {
  @override
  _myFriendState createState() => _myFriendState();
}

class _myFriendState extends State<MyFriendWidget> {

  Member _member = new Member.init();
  Friend _friend = new Friend.init();

  List<Map<String, dynamic>> friendsList = [];
  List<Map<String, dynamic>> favoriteList = [];

  @override
  void initState() {
    super.initState();

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

  }


  @override
  void dispose() {
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {


    var _count_friend = friendsList.length;

    return GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: Scaffold(
            appBar: PreferredSize(
                preferredSize: Size.fromHeight(100.0),
                child: AppBar(
                  elevation: 0,
                  backgroundColor: Theme
                      .of(context)
                      .accentColor,
                  automaticallyImplyLeading: false, // hides leading widget
                  flexibleSpace: Container(
                      padding: EdgeInsets.only(
                          left: 0,
                          right: 0,
                          top: MediaQuery
                              .of(context)
                              .padding
                              .top,
                          bottom: 0),
                      width: MediaQuery
                          .of(context)
                          .size
                          .width,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            height: 45,
                            width: double.infinity,
                            child: Stack(children: <Widget>[
                              Align(
                                alignment: Alignment.center,
                                child: Container(
                                    margin: EdgeInsets.only(left: 0, right: 0),
                                    child: Text(
                                      "Friend",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.w600,
                                          color: Theme
                                              .of(context)
                                              .primaryColor),
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
                                      color: Theme
                                          .of(context)
                                          .primaryColor,
                                    ),
                                    onPressed: () =>
                                    {
                                      Navigator.pop(
                                          context, {"action": "close"}),
                                    },
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.centerRight,
                              ),
                            ]),
                          ),
                          Container(
                            height: 48,
                            margin : const EdgeInsets.only(top: 0,left: 10, right: 10 , bottom: 5),
                            padding : const EdgeInsets.only(top: 0,left: 0, right: 0 ,bottom: 0),
                            child:  Row(children: <Widget>[
                              Expanded(
                                child: InkWell(
                                  onTap: () {
                                    Navigator.of(context)
                                        .pushNamed('/searchFriend', arguments: {"":""});
                                  },
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
                                    child: Row(
                                      children: <Widget>[
                                        SizedBox(
                                          width: 15,
                                        ),
                                        Icon(Icons.search,
                                            size: 30, color: Colors.black26),
                                        Expanded(
                                            child: Text(
                                              "Search",
                                              style: TextStyle(
                                                  color: Colors.black26,
                                                  fontSize: 14),
                                            )
                                        ),


                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ]
                            ),
                          ),
                        ],
                      )),
                )
            ),
            body: ListView(
              physics: BouncingScrollPhysics(),
              children: <Widget>[

                Container(
                  height: 50,
                  margin: EdgeInsets.only(left: 0, right: 0),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Theme.of(context)
                        .primaryColor
                        .withOpacity(0.0),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Row(
                    children: <Widget>[
                      SizedBox(
                        width: 15,
                      ),
                      Expanded(
                          child: Text(
                            "MY Friends",
                            style: TextStyle(
                                color: Colors.black45,
                                fontSize: 17),
                          )
                      ),


                      InkWell(
                          child: Container(
                              width: 100,
                              height: 40,
                              child: Text("เพิ่มเพื่อน",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 15, color: Colors.white)),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                color: config.HexColor("#78B5B4"),
                              ),
                              margin: EdgeInsets.only(top: 0),
                              padding: EdgeInsets.all(10)
                          ),
                          onTap: () {
                            Navigator.of(context)
                                .pushNamed('/add_friend', arguments: 1).then((value) {

                                  if(value != null){
                                    friendsList = [];
                                    _friend.getFriendsList().then((result) {
                                      setState(() {
                                        friendsList = result;
                                      });
                                    });
                                  }

                            });
                          }),
                      SizedBox(
                        width: 10,
                      ),
                    ],
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
//                            )
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
                            "Friends ($_count_friend)",
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
                  child: friendsList != null ? ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      primary: false,
                      scrollDirection: Axis.vertical,
                      itemCount: _count_friend , itemBuilder: (context, index) {
                    var _arr = friendsList[index];
                    var _arr_info = friendsList[index]["friend_info"];

                    return InkWell(
                      onTap: (){

                        Navigator.of(context).push(PageRouteBuilder(
                            opaque: false,
                            pageBuilder: (BuildContext context, _, __) =>
                                ProfileMyFriendWidget(
                                  objInfo: _arr,
                                )
                        ));

                        // Navigator.of(context).push(PageRouteBuilder(
                        //     opaque: false,
                        //     pageBuilder: (BuildContext context, _, __) =>
                        //         ProfileMyFriendWidget())
                        // );

                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        child: Container(
                          color: config.HexColor("#ffffff"),
                          margin: const EdgeInsets.only(bottom: 0,right: 8,left: 8),
                          child: FriendItemWidget(obj_arr: _arr_info),
                        ),
                      ),
                    );
                  }) : Container(
                    height: 200,
                    child: Center(
                      child: Text(
                          'Loading...'
                      ),
                    ),
                  ),

                ),

              ],
            )
        )
    );
  }

}