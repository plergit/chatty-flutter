import 'dart:io';

import 'package:chatty/model/member.dart';
import 'package:chatty/services/_groups.dart';
import 'package:chatty/shared/ModalBottomSheet.dart';
import 'package:chatty/shared/files/imagePicker/imagePicker.dart';
import 'package:chatty/shared/widgets/mycircleavatar.dart';
import 'package:chatty/shared/widgets/popupLoading.dart';
import 'package:flutter/material.dart';
import '../config/app_config.dart' as config;
import '_select_list_friend.dart';


class AddGRoupWidget extends StatefulWidget {
  @override
  _AddState createState() => _AddState();
}

class _AddState extends State<AddGRoupWidget> {


  @override
  void initState() {
    super.initState();

    _listFriend = _listDe;

  }


  @override
  void dispose() {
    super.dispose();
  }

  List<Map<String, dynamic>> _listFriend = [];

  List<Map<String,dynamic>> _listSelectFriend  = [];

  List<Map<String, dynamic>> _listDe = [
    {
      'ImgUrl': '',
      'FullName': 'เพิ่ม',
      'type':'btn'
    },
    {
      'ImgUrl': Member.photoUrl,
      'FullName': Member.myName,
      "Uid" : Member.myUid,
      "FriendID" : "",
      "State" : 0,
      'type':'friend'
    }
  ];


  TextEditingController nameGroup = TextEditingController();

  File _logo ;

