import 'package:chatty/chat/_room_chat.dart';
import 'package:chatty/model/chat.dart';
import 'package:chatty/model/friend.dart';
import 'package:chatty/model/member.dart';
import 'package:chatty/services/_chat.dart';
import 'package:chatty/services/_friend.dart';
import 'package:chatty/shared/ModalBottomSheet.dart';
import 'package:chatty/shared/widgets/mycircleavatar.dart';
import 'package:chatty/shared/widgets/popupLoading.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_qr_bar_scanner/qr_bar_scanner_camera.dart';
import '../config/app_config.dart' as config;
import '../navigationbar.dart';


class ProfileMyFriendWidget extends StatefulWidget {

  Map<String, dynamic> objInfo;

  ProfileMyFriendWidget({this.objInfo});

  @override
  _MyFriendState createState() => _MyFriendState();
}

class _MyFriendState extends State<ProfileMyFriendWidget> {


  bool _favorite = false;
  bool _favoriteReload = false;
  Friend _friend = new Friend.init();
  Map<String, dynamic> _Info;

  @override
  void initState() {

    if(widget.objInfo["Favorite"] != null){
      _favorite = widget.objInfo["Favorite"];
    }

    _friend.get_current_myfriend(widget.objInfo["Uid"]).then((result) {
      setState(() {
      widget.objInfo["ImgBgUrl"] = result["ImgBgUrl"];
      });
    });

    _Info = widget.objInfo["friend_info"];

    // print(_Info);

    super.initState();
  }


