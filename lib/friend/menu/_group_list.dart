
import 'package:chatty/main/_home.dart';
import 'package:chatty/model/friend.dart';
import 'package:chatty/model/member.dart';
import 'package:flutter/material.dart';
import '../../config/app_config.dart' as config;
import '../_group.dart';
import '../_profile_mygroup.dart';


class MyGroupFriendWidget extends StatefulWidget {
  @override
  _myGroupFriendState createState() => _myGroupFriendState();
}

class _myGroupFriendState extends State<MyGroupFriendWidget> {

  Member _member = new Member.init();
  Friend _friend = new Friend.init();

  List<Map<String, dynamic>> groupList = [];

  @override
  void initState() {
    super.initState();


    _friend.getGroupList().then((result) {
      setState(() {
        groupList = result;
      });
    });

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
                                      "กลุ่ม",
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
                            "Group",
                            style: TextStyle(
                                color: Colors.black45,
                                fontSize: 17),
                          )
                      ),


                      InkWell(
                          child: Container(
                              width: 100,
                              height: 40,
                              child: Text("สร้างกลุ่ม",
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
                            Navigator.of(context).pushNamed('/add_group', arguments: 1).then((value) {

                              if(value != null){

                                 groupList = [];
                                _friend.getGroupList().then((result) {
                                  setState(() {
                                    groupList = result;
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
                            "Group (${groupList.length})",
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
                  child: groupList != null ? ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      primary: false,
                      scrollDirection: Axis.vertical,
                      itemCount: groupList.length, itemBuilder: (context, index) {
                    var _arr = groupList[index];

                    // print(_arr);

                    // print(_arr);

                    return InkWell(
                      onTap: (){

                       Navigator.of(context).push(PageRouteBuilder(
                           opaque: false,
                           pageBuilder: (BuildContext context, _, __) =>
                               ProfileMyGroupWidget(
                                   objInfo : _arr
                               ),
                         )
                       );

                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        child: Container(
                          color: config.HexColor("#ffffff"),
                          margin: const EdgeInsets.only(bottom: 0,right: 8,left: 8),
                          child: GroupItemWidget(obj_arr: _arr["Info"]),
                          // child: Text("Test"),
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