import 'package:chatty/chat/_room_chat.dart';
import 'package:chatty/model/chat.dart';
import 'package:chatty/model/member.dart';
import 'package:chatty/services/_chat.dart';
import 'package:chatty/services/_friend.dart';
import 'package:chatty/shared/ModalBottomSheet.dart';
import 'package:chatty/shared/widgets/mycircleavatar.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_qr_bar_scanner/qr_bar_scanner_camera.dart';
import '../config/app_config.dart' as config;
import '../navigationbar.dart';


class ProfileMyGroupWidget extends StatefulWidget {

  Map<String, dynamic> objInfo = {};

  ProfileMyGroupWidget({this.objInfo});

  @override
  _MyFriendState createState() => _MyFriendState();
}

class _MyFriendState extends State<ProfileMyGroupWidget> {


  Map<String, dynamic> _room_obj = {};

  bool _favoriteReload = false;


  bool _memberAccept = false;



  @override
  void initState() {



    _room_obj = widget.objInfo["Info"];


    _room_obj["MemberInfo"].forEach((key, value) {
      if(key == Member.myUid){
        setState(() {
          _memberAccept = value["Accept"];
        });
      }
    });


    super.initState();
  }


  @override
  Widget build(BuildContext context) {


    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    // print(_room_obj["MemberInfo"].length);

    // print(_room_obj["MemberInfo"]);

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
                  child: Member.photoBgUrl != null ? Container(
                    alignment: Alignment.topCenter,
//                height: 150.0,
                    width: width,
                    decoration: new BoxDecoration(
                      color: Colors.black38.withOpacity(0.55),
                      image: new DecorationImage(
                        image: NetworkImage(Member.photoBgUrl),
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
                bottom: 0,
                right: 0,
                left: 0,
                // height: 300,
                // top: 500,
                child: Container(
                  decoration: BoxDecoration(
                    color:  Colors.transparent,
//                        shape: BoxShape.circle,
                  ),
                  child: Column(

                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [

                      Container(
                        // height: 200,
                        margin: const EdgeInsets.only(top: 0, bottom: 10),
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
                                      blurRadius: 0
                                  )

                                ],
                              ),

                              child: MyCircleAvatar(
                                imgUrl: _room_obj["GroupImgUrl"],
                                width: 130,
                                height: 130,
                              ),

                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 15, bottom: 0),
                              decoration: BoxDecoration(
                                color:  Colors.transparent,
//                                shape: BoxShape.circle,
                              ),
                              child: InkWell(
                                onTap:  ()  {
                                },
                                child : Text(
                                  _room_obj["RoomName"].toString(),
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
                      ),

                      Container(
                        height: 40,
                        width: 250,
                        margin: const EdgeInsets.only(top: 0, bottom: 20),
                        // color: Colors.red,
                        alignment: Alignment.center,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: _room_obj["MemberInfo"].length > 5 ? 5 : _room_obj["MemberInfo"].length ,
                            itemExtent: 40.0,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {

                            var key = _room_obj["MemberInfo"].keys.elementAt(index);
                            var _arr = _room_obj["MemberInfo"][key];



                          return InkWell(
                              onTap: (){
//                            Navigator.of(context).push(PageRouteBuilder(
//                                opaque: false,
//                                pageBuilder: (BuildContext context, _, __) =>
//                                    ProfileMyFriendWidget()
//                            )
//                            );
                              },
                              child: index < 4 ? MyCircleAvatar(
                                imgUrl: _arr["ImgUrl"],
                                width: 40,
                                height: 40,
                              ) : Container(

                                child: Container(
                                  // color : Colors.blueGrey,
                                  width: 40,
                                  height: 40,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color : Colors.blueGrey,
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: Colors.blueGrey,
                                      width: 0,
                                    ),
                                  //        boxShadow: [
                                  //          BoxShadow(
                                  //              color: Colors.grey.withOpacity(.3),
                                  //              offset: Offset(0, 2),
                                  //              blurRadius: 5)
                                  //        ],
                                  ),
                                  child: Center(
                                    child: Text(
                                        "${_room_obj["MemberInfo"].keys.length} >",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 14
                                        ),
                                    ),
                                  ),
                                ),
                              )
                          );
                        }),
                      ),

                      Container(
                        height: 100,
                        margin: const EdgeInsets.only(left: 0,right: 0),
                        padding: EdgeInsets.only(top: 8,bottom : MediaQuery.of(context).padding.bottom),
                        color: Colors.white,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: _memberAccept == true ? InkWell(
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
                                            size: 35,
                                            color: Colors.black54,
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
                                              color: Colors.black54
                                          ),

                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                onTap: (){
                                  _add_room_chat();
                                },
                              ) : InkWell(
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
                                            size: 32,
                                            color: Colors.black54,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        padding : const EdgeInsets.only(bottom: 3,top: 0),
                                        child: Text(
                                          "เข้าร่วม",
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black54
                                          ),

                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                onTap: (){
                                  //

                                  _modalAlertConfirm(context, "ยืนยัน", "หากต้องการเข้าร่วมกลุ่ม ให้กด ตกลง").then((value){

                                    if(value != null){

                                      Map<String,dynamic> _obj = value;

                                      if(_obj["confirm"] == "yes"){
                                        _add_room_chat();
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
                                          color: Colors.black54,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      padding : const EdgeInsets.only(bottom: 3,top: 0),
                                      child: Text(
                                        "โน็ต",
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.black54
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
                                          color: Colors.black54,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      padding : const EdgeInsets.only(bottom: 3,top: 0),
                                      child: Text(
                                        "อัลบั้ม",
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.black54
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
                    ],
                  ),
                ),
              ),

              Positioned(
                  top: 0,
                  // bottom: 0,
                  right: 0,
                  left: 0,
                  height: (50+MediaQuery.of(context).padding.top),
                  child: Container(
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
                                        // IconButton(
                                        //   padding: EdgeInsets.only(left: 10,right: 15),
                                        //   onPressed:  ()  {
                                        //     setState(() {
                                        //       _favorite = _favorite == false ? true : false;
                                        //       _update_favorite();
                                        //     });
                                        //   },
                                        //   icon: Icon(
                                        //     _favorite == false ? Icons.star_border : Icons.star,
                                        //     color: Theme.of(context).primaryColor,
                                        //     size: 30,
                                        //   ),
                                        // ),
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
              ),

            ],
          )
      ),
    );
  }



  _add_room_chat() async{

    ChatRooms  _room = new ChatRooms.init();
    var date = new DateTime.now();

    var _frind = _room_obj;
    _room.FriendID = _frind["FriendID"];
    _room.RoomID = _frind["RoomID"];
    var _value = await ChatService.accept_in_room(_room.toJson());

    // print(_value);

    if(_memberAccept == false){

      setState(() {
        _memberAccept = true;
        // _room_obj["Accept"] = true;
      });


    }
    else{

      // print(_value);

      var objInfoFriend = {};
      objInfoFriend["Uid"] = _value["Uid"];
      objInfoFriend["RoomName"] = _value["RoomName"];
      objInfoFriend["ImgUrl"] = _value["RoomImgUrl"];

      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => RoomChatWidget(
          objRoom: _value,
          infoFriend : objInfoFriend
      )));

      //Navigator.pop(context, {"action": "chat" ,"_objRoom" : _value, "favoriteRe":_favoriteReload});

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


}
