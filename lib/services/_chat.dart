


import 'dart:convert';

import 'package:chatty/model/chat.dart';
import 'package:chatty/model/member.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '_connect.dart';
import '_notification.dart';
import 'http.dart';

//FriendService
class ChatService {

  static create_rooms(Map<String, dynamic> _obj) async {

    var _con_my = firebaseCon.firestore_.collection("Rooms");
    var _recheck = await _con_my
        .where("FriendID", isEqualTo : _obj["FriendID"]).get();
    var _e;

    if(_recheck.docs.length == 0){

      _obj['RoomID'] = _con_my.doc().id;
      _e = await firebaseCon.firestore_.collection("Rooms").doc(_obj['RoomID']).set(_obj).then((_event){
        return _obj;
      });

    }
    else
      {

      String __id = _obj["FriendID"];
      String __roomid =  _recheck.docs[0].get("RoomID");
      var __info =  _recheck.docs[0].data()["MemberInfo"];
      var _doc_my = Member.myUid;
      var _fil_key = "MemberInfo.$_doc_my.Accept";
      var _readRom = await _con_my.where("FriendID" , isEqualTo : __id).where(_fil_key , isEqualTo : true).get();

      if(_readRom.docs.length == 0){

           var _key_up = "MemberInfo.$_doc_my";
           var date = new DateTime.now();
           Map<String, dynamic> obj_merd = __info[_doc_my];

           obj_merd["Accept"] = true;
           obj_merd["dateTimeAccept"] = date;

          _e = await _con_my.doc(__roomid).update({
            _key_up:obj_merd
           }).then((_){
            return _recheck.docs[0].data();
          });
      }
      else{
        return _recheck.docs[0].data();
      }


    }

    return _e;
  }

  
  static get_info_room(Map<String, dynamic> _obj) async {

    var _con_my = firebaseCon.firestore_.collection("Rooms");
    String _friend_id = _obj["FriendID"];
    var _doc_my = Member.myUid;
    // var _fil_key = "MemberInfo.$_doc_my.Accept";
    var _readRom = await _con_my.where("FriendID" , isEqualTo : _friend_id).get();

    return _readRom.docs[0].data();
  }

  static accept_in_room(Map<String, dynamic> _obj) async{

    // print(_obj);

    var _con_my = firebaseCon.firestore_.collection("Rooms");
    String _friend_id = _obj["FriendID"];
    String _room_id = _obj["RoomID"];
    var _doc_my = Member.myUid;

    // print(_obj);

    QuerySnapshot _readRom ;

    if(_room_id == "" && _room_id == null){
      _readRom = await _con_my.where("RoomID", isEqualTo: _room_id).get();
    }
    else{
      _readRom = await _con_my.where("FriendID", isEqualTo: _friend_id).get();
    }

    // var _fil_key = "MemberInfo.$_doc_my.Accept";
    // print(_readRom.docs[0].data());


    if(_readRom.docs.length > 0){

      var _roomdata = _readRom.docs[0].data();

      Map<String, dynamic> __info = _roomdata["MemberInfo"];

      var _key_up = "MemberInfo.$_doc_my";
      var date = new DateTime.now();

      Map<String, dynamic> obj_merd  = {};
      obj_merd = __info[_doc_my];
      obj_merd["Accept"] = true;
      obj_merd["dateTimeAccept"] = date;

      if(_obj["RoomType"] == "Friend"){
        var _doc =  firebaseCon.firestore_.collection("Members").doc(Member.myUid).collection("Friends").doc(_friend_id);
        await _doc.update({"Verify":1});
      }

      var _e = await _con_my.doc(_readRom.docs[0].id).update({
        _key_up:obj_merd
      }).then((_){
        return _roomdata;
      });

      return _e;


    }
    else{

      _obj['RoomID'] = _con_my.doc().id;
      var _e = await firebaseCon.firestore_.collection("Rooms").doc(_obj['RoomID']).set(_obj).then((_event){
        return _obj;
      });
      return _e;

    }

  }

  static check_room(String _id) async {
    var _e = await firebaseCon.firestore_.collection("Rooms").doc(_id).get().then((_e){
      return _e.data;
    });
    return _e;
  }

  static send_message(Map<String, dynamic> _obj) async {

    var _rid =_obj['RoomID'];
    var _colTx = "Rooms/$_rid";
    var _col = firebaseCon.firestore_.collection("$_colTx/Message");

    update_count_message(_obj);

    _obj['ChatID'] = _col.doc().id;

    var _e = await _col.add(_obj).then((_){
      return "success!";
    });

    return _e;

  }

