import 'dart:io';
import 'package:chatty/friend/_friend.dart';
import 'package:chatty/services/_connect.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:qr_mobile_vision/qr_camera.dart';
import '../config/app_config.dart' as config;

class searchFriendWidget extends StatefulWidget {

  Map<String , dynamic> Obj;
  searchFriendWidget({this.Obj});

  @override
  _WidgetsearchFriendState createState() => new _WidgetsearchFriendState();
}

class _WidgetsearchFriendState extends State<searchFriendWidget> {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  String _queryText = "";

  @override
  void initState() {

    super.initState();
  }

  TextEditingController search_txt = TextEditingController();

  @override
  Widget build(BuildContext context) {

    // print(_queryText);

    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

      return new GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(new FocusNode());
          },
          child: Scaffold(
          appBar: PreferredSize(
              preferredSize: Size.fromHeight(55.0),
              child: AppBar(
                elevation: 0,
                backgroundColor: Colors.white,
                automaticallyImplyLeading: false, // hides leading widget
                flexibleSpace: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border(
                        bottom: BorderSide(
                          color: Colors.black12,
                          width: 0.5,
                        ),
                      ),
                    ),
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
                                  margin : EdgeInsets.only(left: 20,right: 0),
                                  child: Container(
                                    // height: 48,
                                    margin : const EdgeInsets.only(top: 0,left: 10, right: 10 , bottom: 5),
                                    padding : const EdgeInsets.only(top: 0,left: 0, right: 0 ,bottom: 0),
                                    child:  Row(children: <Widget>[
                                      Expanded(

                                          child: Container(
                                            height: 50,
                                            margin: EdgeInsets.only(top: 4,left: 0, right: 0),
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
                                                    size: 25, color:
                                                    Colors.black26,
                                                ),
                                                Expanded(
                                                    child: Container(
                                                      height: 50,
                                                      margin: EdgeInsets.only(top: 0, right: 0),
                                                      // color: Colors.red,
                                                      child: TextField(
                                                        controller: search_txt,
                                                        decoration: InputDecoration(
                                                          hintText: "Search...",
                                                          hintStyle: TextStyle(
                                                            color: Colors.grey.withOpacity(0.5),
                                                          ),
                                                          border: InputBorder.none,
                                                        ),
                                                        onChanged: (val) {
                                                          setState(() {
                                                            _queryText = val;
                                                          });
                                                        },
                                                      ),

                                                    )

                                                ),

                                                Container(
                                                  height: 50.0,
                                                  // width: 50.0,
                                                  child: IconButton(
                                                    alignment: Alignment.center,
                                                    icon: new ImageIcon(
                                                      AssetImage(
                                                          "assets/images/icons/search-by-qr-code.png"),
                                                      size: 20,
                                                      color: Colors.black38,
                                                    ),
                                                    onPressed: () {

                                                    Navigator.of(context).push(PageRouteBuilder(
                                                    opaque: false,
                                                    pageBuilder: (BuildContext context, _, __) =>
                                                    QrSearchFriendWidget()
                                                    ));

                                                    },
                                                  ),
                                                ),

                                                // SizedBox(
                                                //   width: 15,
                                                // ),
                                              ],
                                            ),
                                          ),

                                      ),

                                    ]
                                    ),
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
                                        "assets/images/icons/icon-back.png"
                                    ),
                                    size: 18,
                                    color: Colors.black38,
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
          body: new GestureDetector(
              onTap: () {
                FocusScope.of(context).requestFocus(new FocusNode());
              },

              child: _queryText != "" ? Container(
                  height: height,
                  color: Colors.white,
                  child: StreamBuilder<QuerySnapshot>(
              stream: firebaseCon.firestore_
                  .collection('Members')
                  // .where("FullName", arrayContains : [_queryText])
                  .where('FullName', isGreaterThanOrEqualTo: _queryText)
                  .where('FullName', isLessThan: _queryText +'z')
                  .snapshots(),
              builder: (context, snapshot) {

                  // print(snapshot.connectionState);

                  if(snapshot.connectionState == ConnectionState.active && snapshot.data.docs.length == 0){
                    return Center(
                      child: SizedBox(
                          width: 100,
                          height: 100,
                          child:  Image(
                            image: new AssetImage("assets/images/icons/icon-search-not.png"),
                          )
                      ),
                    );
                  }
                  else{
                    return (snapshot.connectionState == ConnectionState.waiting)
                        ? Center(
                        child: CircularProgressIndicator()
                    )
                        : ListView.builder(
                      itemCount: snapshot.data.docs.length,
                      itemBuilder: (context, index) {
                        DocumentSnapshot data = snapshot.data.docs[index];
                        return InkWell(
                          child: FriendItemWidget(obj_arr: data.data()),
                          onTap: (){

                          },
                        );
                      },
                    );
                  }


            },
          ),

              ) : Center(
                child: SizedBox(
                    width: 100,
                    height: 100,
                    child:  Image(
                      image: new AssetImage("assets/images/icons/icon-search-not.png"),
                    )
                ),
              ),
          )
      )
      );
  }



}






