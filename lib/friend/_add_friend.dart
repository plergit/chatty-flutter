import 'package:barcode_scan/barcode_scan.dart';
import 'package:chatty/model/member.dart';
import 'package:chatty/services/_friend.dart';
import 'package:chatty/shared/ModalBottomSheet.dart';
import 'package:chatty/shared/widgets/mycircleavatar.dart';
import 'package:chatty/shared/widgets/popupLoading.dart';
import 'package:country_list_pick/country_list_pick.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:flutter_qr_bar_scanner/flutter_qr_bar_scanner.dart';
// import 'package:flutter_qr_bar_scanner/qr_bar_scanner_camera.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:qr_mobile_vision/qr_camera.dart';

import '../config/app_config.dart' as config;

class AddFriendWidget extends StatefulWidget {
  @override
  _AddFriendState createState() => _AddFriendState();
}

class _AddFriendState extends State<AddFriendWidget> {

  String _dialCode = "+66";
  TextEditingController q_friend_phone = TextEditingController();
  TextEditingController q_friend_id = TextEditingController();

  String _qrInfo = 'Scan QR';
  bool _camState = false;
  bool _viewQr = false;

  _qrCallback(String code) {
    setState(() {
      _camState = false;
      _qrInfo = code;
      _search_my_friend_by_qr();
    });
  }

  Map<String , dynamic> _objFriend ;

  @override
  void initState() {

    super.initState();

  }


  @override
  void dispose() {
    super.dispose();
  }

  var _select = 1;