  @override
  Widget build(BuildContext context) {

    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

   // print(widget.objInfo);


    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
          margin: const EdgeInsets.only(bottom: 0),
          child: Stack(
            children: <Widget>[

              Positioned(
                  bottom: 0,
                  right: 0,
                  left: 0,
                  top: 0,
                  child: _Info["ImgBgUrl"] != null ? Container(
                    alignment: Alignment.topCenter,
//                height: 150.0,
                    width: width,
                    decoration: new BoxDecoration(
                      color: Colors.black38.withOpacity(0.55),
                      image: new DecorationImage(
                        image: NetworkImage(_Info["ImgBgUrl"]),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ) : Container(
                    alignment: Alignment.topCenter,
//                    height: 150.0,
                    width: width,
                    decoration: new BoxDecoration(
                      image: new DecorationImage(
                        image: new AssetImage("assets/images/bg-profile.png"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),

              ),


              Positioned(
                  top: 0,
                bottom: 0,
                right: 0,
                left: 0,
                child: Container(
                  color: Colors.black.withOpacity(0.3),
                )
                ),

              Positioned(
                bottom: 10,
                right: 0,
                left: 0,
                height: 180,
                child: Container(
                  decoration: BoxDecoration(
                    color:  Colors.transparent,
//                        shape: BoxShape.circle,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
//                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [

                      Expanded(
                          child: Container(
                            margin: const EdgeInsets.only(left: 10,right: 10),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [

                                widget.objInfo["Verify"] == 1 ?

                                Expanded(
                                  child: InkWell(
                                    child: Container(
                                      height: 70,
                                      decoration: BoxDecoration(
                                        color: Colors.transparent,
                                        //border: new Border.all(color: Colors.teal[200], width: 1.4),
                                        borderRadius: new BorderRadius.circular(0.0),
                                      ),
                                      child: Column(
                                        children: <Widget>[
                                          Expanded(
                                            child: Container(
                                              padding : const EdgeInsets.only(bottom: 0,top: 3),
                                              child: ImageIcon(
                                                AssetImage("assets/images/icons/icons-chat.png"),
                                                size: 36,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            padding : const EdgeInsets.only(bottom: 3,top: 0),
                                            child: Text(
                                              "แชท",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.white
                                              ),

                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    onTap: (){
                                      _room_chat();
                                    },
                                  ),
                                ) : Expanded(
                                  child: InkWell(
                                    child: Container(
                                      height: 70,
                                      decoration: BoxDecoration(
                                        color: Colors.transparent,
                                        //border: new Border.all(color: Colors.teal[200], width: 1.4),
                                        borderRadius: new BorderRadius.circular(0.0),
                                      ),
                                      child: Column(
                                        children: <Widget>[
                                          Expanded(
                                            child: Container(
                                              padding : const EdgeInsets.only(bottom: 0,top: 3),
                                              child: ImageIcon(
                                                AssetImage("assets/images/icons/icon-add-contact.png"),
                                                size: 34,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            padding : const EdgeInsets.only(bottom: 3,top: 0),
                                            child: Text(
                                              "เพิ่มเพื่อน",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.white
                                              ),

                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    onTap: (){
                                      //

                                      _modalAlertConfirm(context, "ยืนยัน", "หากต้องการยอมรับเพิ่มเพื่อน ให้กด ตกลง").then((value){

                                        if(value != null){

                                          Map<String,dynamic> _obj = value;

                                          if(_obj["confirm"] == "yes"){
                                            _add_accept_chat();
                                          }

                                        }

                                      });

                                    },
                                  ),
                                ),

                                Expanded(
                                  child: Container(
                                    height: 70,
                                    decoration: BoxDecoration(
                                      color: Colors.transparent,
                                      //border: new Border.all(color: Colors.teal[200], width: 1.4),
                                      borderRadius: new BorderRadius.circular(0.0),
                                    ),
                                    child: Column(
                                      children: <Widget>[
                                        Expanded(
                                          child: Container(
                                            padding : const EdgeInsets.only(bottom: 0,top: 3),
                                            child: ImageIcon(
                                              AssetImage("assets/images/icons/icons-call.png"),
                                              size: 35,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          padding : const EdgeInsets.only(bottom: 3,top: 0),
                                          child: Text(
                                            "โทร",
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.white
                                            ),

                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    height: 70,
                                    decoration: BoxDecoration(
                                      color: Colors.transparent,
                                      //border: new Border.all(color: Colors.teal[200], width: 1.4),
                                      borderRadius: new BorderRadius.circular(0.0),
                                    ),
                                    child: Column(
                                      children: <Widget>[
                                        Expanded(
                                          child: Container(
                                            padding : const EdgeInsets.only(bottom: 0,top: 3),
                                            child: ImageIcon(
                                              AssetImage("assets/images/icons/icons-video-message.png"),
                                              size: 35,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          padding : const EdgeInsets.only(bottom: 3,top: 0),
                                          child: Text(
                                            "วีดีโอคอล",
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.white
                                            ),

                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                )
                              ],

                            ),
                          )
                      ),

                      Container(
                        height: 1.0,
                        margin:
                        EdgeInsets.only(top: 20, bottom: 4, left: 8, right: 8),
                        decoration: BoxDecoration(
                          border: Border(
                            top: BorderSide(
                              color: Theme.of(context).primaryColor,
                              width: 0.6,
                            ),
                          ),
                        ),
                      ),

                      Container(
                        height: 80,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [

                            Expanded(
                              child: Container(
                                child: Text(
                                  "โมเมนต์",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white
                                  ),
                                ),
                              ),
                            ),

                            Expanded(
                              child: Container(
                                child: Text(
                                  "รูป & วีดีโอ",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white
                                  ),
                                ),
                              ),
                            ),

                          ],

                        ),
                      )


                    ],
                  ),
                ),
              ),

              Align(
                  alignment: Alignment.center,
                  child: Container(
                    height: 180,
                    child: Column(
                      children: <Widget>[
                        Container(
                          height: 130,
                          width: 130,
                          padding: const EdgeInsets.all(1.0),
                          decoration: BoxDecoration(
                            color: Theme.of(context)
                                .primaryColor
                                .withOpacity(1.0),
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                  color: Theme.of(context)
                                      .hintColor
                                      .withOpacity(0.10),
                                  offset: Offset(0, 2),
                                  blurRadius: 0)
                            ],
                          ),

                          child: MyCircleAvatar(
                            imgUrl: _Info["ImgUrl"],
                            width: 130,
                            height: 130,
                          ),

                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 10, bottom: 0),
                          decoration: BoxDecoration(
                            color:  Colors.transparent,
//                                shape: BoxShape.circle,
                          ),
                          child: InkWell(
                            onTap:  ()  {
                            },
                            child : Text(
                              _Info["FullName"].toString(),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
              ),

              Container(
                  height: (50+MediaQuery.of(context).padding.top),
                  padding: EdgeInsets.only(left: 0 ,right: 0, top : MediaQuery.of(context).padding.top, bottom: 0),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(0),
                        bottomRight: Radius.circular(0)),
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
                                margin: const EdgeInsets.only(left: 0,top: 0),
                                child: Container(
                                  height: 50.0,
                                  width: 50.0,
                                  child: IconButton(
                                    alignment: Alignment.center,
                                    icon: Icon(
                                      Icons.clear,
                                      color: Theme.of(context).primaryColor,
                                      size: 30,
                                    ),
                                    onPressed: () => {
                                      Navigator.pop(context, {"action": "close","favoriteRe":_favoriteReload}),
                                    },
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
                                          setState(() {
                                          _favorite = _favorite == false ? true : false;
                                          _update_favorite();
                                          });
                                      },
                                      icon: Icon(
                                        _favorite == false ? Icons.star_border : Icons.star,
                                        color: Theme.of(context).primaryColor,
                                        size: 30,
                                      ),
                                    ),
                                    IconButton(
                                      padding: EdgeInsets.only(left: 10,right: 5),
                                      onPressed:  ()  {

                                      },
                                      icon: Icon(
                                        Icons.more_horiz,
                                        color: Theme.of(context).primaryColor,
                                        size: 30,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ])
              ),

            ],
          )
      ),
    );


  }


  _update_favorite() async{

    var _frind = widget.objInfo;
    _frind["favorite"] = _favorite;
     FriendService.update_favorite(_frind);
    _favoriteReload = true;

  }

  _room_chat() async{

    ChatRooms  _room = new ChatRooms.init();
    var date = new DateTime.now();

    var _frind = widget.objInfo;

    _room.FriendID = _frind["FriendID"];

    var __frindInfo = {
      "FullName" : _Info["FullName"],
      "Uid":_Info["Uid"],
      "ImgUrl":_Info["ImgUrl"],
      "Accept" : false,
      "dateTimeAccept":date,
      "UnseenCount":0
    };

    var __myInfo = {
      "FullName" : Member.myName,
      "Uid": Member.myUid,
      "ImgUrl": Member.photoUrl,
      "Accept" : true,
      "dateTimeAccept":date,
      "UnseenCount":0
    };

    _room.MemberInfo = {
      Member.myUid : __myInfo,
      _Info["Uid"] : __frindInfo
    };

    _room.RoomType = "Friend";

    var _obj = _room.toJson();
    _obj["CreateDateTime"] = date;
    _obj["UpdateDateTime"] = date;

    var objInfoFriend = {};
    objInfoFriend["Uid"] = _Info["Uid"];
    objInfoFriend["RoomName"] = _Info["FullName"];
    objInfoFriend["ImgUrl"] = _Info["ImgUrl"];

    //ChatRooms.MemberAcceptLoad = _room.MemberInfo;

    // print(_obj);
    var _value = await ChatService.create_rooms(_obj);
    // print(_value);

    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => RoomChatWidget(
        objRoom: _value,
        infoFriend : objInfoFriend
    )));

  }

  _add_accept_chat() async{

    ChatRooms  _room = new ChatRooms.init();
    var date = new DateTime.now();

    _onLoading();

    var _frind = widget.objInfo;

    //_room.MemberList = [_frind["Uid"].toString(),Member.myUid.toString()];

    _room.RoomType = "Friend";
    _room.FriendID = _frind["FriendID"];

    var __frindInfo = {
      "FullName" : _Info["FullName"],
      "Uid":_Info["Uid"],
      "ImgUrl":_Info["ImgUrl"],
      "Accept" : false,
      "dateTimeAccept":date
    };

    var __myInfo = {
      "FullName" : Member.myName,
      "Uid": Member.myUid,
      "ImgUrl": Member.photoUrl,
      "Accept" : true,
      "dateTimeAccept":date
    };

    _room.MemberInfo = {
      Member.myUid : __myInfo,
      _frind["Uid"] : __frindInfo
    };

    var _obj = _room.toJson();
    _obj["CreateDateTime"] = date;
    _obj["UpdateDateTime"] = date;

    var _value = await ChatService.accept_in_room(_obj);
    Navigator.pop(context);

    if(_value != null){
      setState(() {
        widget.objInfo["Verify"] = 1;
      });
    }

  }



  Future _modalAlertConfirm(context, String title, String description) async {

   return await showModalBottomSheet(
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
          return val;
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
