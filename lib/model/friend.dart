import 'package:chatty/services/_connect.dart';
import 'package:chatty/services/_friend.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'member.dart';


class Friend {

  String id = UniqueKey().toString();
  String FriendID = null;
  DateTime CreateDateTime = null;
  DateTime UpdateDateTime =  null;
  String Uid = null;
  int Verify = 0;
//  List<Map<String, dynamic>>  MemberInfoList = [];

  Friend.init();

  Map<String, dynamic> toJson() =>
      {
        'FriendID': FriendID,
        'CreateDateTime': CreateDateTime,
        'UpdateDateTime': UpdateDateTime,
        'Uid': Uid,
        'Verify': Verify,
      };

  Future get_current_myfriend(_id) async{
    var _myfriend = await FriendService.myfriend_current(_id);
    return _myfriend;
  }

  Future<List<Map<String, dynamic>>> getFriendsList() async{

    List<Map<String, dynamic>> _list = [];

    var _doc_my = Member.myUid;
    var _con_my = firebaseCon.firestore_.collection("Members/$_doc_my/Friends");
    var _recheck = await _con_my.get();

    for(var _a in _recheck.docs){

      try{

        var _arr = _a.data();
        var _doc_m = await firebaseCon.firestore_.collection("Members").doc(_arr["Uid"]).get();

        var _obj = _doc_m.data();

        var imgUrl = _obj["ImgUrl"];
        var fullName = _obj["FullName"];
        var statusProfile = _obj["StatusProfile"];
        var pushToken = _obj["pushToken"];
        var uid = _obj["Uid"];
        var imgBgUrl = _obj["ImgBgUrl"];

        Map<String, dynamic> _info = {
          "ImgUrl":imgUrl,
          "FullName":fullName,
          "StatusProfile":statusProfile,
          "pushToken":pushToken,
          "Uid":uid,
          "ImgBgUrl":imgBgUrl
        };

        _arr["friend_info"] = _info;
        // _arr["Verify"] = false;
        _arr["select"] = false;
        _arr["State"] = 1;
        // print(_arr);
        _list.add(_arr);

      }catch(e){

        print(e.toString());

      }

    }

    // _recheck.docs.forEach((element) async {

    // });

    return _list;
  }


  Future<List<Map<String, dynamic>>> getFavoriteList() async{

    List<Map<String, dynamic>> _list = [];


    var _doc_my = Member.myUid;
    var _con_my = firebaseCon.firestore_.collection("Members/$_doc_my/Friends");
    var _recheck = await _con_my.where("Favorite" ,isEqualTo: true)
        .get();


      for(var _a in _recheck.docs){

      var _arr = _a.data();
      var _doc_m = await firebaseCon.firestore_.collection("Members").doc(_arr["Uid"]).get();

      var _obj = _doc_m.data();

      var imgUrl = _obj["ImgUrl"];
      var fullName = _obj["FullName"];
      var statusProfile = _obj["StatusProfile"];
      var pushToken = _obj["pushToken"];
      var uid = _obj["Uid"];
      var imgBgUrl = _obj["ImgBgUrl"];

      Map<String, dynamic> _info = {
        "ImgUrl":imgUrl,
        "FullName":fullName,
        "StatusProfile":statusProfile,
        "pushToken":pushToken,
        "Uid":uid,
        "ImgBgUrl":imgBgUrl
      };

      _arr["friend_info"] = _info;

      _list.add(_arr);
    };

    return _list;
  }


  Future<List<Map<String, dynamic>>> getGroupList() async{

    List<Map<String, dynamic>>  _list = new List();

    final firestoreInstance = FirebaseFirestore.instance;
    var _doc_my = Member.myUid;
    var _con_my = firestoreInstance.collection("Members/$_doc_my/Groups");
    var _recheck = await _con_my.get();

    for(var element in _recheck.docs) {
      var _arr = element.data();

      var ConMyGroup = firestoreInstance.collection("Rooms");
      var _count = await ConMyGroup.where("FriendID" , isEqualTo: _arr["GroupId"]).get();


      _arr["Info"] = _count.docs.length > 0 ? _count.docs[0].data() : [];
      _arr["Count"] = _count.docs.length > 0 ? _count.docs[0].data()["MemberInfo"].length : 0;

       // print(_arr);

      _list.add(_arr);
    }

    return _list;
  }


  Future<List<Map<String, dynamic>>> searchFriendsList() async{

    List<Map<String, dynamic>> _list = [];

    var _doc_my = Member.myUid;
    var _con_my = firebaseCon.firestore_.collection("Members").where("FullName" , arrayContains: "p" );
    var _recheck = await _con_my.get();

    for(var _a in _recheck.docs){

      try{
        var _arr = _a.data();
        var imgUrl = _arr["ImgUrl"];
        var fullName = _arr["FullName"];
        var statusProfile = _arr["StatusProfile"];
        var pushToken = _arr["pushToken"];
        var uid = _arr["Uid"];
        var imgBgUrl = _arr["ImgBgUrl"];

        Map<String, dynamic> _info = {
          "ImgUrl":imgUrl,
          "FullName":fullName,
          "StatusProfile":statusProfile,
          "pushToken":pushToken,
          "Uid":uid,
          "ImgBgUrl":imgBgUrl
        };

        _arr["friend_info"] = _info;
        // _arr["Verify"] = false;
        _arr["select"] = false;
        _arr["State"] = 1;
        // print(_arr);
        _list.add(_arr);

      }catch(e){

        print(e.toString());

      }

    }

    // _recheck.docs.forEach((element) async {

    // });

    return _list;
  }


}
