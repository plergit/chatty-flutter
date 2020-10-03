
import 'package:chatty/model/member.dart';
import 'package:chatty/shared/widgets/mycircleavatar.dart';
import 'package:flutter/material.dart';


class ChatItemWidget extends StatelessWidget {

  Map<String, dynamic> obj_arr;


  ChatItemWidget({
    Key key,
    this.obj_arr,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {

    var objInfoFriend = {};


    if(obj_arr["RoomType"] == "Friend"){

      obj_arr["MemberInfo"].forEach((_k,_v){
        if(_k != Member.myUid){
          objInfoFriend["Uid"] = _v["Uid"];
          objInfoFriend["RoomName"] = _v["FullName"];
          objInfoFriend["ImgUrl"] = _v["ImgUrl"];
        }
      });
    }
    else if(obj_arr["RoomType"] == "Group"){
      // print(obj_arr["RoomImgUrl"]);
      objInfoFriend["Uid"] = obj_arr["FriendID"];
      objInfoFriend["RoomName"] = obj_arr["RoomName"];
      objInfoFriend["ImgUrl"] = obj_arr["RoomImgUrl"] == null ? "-" : obj_arr["RoomImgUrl"];
      // objInfoFriend = obj_arr;
    }

    // print(objInfoFriend);
    // print(obj_arr);

    var dateChat = obj_arr["UpdateDateTime"].toDate();
    var today = new DateTime.now();
    String time = "${dateChat.hour}:${dateChat.minute}";
    final difference = today.difference(dateChat).inDays;

    if(difference > 0){
      time = "เมือวาน";
    }

   var _memberInRoom = obj_arr["MemberInfo"];

    var _roomMame = "${objInfoFriend["RoomName"]} ${_memberInRoom.length > 2 ? "(${_memberInRoom.length.toString()})" : " "}" ;

    // print(objInfoFriend);

    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor.withOpacity(1.0),
        border: Border(
          bottom: BorderSide(
            color: Colors.black26,
            width: 0.4,
          ),
        ),
      ),
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Stack(
            children: <Widget>[
              SizedBox(
                width: 50,
                height: 50,
                child: MyCircleAvatar(
                  imgUrl: objInfoFriend["ImgUrl"],
                  width: 45,
                  height: 45,
                ),
              ),
              Positioned(
                top: 3,
                right: 3,
                width: 12,
                height: 12,
                child: Container(
                  decoration: BoxDecoration(
                    color: obj_arr["IsOnline"] == true ? Colors.green : Colors.transparent,
                    shape: BoxShape.circle,
                  ),
                ),
              )
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
                    alignment: Alignment.centerLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          child: Text(
                            _roomMame,
//                          obj_arr["RoomName"],
                            overflow: TextOverflow.fade,
                            softWrap: false,
                            maxLines: 1,
                            style: Theme.of(context).textTheme.body2.merge(
                                TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14,
                                    color: Colors.black
                                )
                            ),
                          ),
                        ),
                        Expanded(
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              obj_arr["LastMsg"] == null ? "แชทกับเพื่อนใหม่กัน" : obj_arr["LastMsg"],
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              // textAlign: TextAlign.left,
                              style: Theme.of(context).textTheme.caption.merge(
                                  TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 13,
                                      color: Colors.grey
                                  )),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ),
                SizedBox(width: 5),
                Container(
                  height: 50,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          time == null ? "" : time,
                          overflow: TextOverflow.fade,
                          softWrap: false,
                          style: Theme.of(context).textTheme.caption.merge(
                              TextStyle(
                                  fontWeight: FontWeight.w300,
                                  fontSize: 13
                              )
                          ),
                        ),
                      ),

                       obj_arr["UnseenCount"] > 0 ? Container(
                        height: 25,
                        padding: EdgeInsets.only(left: 8, right: 8,top: 5,bottom: 5),
                        decoration: BoxDecoration(
                          color: Theme.of(context).accentColor.withOpacity(0.7),
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(15),
                              topRight: Radius.circular(15),
                              bottomLeft: Radius.circular(15),
                              bottomRight: Radius.circular(15)
                          ),
                        ),
                        child: Center(
                          child:  Text(
                            obj_arr["UnseenCount"].toString(),
                            softWrap: false,
                            style: TextStyle(
                                fontSize: 13 ,
                                color: Colors.white,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        )
                      ) : Container()

                    ],
                  ),
                ),
                SizedBox(width: 5),

              ],
            ),
          )
        ],
      ),
    );




  }
}