  @override
  Widget build(BuildContext context) {

    var width = MediaQuery
        .of(context)
        .size
        .width;
    var height = MediaQuery
        .of(context)
        .size
        .height;

    //


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
                                      "สร้างกลุ่ม",
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
                                child: InkWell(
                                    child: Container(
                                        constraints: BoxConstraints.expand(
                                            height: 30,
                                            width: 70
                                        ),
                                        child: Text("บันทึก",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w600,
                                            )
                                        ),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                          // color: config.HexColor("#79B5B4"),
                                        ),
                                        margin: EdgeInsets.only(right: 5,left: 5),
                                        padding: EdgeInsets.all(5)
                                    ),
                                    onTap: () {
                                      _save_group();
                                    }
                                ),
                              ),
                            ]),
                          ),
                        ],
                      )),
                )
            ),

            body: Column(

              children: <Widget>[

                Container(
                  height: 50,
                  margin: EdgeInsets.only(left: 0, right: 0,bottom: 8),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Theme.of(context)
                        .accentColor
                        .withOpacity(0.1),
                    borderRadius: BorderRadius.circular(0),
                  ),
                  child: Row(
                    children: <Widget>[
                      SizedBox(
                        width: 15,
                      ),
                      Expanded(
                          child: Text(
                            "ข้อมูลกลุ่ม",
                            style: TextStyle(
                                color: Colors.black45,
                                fontSize: 15
                            ),
                          )
                      ),

                      SizedBox(
                        width: 10,
                      ),
                    ],
                  ),
                ),

                Container(
                  height: 80,
                  margin: EdgeInsets.only(left: 10, right: 0),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Theme.of(context)
                        .primaryColor
                        .withOpacity(0.0),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Row(
                    children: <Widget>[

                      Container(
                        width: 80,
                        height: 80,
                        margin : EdgeInsets.only(left: 5,right: 10),
                        child:  Stack(
                          children: [

                            _logo == null ? Container(
                              width: 80,
                              height: 80,
                              child: CircleAvatar(
                                backgroundColor: Colors.white,
                                backgroundImage: AssetImage("assets/images/logo/rectangle.png"),
                              ),
                            ) : Container(
                              width: 80,
                              height: 80,
                              decoration: new BoxDecoration(
                                color: Colors.black38.withOpacity(0.15),
                                shape: BoxShape.circle,
                                image: new DecorationImage(
                                  image: Image.file(_logo, fit: BoxFit.cover ).image,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),

                            Positioned(
                              bottom : 2,
                              right: 2,
                              // left: 0,
                              height: 25,
                              width: 25,
                              child: Container(
                                decoration: BoxDecoration(
                                     color:  Colors.black38,
                                  borderRadius: BorderRadius.all(Radius.circular(8.0))
                                ),
                                child: IconButton(
                                  padding: EdgeInsets.only(left: 3,right: 3,top: 3,bottom: 3),
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
                                        }).then((val) async {

                                      if(val != null)
                                      {
                                          setState(() {
                                            _logo = val;
                                          });
                                      }
                                    });

                                  },
                                  icon: Icon(
                                    Icons.camera_alt,
                                    color: Theme.of(context).primaryColor,
                                    size: 15,
                                  ),
                                ),
                              ),
                            )

                          ],
                        )
                      ),
                      Expanded(
                        child: Container(
                          height: 50,
                          child: TextField(
                            keyboardType: TextInputType.emailAddress,
                            style: TextStyle(color: Theme.of(context).hintColor),
                            controller: nameGroup,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'ชื่อกลุ่ม',
                              hintStyle: TextStyle(color: Colors.black26 , fontSize: 15),
                            ),
                          ),
                        ),
                      ),


                    ],
                  ),
                ),

                Container(
                  height: 40,
                  margin: EdgeInsets.only(left: 0, right: 0,top: 8,bottom: 15),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Theme.of(context)
                        .accentColor
                        .withOpacity(0.02),
                    borderRadius: BorderRadius.circular(0),
                  ),
                  child: Row(
                    children: <Widget>[
                      SizedBox(
                        width: 15,
                      ),
                      Expanded(
                          child: Text(
                            "สมาชิก",
                            style: TextStyle(
                                color: Colors.black45,
                                fontSize: 15),
                          )
                      ),
                      SizedBox(
                        width: 10,
                      ),
                    ],
                  ),
                ),

                Expanded(

                  child: Container(
                    margin: const EdgeInsets.only(left: 10, right: 10),
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                    ),
                    child: GridView.count(
                      mainAxisSpacing: 10.0,
                      crossAxisSpacing: 10.0,
                      crossAxisCount: 4,
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      primary: false,
                      childAspectRatio: 16/18.0,
                      children: List.generate(
                        _listFriend.length, (index) {

                          var _arr = _listFriend[index];

                          // _arrInfo

                          // var _arrInfo = _arr["MemberInfo"];

                          // print(_arr);


                          if(_arr["type"] == "btn")
                            {

                            return Container(
                              decoration: BoxDecoration(
                                color: Colors.transparent,
                              ),
                              child: InkWell(
                                onTap: (){

                                  Navigator.of(context).push(
                                      PageRouteBuilder(
                                      opaque: false,
                                      pageBuilder: (BuildContext context, _, __) => FriendListSelectWidget(
                                            friends_list : _listSelectFriend
                                      )
                                    )
                                  ).then((value){

                                    if(value != null){

                                      Map<String,dynamic> _obj = value;
                                      if(_obj["action"] != "close"){

                                        var _objFriend  =  _obj["_arrselect"];

                                        _listFriend = [];
                                        List<Map<String,dynamic>> _listSelect = [];

                                        for (var _arr in _objFriend) {

                                          var _arrInfo = _arr["friend_info"];

                                            // print(_arrInfo);

                                            var __myInfo = {
                                              "FullName" : _arrInfo["FullName"],
                                              "Uid": _arrInfo["Uid"],
                                              "ImgUrl": _arrInfo["ImgUrl"],
                                              "Accept" : false,
                                              "dateTimeAccept":null
                                            };


                                            _listSelect.add(__myInfo);

                                        }

                                        _listSelectFriend = _listSelect;

                                        //_listFriend.
                                        // print(_listFriend.length);

                                        var newList = _listDe + _listSelectFriend;

                                        setState(() {
                                          _listFriend = newList;
                                        });

                                      }

                                    }

                                    // print("ddddddd $value");
                                    // setState(() {
                                    //
                                    // }),

                                  });

                                },
                                child: Container(
                                    child: Wrap(
                                      direction: Axis.horizontal,
                                      alignment: WrapAlignment.center,
                                      children: <Widget>[
                                        Container(
                                          height: 55,
                                          width: 55,
                                          margin: const EdgeInsets.all(5),
                                          decoration: BoxDecoration(
                                            gradient: LinearGradient(
                                                begin: Alignment.topRight,
                                                end: Alignment.bottomLeft,
                                                colors: [config.HexColor("#bfe1e2"), config.HexColor("#58a6a7")]
                                            ),
                                            borderRadius: BorderRadius.circular(27),
                                            boxShadow: [
                                              BoxShadow(
                                                  color: Theme.of(context)
                                                      .hintColor
                                                      .withOpacity(0.10),
                                                  offset: Offset(0, 2),
                                                  blurRadius: 4)
                                            ],
                                          ),
                                          child: Icon(
                                            Icons.add,
                                            color: Theme.of(context).primaryColor,
                                            size: 30,
                                          ),
                                        ),
                                        Container(
                                            margin: const EdgeInsets.only(top: 5, bottom: 0),
                                            child: Center(
                                              child: Text(
                                                _arr["FullName"],
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w300,
                                                    color: Colors.black87
                                                ),
                                              ),
                                            )
                                        )
                                      ],
                                    )
                                ),
                              ),

                            );

                            }
                          else
                            {

                            return Container(
                                child: Wrap(

                                  direction: Axis.horizontal,
                                  alignment: WrapAlignment.center,

                                  children: <Widget>[

                                    Container(
                                      child: Stack(
                                        children: [

                                          Container(
                                            height: 55,
                                            width: 55,
                                            alignment: Alignment.center,
                                            margin: const EdgeInsets.all(5),
                                            decoration: BoxDecoration(
                                              gradient: LinearGradient(
                                                  begin: Alignment.topRight,
                                                  end: Alignment.bottomLeft,
                                                  colors: [config.HexColor("#bfe1e2"), config.HexColor("#58a6a7")]
                                              ),
                                              borderRadius: BorderRadius.circular(27),
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
                                            child: MyCircleAvatar(
                                              imgUrl: _arr["ImgUrl"],
                                              width: 55,
                                              height: 55,
                                            ),
                                          ),

                                          _arr["Uid"] != Member.myUid ? Positioned(
                                            top: 0,
                                            right: 0,
                                            width: 25,
                                            height: 25,
                                            child: InkWell(
                                              onTap: (){
                                                _modalAlertConfirm(context,_arr["Uid"],"ยืนยัน", "หากต้องการลบ ให้กด ตกลง หรือ ยกเลิกเพื่อปิด");
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color:  Colors.red,
                                                  shape: BoxShape.circle,
                                                ),
                                                child: Icon(
                                                  Icons.close,
                                                  color: Theme.of(context).primaryColor,
                                                  size: 18,
                                                ),
                                              ),
                                            ),
                                          ) : Container(
                                            width: 25,
                                            height: 25,
                                          )

                                        ],
                                      ),
                                    ),

                                    Container(
                                        margin: const EdgeInsets.only(top: 5, bottom: 0),
                                        child: Center(
                                          child: Text(
                                            _arr["FullName"] == null ? "" : _arr["FullName"],
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w300,
                                                color: Colors.black87
                                            ),
                                          ),
                                        )
                                    )

                                  ],
                                )
                            );

                            }

                        },
                      ),
                    ),
                  ),
                )

              ],

            )

        )
    );


  }


  void _save_group(){

    print(_listSelectFriend.length);

    if(nameGroup.text.isEmpty){
      _modalAlertError(context, "แจ้งเตือน", "กรุณาระบุ ชื่อกลุ่มที่สร้าง" );
    }
    else if(_listSelectFriend.length == 0){
      _modalAlertError(context, "แจ้งเตือน", "กรุณาเลือกสมาชิกในกลุ่ม" );
    }
    else{
       _modalAlertConfirmSave(context,"ยืนยัน", "หากต้องการสร้างกลุ่ม ให้กด ตกลง หรือ ยกเลิก");
      }
  }


  void _modalAlertConfirmSave(context,String title, String description) {

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

      // print(val);

      if(val != null) {

        if(val["confirm"] == "yes"){

          _add_my_friend();

        }
      }



    });
  }

  _add_my_friend() async {



    String _name = nameGroup.text;

    var __myInfo = {
      "FullName" : Member.myName,
      "Uid": Member.myUid,
      "ImgUrl": Member.photoUrl,
      "Accept" : true,
      "dateTimeAccept":null
    };

    _listSelectFriend.add(__myInfo);

    _onLoading();

    Map<String, dynamic> _objGroup = {};
    _objGroup["GroupId"] = "";
    _objGroup["GroupName"] = _name;
    _objGroup["GroupImgUrl"] = _logo;
    _objGroup["GroupBgImgUrl"] = "";
    _objGroup["GroupListMember"] = _listSelectFriend;
    var _f =  await FriendGroupService.add_group(_objGroup);

    Navigator.pop(context);
    Navigator.pop(context, {"mygroup": _f,"action": "add"});

  }


  void _modalAlertError(context, String title, String description)  {
    showModalBottomSheet(
        context: context,
        isDismissible: false,
        elevation: 0,
        useRootNavigator: false,
        backgroundColor: Colors.transparent,
        builder: (BuildContext bc) {
          return modalBottomCostom(
            typeModel: "error",
            context: context,
            title: title,
            description: description,
            iconIn: Icons.error,
            colorIcon: Colors.red,
          );
        }).then((val) {
      //        return val;
    });
  }

  void _modalAlertConfirm(context,String _uid , String title, String description) {

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

          // print(val);
          if(val["confirm"] == "yes"){
            _delete_friend(_uid);
          }
          // _delete_friend(String _key)
        });
  }


  _delete_friend(String _key){
    List<Map<String,dynamic>> _objNew = [];
    _listSelectFriend = [];
    for (var _arr in _listFriend) {
      if(_key != _arr["Uid"]){
        _listSelectFriend.add(_arr);
        _objNew.add(_arr);
      }
    }
    setState(() {
      _listFriend =  _objNew;
    });
  }

  void _onLoading() {

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => PopupLoading(),
    );

  }


}