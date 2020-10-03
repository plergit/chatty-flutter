import 'package:chatty/shared/widgets/mycircleavatar.dart';
import 'package:flutter/material.dart';
import 'package:chatty/model/friend.dart';
import 'package:chatty/model/member.dart';
import '../config/app_config.dart' as config;
import '_profile_myfriend.dart';

class FriendListSelectWidget extends StatefulWidget {

  List<Map<String, dynamic>> friends_list;

  FriendListSelectWidget({this.friends_list});

  @override
  _myFriendState createState() => _myFriendState();
}

class _myFriendState extends State<FriendListSelectWidget> {

  Friend _friend = new Friend.init();
  List<Map<String, dynamic>> _select_friend = [];
  List<Map<String, dynamic>> friendsList = [];

  @override
  void initState() {
    super.initState();

    _friend.getFriendsList().then((result) {

      for (var _arr in result) {

        var _re = _recheck_select_friend(widget.friends_list ,_arr["Uid"]);

        if(_re == true){
          _arr["select"] = true;
          _select_friend.add(_arr);
        }

      }

      setState(() {
        friendsList = result;
      });

    });


  }


  @override
  void dispose() {
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {

    _select_friend = [];

    var _count_friend = friendsList.length;
    for (var _arr in friendsList) {
      if(_arr["select"] == true){
        _select_friend.add(_arr);
      }
    }

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
                                      "ผู้ติดต่อ",
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
                                            context, {"action": "close"}
                                          ),
                                    },
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.centerRight,
                              ),
                            ]),
                          ),
                          Row(
                              children: <Widget>[
//                      SizedBox(width: 16),
                                Expanded(
                                  child: Container(
                                    height: 48,
                                    margin : const EdgeInsets.only(top: 0,left: 10, right: 10 , bottom: 5),
                                    padding : const EdgeInsets.only(top: 0,left: 0, right: 0 ,bottom: 0),
                                    child:  Row(children: <Widget>[
                                      Expanded(
                                        child: InkWell(
                                          onTap: () {
                                            Navigator.of(context)
                                                .pushNamed('/Search', arguments: 1);
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
                                                  width: 10,
                                                ),
                                                Icon(Icons.search,
                                                    size: 30, color: Colors.black26),
                                                Expanded(
                                                    child: Container(
                                                      height: 50,
                                                      // color: Colors.red,
                                                      child: TextField(
                                                        decoration: InputDecoration(
                                                          hintText: "Search...",
                                                          hintStyle: TextStyle(
                                                              color: Colors.grey.withOpacity(0.5),
                                                          ),
                                                          border: InputBorder.none,
                                                        ),

                                                      ),

                                                    )

                                                ),
                                                ImageIcon(
                                                  AssetImage(
                                                      "assets/images/icons/search-by-qr-code.png"
                                                  ),
                                                  size: 20,
                                                  color: Colors.black45,
                                                ),
                                                SizedBox(
                                                  width: 15,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),

                                    ]
                                    ),
                                  ),
                                ),
                              ]
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

                      InkWell(
                          child: Container(
                              constraints: BoxConstraints.expand(
                                  height: 30,
                                  width: 70
                              ),
                              child: Text("เลือก (${_select_friend.length})",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                  )
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10), color: config.HexColor("#79B5B4"),
                              ),
                              margin: EdgeInsets.only(right: 10),
                              padding: EdgeInsets.all(5)),
                          onTap: () {

                            if(_select_friend.length > 0){
                              Navigator.pop(
                                  context, {"action": "select","_arrselect" : _select_friend }
                              );
                            }

                          }
                      ),
                      // InkWell(
                      //   onTap: (){
                      //
                      //       if(_select_friend.length > 0){
                      //         Navigator.pop(
                      //             context, {"action": "select","_arrselect" : _select_friend }
                      //         );
                      //       }
                      //
                      //     },
                      //   child: Container(
                      //     margin: const EdgeInsets.only(right: 10),
                      //     child: Text(
                      //         "เลือก (${_select_friend.length})"
                      //     ),
                      //   ),
                      // )



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
                    var _arrInfo = friendsList[index]["friend_info"];
                    var _arr = friendsList[index];

                    return InkWell(
                      onTap: (){

                        // Navigator.of(context).push(PageRouteBuilder(
                        //     opaque: false,
                        //     pageBuilder: (BuildContext context, _, __) =>
                        //         ProfileMyFriendWidget(
                        //           objInfo: _arr,
                        //         )
                        // ));

                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        child: Container(
                          color: config.HexColor("#ffffff"),
                          margin: const EdgeInsets.only(bottom: 0,right: 8,left: 8),
                          child: Container(

                            decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor.withOpacity(1.0),
                              border: Border(
                                bottom: BorderSide(
                                  color: Colors.black26,
                                  width: 0.4,
                                ),
                              ),
                            ),
                            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    SizedBox(
                                      width: 30,
                                      child: Checkbox(
                                        value: _arr["select"],
                                        onChanged: (bool value) {

                                          setState(() {
                                            _arr["select"] = value;
                                          });

                                        },
                                      ),
                                    ),
                                    SizedBox(
                                      width: 50,
                                      height: 50,
                                      child: MyCircleAvatar(
                                        imgUrl: _arrInfo["ImgUrl"],
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
                                              child: Align(
                                                child: Text(
                                                  _arrInfo["FullName"],
                                                  overflow: TextOverflow.fade,
                                                  softWrap: false,
                                                  maxLines: 1,
                                                  style: Theme.of(context).textTheme.body2.merge(
                                                      TextStyle(
                                                          fontWeight: FontWeight.w400,
                                                          fontSize: 16,
                                                          color: Colors.black87
                                                      )
                                                  ),
                                                ),
                                                alignment: Alignment.centerLeft,
                                              )
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

  bool _recheck_select_friend(List<Map<String,dynamic>> _list ,String _key){

    for (var _arr in _list) {
      if(_key == _arr["Uid"]){
        // _objNew.add(_arr);
        return true;
      }
    }
   return false;
  }


}


