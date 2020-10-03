
import 'package:chatty/services/_connect.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'member.dart';

class Chat {
  String id = UniqueKey().toString();
  String ChatID;
  String messageChat;
  String CreateTimeStamp;
  Member member;
  Conversation LastConversation;

  Chat(this.ChatID, this.messageChat, this.CreateTimeStamp, this.member);

  Chat.init();

}

enum MessageType {sent, received}

class ChatRooms {

  String id = UniqueKey().toString();
  String RoomID;
  String FriendID;
  String RoomName;
  String RoomType;
  // List<String> MemberList = [];
  Map<String, dynamic> MemberInfo = {
    "FullName" :"",
    "Uid":"",
    "ImgUrl":"",
    "Accept":false,
    "dateTimeAccept":null,
    "UnseenCount":0,
  };
  DateTime CreateDateTime;
  DateTime UpdateDateTime;
  DateTime LastTimeStamp;
  String LastMsg;
  String RoomImgUrl;
  String RoomBgImgUrl;


  ChatRooms.init();

  Map<String, dynamic> toJson() =>
      {
        'RoomID': RoomID,
        'FriendID': FriendID,
        'RoomName': RoomName,
        'RoomType': RoomType,
        // 'MemberList': MemberList,
        'MemberInfo': MemberInfo,
        'CreateDateTime': CreateDateTime,
        'UpdateDateTime': UpdateDateTime,
        'LastDateTime': LastTimeStamp,
        'LastMsg': LastMsg,
        'RoomImgUrl': RoomImgUrl,
        'RoomBgImgUrl': RoomBgImgUrl,
      };

  static Map<String, dynamic> MemberInRoom = {};


  // static Map<String, dynamic> MemberAcceptLoad = {};



  static getRoomList() async{

    var _id_my = Member.myUid;
    var _con_room = firebaseCon.firestore_.collection("Rooms");
    var _fil_key = "MemberInfo.$_id_my.Accept";
    var _readRom = _con_room.where(_fil_key , isEqualTo : true).snapshots();
    return _readRom;

  }


  static Future<dynamic> getInfoRoomList(String _friend_id) async{
    var _doc_my = Member.myUid;
    var _con_my = firebaseCon.firestore_.collection("Members/$_doc_my/Friends");
    var _recheck = await _con_my.doc(_friend_id).get();
    var _data =  _recheck.data;
    return _data;
  }


}

class Conversation {

  String id = UniqueKey().toString();
  String ChatID;
  String Uid;
  String Name;
  Map<String, dynamic> Read;
  DateTime CreateDatetime;
  DateTime UpdateDatetime;
  String Message;
  String ContactImgUrl;
  int State = 2;

  Conversation.init();

  Map<String, dynamic> toJson() =>
      {
        'ChatID': ChatID,
        'Uid': Uid,
        'Name': Name,
        'Read': Read,
        'CreateDatetime': CreateDatetime,
        'UpdateDatetime': UpdateDatetime,
        'Message': Message,
        'ContactImgUrl': ContactImgUrl,
        'State': State
      };




}




