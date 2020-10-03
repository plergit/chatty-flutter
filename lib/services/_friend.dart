import 'package:chatty/model/chat.dart';
import 'package:chatty/model/friend.dart';
import 'package:chatty/model/member.dart';
import '_chat.dart';
import '_connect.dart';

class FriendService {

  static myfriend_current(_id) async {

    var _e;

    await firebaseCon.firestore_.collection("Members")
        .where("Uid" ,isEqualTo: _id)
        .get().then((querySnapshot) {
      querySnapshot.docs.forEach((result) {
        _e = result.data();
        //print(result.data);
      });
    });

    return _e;

  }

  static search_friend(String _t,Map<String, dynamic> _obj) async {

    var _e;

    if(_t == "phon"){

      await firebaseCon.firestore_.collection("Members")
          .where("Country" ,isEqualTo: _obj["country"])
          .where("MobilePhone" ,isEqualTo: _obj["number"])
          .get().then((querySnapshot) {
          querySnapshot.docs.forEach((result) {
          _e = result.data();
          //print(result.data);
        });
      });

    }
    else if(_t == "id"){

      await firebaseCon.firestore_.collection("Members")
          .where("MemberID" ,isEqualTo: _obj["id"])
          .get().then((querySnapshot) {
        querySnapshot.docs.forEach((result) {
          _e = result.data();
          //print(result.data);
        });
      });

    }
    else if(_t == "qr"){


      await firebaseCon.firestore_.collection("Members")
          .where("Uid" ,isEqualTo: _obj["qr"])
          .get().then((querySnapshot) {
           querySnapshot.docs.forEach((result) {
          _e = result.data();
          //print(result.data);
        });
      });

    }



    return _e;
  }

  static add_friend(Map<String, dynamic> _obj) async {

    Friend _friend = new Friend.init();

    var _doc_my = Member.myUid;
    var _con_my = firebaseCon.firestore_.collection("Members/$_doc_my/Friends");
    var _recheck = await _con_my
        .where("Uid" , isEqualTo : _obj["Uid"].toString())
        .get();

    if(_recheck.docs.length == 0){

      _friend.FriendID = _con_my.doc().id;
      _friend.Uid = _obj["Uid"];
      _friend.Verify = 1;

      Map<String, dynamic> my_friend = _friend.toJson();
      var date = new DateTime.now();
      my_friend["CreateDateTime"] = date;

      await _con_my.doc(_friend.FriendID).set(my_friend);

      var _doc_friend = _obj["Uid"];
      var _con_friend = firebaseCon.firestore_.collection("Members/$_doc_friend/Friends");

      _friend.Uid = Member.myUid;
      _friend.Verify = 0;

      Map<String, dynamic> _value_friend = _friend.toJson();
      _value_friend["CreateDateTime"] = date;

      await _con_friend.doc(_value_friend["FriendID"]).set(_value_friend);

      Map<String, dynamic> _info_room = {
        "Info":_obj,
        "FriendID":_value_friend["FriendID"]
      };

      await create_room_chat(_info_room);


      return my_friend;

    }
    else{

      var _data ;
      _recheck.docs.forEach((element) {
        _data = element.data();
      });
      return _data;
      print("มีแล้วในระบบ");
    }


  }

  static update_favorite(Map<String, dynamic> _obj){

    var _myid = Member.myUid;
    var _con_friend = firebaseCon.firestore_.collection("Members/$_myid/Friends").doc(_obj["FriendID"]);
    _con_friend..update({
      "Favorite": _obj["favorite"]
    });
//  print("Members/$_doc_friend/Friends");
  }



  static create_room_chat(Map<String, dynamic> _myfriend) async{

    ChatRooms  _room = new ChatRooms.init();
    var date = new DateTime.now();

    var _frind = _myfriend["Info"];

    _room.FriendID = _myfriend["FriendID"];

    var __frindInfo = {
      "FullName" : _frind["FullName"],
      "Uid":_frind["Uid"],
      "ImgUrl":_frind["ImgUrl"],
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
      _frind["Uid"] : __frindInfo
    };
    _room.RoomType = "Friend";

    var _obj = _room.toJson();
    _obj["CreateDateTime"] = date;
    _obj["UpdateDateTime"] = date;

    // var _value = await ChatService.create_rooms(_obj);

    var _con_my = firebaseCon.firestore_.collection("Rooms");
    _obj['RoomID'] = _con_my.doc().id;
    var _e = await firebaseCon.firestore_.collection("Rooms").doc(_obj['RoomID']).set(_obj).then((_event){
      return _obj;
    });

    if(_e != null){
      return _e;
    }
    else{
      return null;
    }

  }



}