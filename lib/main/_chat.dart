
import 'package:chatty/model/member.dart';
import 'package:chatty/services/_notification.dart';
import 'package:chatty/shared/widgets/waiting_image_searching.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../model/chat.dart';
import '../chat/_room_chat.dart';
import '../chat/_room_Item.dart';


class ChatWidget extends StatefulWidget {

  //ShopChatWidget({this.shop});

  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<ChatWidget> {



  Stream<QuerySnapshot> _listRoom;




  Widget _fnroomList(){



    return StreamBuilder(
      stream: _listRoom,
      builder: (context, snapshot){

        var width = MediaQuery.of(context).size.width;
        var height = MediaQuery.of(context).size.height;

        List<Map<String , dynamic>>  _oobj = [];

        if(snapshot.hasData){

          for(var inArr in snapshot.data.docs){
            _oobj.add(inArr.data());
          }

          _oobj.sort((a,b) {
            var adate = a["UpdateDateTime"].toDate();
            var bdate = b["UpdateDateTime"].toDate();
            return -adate.compareTo(bdate);
          });

        }

        return snapshot.hasData ?

        _oobj.length > 0 ? ListView.builder(
            shrinkWrap: true,
            primary: false,
            reverse: false,
            itemCount: _oobj.length,
            itemBuilder: (context, index)  {

              var _arr = _oobj[index];
              var _info = _arr["MemberInfo"];

              // print(_info);
              // ChatRooms.MemberAcceptLoad = _info;

              _arr["UnseenCount"] = _info[Member.myUid.toString()]["UnseenCount"] == null ? 0 : _info[Member.myUid.toString()]["UnseenCount"];

              var objInfoFriend = {};

              if(_arr["RoomType"] == "Friend"){

                _info.forEach((_k,_v){

                  // print("-- $_k --- ${Member.myUid}");

                    if(_k != Member.myUid){

                      // print("-- $_k --- ${Member.myUid}");

                      objInfoFriend["Uid"] = _v["Uid"];
                      objInfoFriend["RoomName"] = _v["FullName"];
                      objInfoFriend["ImgUrl"] = _v["ImgUrl"];
                    }

                });
              }
              else if(_arr["RoomType"] == "Group"){
                objInfoFriend["Uid"] = _arr["FriendID"];
                objInfoFriend["RoomName"] = _arr["RoomName"];
                objInfoFriend["ImgUrl"] = _arr["RoomImgUrl"];
              }

              // print(objInfoFriend);

              return InkWell(
                onTap: () async {

                  Navigator.of(context).push(PageRouteBuilder(
                      opaque: false,
                      pageBuilder: (BuildContext context, _, __) =>
                          RoomChatWidget(
                              objRoom: _arr,
                              infoFriend : objInfoFriend
                          )
                    )
                  );

                },
                child: Container(

                  // child: Text("sssss"),
                  child:  ChatItemWidget(
                      obj_arr: _arr
                  ),
                ),
              );

            }) : Container(
          height: height-180,
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
        )

            : Container(
               height: (height-150),
              child: Center(
                child: WaitingImageSearching(),
              ),
        );

      },
    );



  }




  @override
  void initState() {


    ChatRooms.getRoomList().then((value) {
      setState(() {
        _listRoom = value;
      });

    });

    super.initState();
  }

  @override
  void dispose() {

    super.dispose();
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: PreferredSize(
          preferredSize: Size.fromHeight(100.0),
          child: AppBar(
            elevation: 1,
            backgroundColor: Theme
                .of(context)
                .accentColor,
            automaticallyImplyLeading: false, // hides leading widget
            flexibleSpace: Container(
                padding: EdgeInsets.only(left: 0, right: 0, top: MediaQuery
                    .of(context)
                    .padding
                    .top, bottom: 0),
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
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            margin: const EdgeInsets.only(left: 15,top: 0),
                            child: Text(
                              "CHAT",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white ,
                                  fontSize: 16),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(right: 8,top: 5),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[

                                IconButton(
                                  padding: EdgeInsets.only(left: 10,right: 5),
                                  onPressed:  ()  {
                                    // Navigator.of(context)
                                    //     .pushNamed('/add_friend', arguments: 1);
                                  },
                                  icon: Icon(
                                    Icons.more_vert,
                                    color: Theme.of(context).primaryColor,
                                    size: 23,
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
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
                          ),
                        ]
                    ),
                  ],
                )

            ),
          )
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      padding: EdgeInsets.symmetric(vertical: 0),

      child: Container(

        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[

            _fnroomList(),

          ],
        ),
      )

      ),
    );

  }
}