  @override
  Widget build(BuildContext context) {

    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

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
                              alignment: Alignment.center,
                              child: Container(
                                  margin : EdgeInsets.only(left: 0,right: 0),
                                  child: Text(
                                    "Add Friend",
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
          body: Column(
            children: <Widget>[

              Container(
                  color: Theme.of(context).primaryColor,
                  width: double.infinity,
                  padding: const EdgeInsets.only(left: 15,right: 15 ,top: 0, bottom: 0),
                  height: 60,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      InkWell(
                        child: Container(
                          height: 50,
                          width: 100,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border(
                              bottom: BorderSide(
                                color: _select == 1 ? Theme.of(context).accentColor : Theme.of(context).primaryColor,
                                width: 2,
                              ),
                            ),
                          ),
                          child: Center(
                            child: Text(
                                "Number",
                              style: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w600,
                                  color: _select == 1 ? Colors.black : Colors.black38
                              ),

                            ),
                          ),
                        ),
                        onTap: (){

                        setState(() {
                          _select = 1;
                          _camState = false;
                        });

                        },
                      ),
                      InkWell(
                        child: Container(
                          height: 50,
                          width: 100,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border(
                              bottom: BorderSide(
                                color: _select == 2 ? Theme.of(context).accentColor : Theme.of(context).primaryColor,
                                width: 2,
                              ),
                            ),
                          ),
                          child: Center(
                            child: Text(
                                "ID",
                                style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.w600,
                                color: _select == 2 ? Colors.black : Colors.black38
                            ),
                            ),
                          ),
                        ),
                        onTap: (){

                          setState(() {
                            _select = 2;
                            _camState = false;
                          });

                        },
                      ),
                      InkWell(
                        child: Container(
                          height: 50,
                          width: 100,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border(
                              bottom: BorderSide(
                                color: _select == 3 ? Theme.of(context).accentColor : Theme.of(context).primaryColor,
                                width: 2,
                              ),
                            ),
                          ),
                          child: Center(
                            child: Text(
                                "QR",
                                style: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w600,
                                  color: _select == 3 ? Colors.black : Colors.black38
                              ),
                            ),
                          ),
                        ),
                        onTap: (){

                          setState(() {
                            _select = 3;
                            _camState = true;
                            _viewQr = false;
                          });


                          // qr_scan();

                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(builder: (context) => ScanScreen()),
                          // );


                        },
                      )
                    ],
                  )

              ),


              _select == 1 ? buildFormSearchNumber() : _select == 2 ? buildFormSearchId() :
              Expanded(
                child: Container(
                  child: Wrap(
                    children: [

                      _camState
                          ?  Container(
                        // height: 400,
                        // width: 500,
                        child: Stack(
                          children: [

                            Container(
                              width: width,
                              height: (height - (140)),

                              child: new QrCamera(
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
                                    bottom: 50,
                                    right: 0,
                                    left: 0,
                                    child: Container(
                                      width: width,
                                      height: 50,
                                      alignment: Alignment.bottomCenter,
                                      child: InkWell(
                                        onTap: (){

                                          setState(() {
                                            _camState = false;
                                            _viewQr = true;
                                          });

                                        },
                                        child: Text(
                                          "คิวอาร์โค้ด ของฉัน",
                                          style: TextStyle(
                                              fontSize: 17.0,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.white
                                          ),
                                        ),
                                      )

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
                              ),
                            ),




                        // Container(
                        //   width: width,
                        //   height: (height - (140)),
                        //   alignment: Alignment.center,
                        //
                        //   child: Text("ffff"),
                        //
                        // )


                          ],
                        )
                          )
                          : Center(

                        child: Container(
                            // height: 400,
                            child: Center(
                              child: _viewQr == false ?
                              _view_friend()
                               :
                              Container(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      QrImage(
                                        data: Member.myUid.toString(),
                                        version: QrVersions.auto,
                                        size: 300,
                                        gapless: false,
                                        embeddedImage: AssetImage("assets/images/logo/ic_launcher_round.png"),
                                        embeddedImageStyle: QrEmbeddedImageStyle(
                                          size: Size(50, 50),
                                        ),
                                      ),
                                      Container(
                                          width: width,
                                          height: 50,
                                          alignment: Alignment.bottomCenter,
                                          child: InkWell(
                                            onTap: (){

                                              setState(() {
                                                _camState = true;
                                                _viewQr = false;
                                              });

                                            },
                                            child: Text(
                                              "แสกน คิวอาร์โค้ด",
                                              style: TextStyle(
                                                  fontSize: 17.0,
                                                  fontWeight: FontWeight.w500,
                                                  color: Theme.of(context).accentColor,
                                              ),
                                            ),
                                          )

                                      )
                                    ],
                                  )
                              ),
                              // Text(_qrInfo),

                            ),
                        )

                      ),

                    ],
                  )

                ),
              ),
              _select <= 2 ? Expanded(
                child: Center(
                  child: _view_friend(),
                ),
              ) : Center(

              ),
            ],
          ),

        ));
  }



  String barcode = "";

  Future qr_scan() async {
    try {
      // String barcode = await BarcodeScanner.scan();
      var result = await BarcodeScanner.scan();

      print(result.type); // The result type (barcode, cancelled, failed)
      print(result.rawContent); // The barcode content
      print(result.format); // The barcode format (as enum)
      print(result.formatNote); // If

    } on PlatformException catch (e) {
      if (e.code == BarcodeScanner.cameraAccessDenied) {
        setState(() {
          this.barcode = 'The user did not grant the camera permission!';
        });
      } else {
        setState(() => this.barcode = 'Unknown error: $e');
      }
    } on FormatException{
      setState(() => this.barcode = 'null (User returned using the "back"-button before scanning anything. Result)');
    } catch (e) {
      setState(() => this.barcode = 'Unknown error: $e');
    }
  }


  // var _view_qr = Container(
  //   child: Wrap(
  //     children: [
  //       QrImage(
  //         data: Member.myUid.toString(),
  //         version: QrVersions.auto,
  //         size: 300,
  //         gapless: false,
  //         embeddedImage: AssetImage("assets/images/logo/ic_launcher_round.png"),
  //         embeddedImageStyle: QrEmbeddedImageStyle(
  //           size: Size(50, 50),
  //         ),
  //       ),
  //       Container(
  //           width: width,
  //           height: 50,
  //           alignment: Alignment.bottomCenter,
  //           child: InkWell(
  //             onTap: (){
  //
  //               setState(() {
  //                 _camState = true;
  //                 _viewQr = false;
  //               });
  //
  //             },
  //             child: Text(
  //               "QRCode ของฉัน",
  //               style: TextStyle(
  //                   fontSize: 17.0,
  //                   fontWeight: FontWeight.w500,
  //                   color: Colors.white
  //               ),
  //             ),
  //           )
  //
  //       )
  //     ],
  //   )
  // );


  Container buildFormSearchNumber() {
    return Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
            color: config.HexColor("#F5F6F7"),
//            F5F6F7
            borderRadius: BorderRadius.circular(0)
        ),
        child: Column(
          children: [

            Container(
              height: 50,
              margin : const EdgeInsets.only(top: 0,left: 10, right: 10 , bottom: 8),
              padding : const EdgeInsets.only(top: 0,left: 0, right: 0 ,bottom: 0),
              child:  Row(children: <Widget>[
                Expanded(
                  child: Container(
                    height: 45,
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

                        Expanded(
                            child: Container(

                              alignment: Alignment.centerLeft,
                              child: CountryListPick(

                                initialSelection: _dialCode,
                                onChanged: (CountryCode code) {
                                  _dialCode = code.code;
                                },
                              ),
                            ),
                        ),

                      ],
                    ),
                  ),
                ),
              ]
              ),
            ),
            Container(
              height: 50,
              margin : const EdgeInsets.only(top: 0,left: 10, right: 10 , bottom: 0),
              padding : const EdgeInsets.only(top: 0,left: 0, right: 0 ,bottom: 0),
              child:  Row(children: <Widget>[
                Expanded(
                  child: Container(
                    height: 45,
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
                        Expanded(
                            child: Container(
                              child: TextField(
                                keyboardType: TextInputType.phone,
                                style: TextStyle(
                                    color: Theme.of(context).hintColor,
                                    fontSize: 16
                                ),
                                controller: q_friend_phone,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: '00-000-0000',
                                  hintStyle: TextStyle(
                                      color: Colors.black54,
                                      fontSize: 16
                                  ),
                                ),

                              ),
                            ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            border: Border(
                              left: BorderSide(
                                color: Colors.black26,
                                width: 0.5,
                              ),
                            ),
                          ),
                        ),
                        InkWell(
                          child: Container(
                            margin : const EdgeInsets.only(top: 0,left: 15, right: 15 , bottom: 0),
                            child: Icon(
                                Icons.search,
                                size: 25, color: Colors.black45
                            ),
                          ),
                          onTap: (){

                            _search_my_friend_by_phone();

                          },
                        )
                      ],
                    ),
                  ),
                ),
              ]
              ),
            ),
          ],
        )
    );

  }

  Container buildFormSearchId() {
    return Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
            color: config.HexColor("#F5F6F7"),
//            F5F6F7
            borderRadius: BorderRadius.circular(0)
        ),
        child: Column(
          children: [
            Container(
              height: 50,
              margin : const EdgeInsets.only(top: 0,left: 10, right: 10 , bottom: 0),
              padding : const EdgeInsets.only(top: 0,left: 0, right: 0 ,bottom: 0),
              child:  Row(children: <Widget>[
                Expanded(
                  child: Container(
                    height: 45,
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
                        Expanded(
                            child: TextField(
                              keyboardType: TextInputType.text,
                              style: TextStyle(
                                  color: Theme.of(context).hintColor,
                                  fontSize: 16
                              ),
                              controller: q_friend_id,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'ค้นหา ID',
                                hintStyle: TextStyle(
                                    color: Colors.black54,
                                    fontSize: 16
                                ),
                              ),

                            ),
                        ),

                        Container(
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            border: Border(
                              left: BorderSide(
                                color: Colors.black26,
                                width: 0.5,
                              ),
                            ),
                          ),
                        ),

                        InkWell(
                          child: Container(
                            margin : const EdgeInsets.only(top: 0,left: 15, right: 15 , bottom: 0),
                            child: Icon(
                                Icons.search,
                                size: 25, color: Colors.black45
                            ),
                          ),
                          onTap: (){

                            _search_my_friend_by_id();

                          },
                        ),
                        SizedBox(
                          width: 0,
                        ),
                      ],
                    ),
                  ),
                ),
              ]
              ),
            ),
          ],
        )
    );

  }

  _search_my_friend_by_phone() async {

    FocusScope.of(context).requestFocus(new FocusNode());
    var _q = q_friend_phone.text;

    Map<String ,dynamic> _q_obj = {"number":_q,"country":_dialCode};

    var _e = await FriendService.search_friend("phon",_q_obj);

    if(_e != null){
      _e["isSearch"] = true;
      setState(() {
        _objFriend = _e;
      });
    }
    else{
      var  _v = {"isSearch": false };
      setState(() {
        _objFriend = _v;
      });
    }
  }

  _search_my_friend_by_id() async {

    FocusScope.of(context).requestFocus(new FocusNode());
    var _q = q_friend_id.text;
    Map<String ,dynamic> _q_obj = {"id":_q};
    var _e = await FriendService.search_friend("id",_q_obj);

    if(_e != null){
      _e["isSearch"] = true;
      setState(() {
        _objFriend = _e;
      });
    }
    else{
      var  _v = {"isSearch": false };
      setState(() {
        _objFriend = _v;
      });
    }

    // print(_e);

  }

  _search_my_friend_by_qr() async {


    var _q = _qrInfo;
    Map<String ,dynamic> _q_obj = {"qr":_q};
    var _e = await FriendService.search_friend("qr",_q_obj);

    if(_e != null){
      _e["isSearch"] = true;
      setState(() {
        _objFriend = _e;
      });
    }
    else{
      var  _v = {"isSearch": false };
      setState(() {
        _objFriend = _v;
      });
    }
    // print(_e);

  }

  Container _view_friend(){

    if(_objFriend != null){
      if(_objFriend["isSearch"] == true){
        return Container(
            margin : const EdgeInsets.only(top: 40),
            child: Column(
                crossAxisAlignment:
                CrossAxisAlignment.center,
                mainAxisAlignment:
                MainAxisAlignment.start,
                children: <Widget>[

                  MyCircleAvatar(
                    imgUrl: _objFriend["ImgUrl"],
                    width: 120,
                    height: 120,
                  ),

                  SizedBox(height: 10),
                  Text(_objFriend["FullName"],
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        color: Colors.black54,
                      )
                  ),
                  SizedBox(height: 30),
                  InkWell(
                      child: Container(
                          width: 200,
                          child: Text(
                              "เพิ่มเพื่อน",
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 18,
                                  color: Colors.white
                              )
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: config.HexColor("#78B5B4"),
                          ),
                          margin: EdgeInsets.only(top: 0),
                          padding: EdgeInsets.all(12)
                      ),
                      onTap: () {

                        _modalAlertConfirm(context, "ยืนยันการเพิ่ม", "หากต้องการเพิ่ม ให้กด ตกลง");

                      })
                ])
        );
      }
      else if(_objFriend["isSearch"] == false){
        return Container(
          child: Text("ไม่พบข้อมูล"),
        );
      }
      else{
        return Container();
      }
    }
    else{
      return Container();
    }



  }

  _add_my_friend() async {

    _onLoading();
    var _f =  await FriendService.add_friend(_objFriend);
    Navigator.pop(context);
    Navigator.pop(context, {"myfriend": _f,"action": "addfriend"});
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

//      print(val);

      if(val["confirm"] == "yes"){
        _add_my_friend();
      }

//      print(val);

    });
    ;
  }

  void _onLoading() {

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => PopupLoading(),
    );

  }


}