class QrSearchFriendWidget extends StatefulWidget {

  Map<String , dynamic> Obj;
  QrSearchFriendWidget({this.Obj});

  @override
  _WidgetQrState createState() => new _WidgetQrState();
}

class _WidgetQrState extends State<QrSearchFriendWidget> {


  String _qrInfo = 'Scan QR';
  bool _camState = true;
  bool _viewQr = false;

  @override
  void initState() {

    // _camState == true;

    super.initState();
  }



  _qrCallback(String code) {
    setState(() {
      _camState = false;
      _qrInfo = code;
    });
    Navigator.pop(context, {"action": "scan","_qrcode":code});
  }

  @override
  Widget build(BuildContext context) {

    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return Scaffold(
        body: Container(
      // height: 400,
      // width: 500,
        child: Column(
          children: [

            Expanded(
              child: Container(
                child: _camState == true ? new QrCamera(
                  onError: (context, error) => Text(
                    error.toString(),
                    style: TextStyle(color: Colors.red),
                  ),
                  qrCodeCallback: (code) {
                    _qrCallback(code);
                  },
                  child: new Container(
                    alignment: Alignment.center,
                    child: Stack(
                      // crossAxisAlignment: CrossAxisAlignment.center,
                      // mainAxisAlignment: MainAxisAlignment.center,
                      children: [

                        Container(
                          width: width,
                          height: (height - (140)),
                          decoration: new BoxDecoration(
                            color: Colors.black.withOpacity(0.0),
                            border: Border(
                              top: BorderSide(
                                color: Colors.black.withOpacity(0.5),
                                width: 100.5,
                              ),
                              bottom: BorderSide(
                                color: Colors.black.withOpacity(0.5),
                                width: 100.5,
                              ),
                              left: BorderSide(
                                color: Colors.black.withOpacity(0.5),
                                width: 50.5,
                              ),
                              right: BorderSide(
                                color: Colors.black.withOpacity(0.5),
                                width: 50.5,
                              ),
                            ),
                            // border: Border.all(
                            //     color: Colors.black.withOpacity(0.5),
                            //     width: 50,
                            //     style: BorderStyle.solid
                            // ),
                          ),
                        ),

                        Positioned(
                            top: 30,
                            right: 0,
                            child: Container(
                                width: width,
                                height: 50,
                                alignment: Alignment.centerRight,
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
                                      color: Colors.white,
                                    ),
                                    onPressed: () => {
                                      Navigator.pop(context, {"action": "close"}),
                                    },
                                  ),
                                ),

                            )

                        )

                      ],
                    ),
                    decoration: new BoxDecoration(
                      color: Colors.black.withOpacity(0.0),
                      border: Border.all(
                          color: Colors.grey, width: 0.0,
                          style: BorderStyle.solid
                      ),
                    ),
                  ),
                ) : Container(),
              ),
            ),



            Container(
              height: 180,
              padding: const EdgeInsets.only(left: 30,right: 30),
              alignment: Alignment.center,
              child: Text(
                "คุณสามารถแสกนคิวอาร์โค้ดเพื่อเข้าถึงบริการต่างๆ เช่น การเพิ่มเพื่อน",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15.0,
                  fontWeight: FontWeight.w500,
                  color: Theme.of(context).accentColor,
                ),
              ),

            )


          ],
        )
    )
    );

  }






}