  static list_message_in_room(String _id) async {

    var _rid = _id;
    var _col = "Rooms/$_rid/Message";

    final document =   firebaseCon.firestore_.collection(_col).limit(50).orderBy('CreateDatetime', descending: true);
    List<Map<String, dynamic>> messages = [];
    await document.get().then((querySnapshot) {
      querySnapshot.docs.forEach((result) {
        messages.add(result.data());
      });
      messages.sort((a,b) {
        var adate = a['CreateDatetime']; //before -> var adate = a.expiry;
        var bdate = b['CreateDatetime']; //var bdate = b.expiry;
        return adate.compareTo(bdate);
      });

    });

    return messages;
  }

  static update_read_messages(_obj) async {

//  print(_obj["RoomID"]);

    var _con_my = firebaseCon.firestore_.collection("Rooms");
    var _myUid = Member.myUid;
    var _fil_key = "Read.$_myUid.Read";
    var _qruery = _con_my.doc(_obj["RoomID"]).collection("Message").where(_fil_key, isEqualTo : 0);
    var _re = await _qruery.get();

//    print(_re.documents.length);

    if(_re.docs.length > 0){

      for(var _ar in _re.docs){
        await _con_my.doc(_obj["RoomID"]).collection("Message").doc(_ar.id).update({
           _fil_key:1
        });
      }

      var _fil_key_update = "MemberInfo.$_myUid.UnseenCount";
      await firebaseCon.firestore_.collection("Rooms").doc(_obj["RoomID"]).update({
        _fil_key_update : 0
      });

    }

  }

  static update_count_message(_obj) async{

     Map<String, dynamic> _member_in_room = {};

     List<Map<String, dynamic>> _tokrnList = [];

    for (final key in ChatRooms.MemberInRoom.keys) {
      Map<String, dynamic> value = ChatRooms.MemberInRoom[key];

      var _fil_key = "Read.$key.Read";
      var ConMyGroup = firebaseCon.firestore_.collection("Rooms").doc(_obj['RoomID']).collection("Message");
      var _count = await ConMyGroup.where(_fil_key , isEqualTo: 0).get();

      var _count_m = _count.docs.length;

      if(_count_m > 0){
        var ConMem = await firebaseCon.firestore_.collection("Members").doc(value["Uid"]).get();
        var _ppp = ConMem.data();
        _tokrnList.add(_ppp["pushToken"]);
        // NotificationService().sendNotification();
        // NotificationService().showNotificationWithDefaultSound("title","Test");
      }

      value["UnseenCount"] = _count_m;
      _member_in_room[key] = value;
    }

    // print("##### ${_tokrnList}");

     Map<String, dynamic> _notiObj = {
       "tokrnList" : _tokrnList
     };

    if(_obj["Messagetype"] == 0){
      _obj["Message"] = _obj["Message"];
    }
    else if(_obj["Messagetype"] == 1){
      _obj["Message"] = "ส่งรูป";
    }
    else if(_obj["Messagetype"] == 2){
      _obj["Message"] = "ส่งสติ๊กเกอร์";
    }
    else if(_obj["Messagetype"] == 3){
      _obj["Message"] = "ส่งไฟล์";
    }
    else if(_obj["Messagetype"] == 4){
      _obj["Message"] = "แชร์ผู้ติดต่อ";
    }
    else if(_obj["Messagetype"] == 5){
      _obj["Message"] = "ส่งไฟล์เสียง";
    }
    else {
      _obj["Message"] = "";
    }

    _notiObj["UserSend"] = Member.myName;
    _notiObj["Message"] = _obj["Message"];

    // _notiObj["PlatForm"] = _obj["PlatForm"];
    // _notiObj["RoomID"] = _obj["RoomID"];
    // _notiObj["SendDateTime"] = _obj["UpdateDatetime"].toString();
    // _notiObj["SendState"] = 0;
    // print(_obj);

    firebaseCon.firestore_.collection("Rooms").doc(_obj['RoomID']).update({
      "MemberInfo" : _member_in_room,
      "LastMsg" : _obj["Message"],
      "UpdateDateTime" : _obj["UpdateDatetime"]
    });


     // var _conNoti = firebaseCon.firestore_.collection("Notification");
     // var _notiId = _conNoti.doc().id;
     // _notiObj["DocId"] = _notiId;
     // _conNoti.doc(_notiId).set(_notiObj);




     var _data = _notiObj;
     var arr = await httpService.http_post("server_send_noti_to_device" , _data);
     if(arr["code"] == 202) {
       print(arr);
     }

  }


}