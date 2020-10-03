
import 'package:chatty/main/_home.dart';
import 'package:chatty/model/friend.dart';
import 'package:chatty/model/member.dart';
import 'package:flutter/material.dart';
import '../../config/app_config.dart' as config;
import '../_group.dart';
import '../_officials.dart';


class MyOfficialsWidget extends StatefulWidget {
  @override
  _myOfficialsState createState() => _myOfficialsState();
}

class _myOfficialsState extends State<MyOfficialsWidget> {



  List<Map<String, dynamic>> groupList = [];

  @override
  void initState() {
    super.initState();



    groupList.add({
      "img":"assets/images/official/1@2x.png",
      "name": "Lee"
    });
    groupList.add({
      "img":"assets/images/official/2@2x.png",
      "name": "Krungsri Simple"
    });
    groupList.add({
      "img":"assets/images/official/3@2x.png",
      "name": "Major cineplex"
    });
    groupList.add({
      "img":"assets/images/official/4@2x.png",
      "name": "Under Armour Running TH"
    });
    groupList.add({
      "img":"assets/images/official/5@2x.png",
      "name": "Uniqlo Thailand"
    });
    groupList.add({
      "img":"assets/images/official/6@2x.png",
      "name": "Netflix Thailand"
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
                                      "Officials",
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

                                                ImageIcon(
                                                  AssetImage(
                                                      "assets/images/demo/blog-thumb.jpg"),
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
                            "Officials",
                            style: TextStyle(
                                color: Colors.black45,
                                fontSize: 17),
                          )
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
                    return InkWell(
                      onTap: (){
//                        Navigator.of(context).push(PageRouteBuilder(
//                            opaque: false,
//                            pageBuilder: (BuildContext context, _, __) =>
//                                ProfileMyFriendWidget()
//                        )
//                        );
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        child: Container(
                          color: config.HexColor("#ffffff"),
                          margin: const EdgeInsets.only(bottom: 0,right: 8,left: 8),
                          child: OfficialsItemWidget(obj_arr: _arr),
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

                Container(
                  margin: const EdgeInsets.only(top: 20,left: 20,right: 20,bottom: 20),
                  height: 120,
                  decoration: BoxDecoration(
                    color: Theme.of(context)
                        .primaryColor
                        .withOpacity(0.98),
                    borderRadius: BorderRadius.circular(15),
                    image: new DecorationImage(
                      image: new AssetImage("assets/images/demo/demo-bg.png"),
                      fit: BoxFit.cover,
                    ),
                  ),
//                  child: Image.asset(
//                      "assets/images/demo/marketing.png",
//                      scale: 0.4
//                  ),
                ),

              ],
            )
        )
    );
  }

}