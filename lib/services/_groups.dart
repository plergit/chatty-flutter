import 'dart:io';

import 'package:chatty/model/chat.dart';
import 'package:chatty/model/friend.dart';
import 'package:chatty/model/member.dart';
import '_chat.dart';
import '_connect.dart';
import 'package:chatty/shared/files/uploads/_firestore.dart';

class FriendGroupService {

  static search_group(Map<String, dynamic> _obj) async {

    var _e;

      await firebaseCon.firestore_.collection("Members ")
          .where("Country" ,isEqualTo: _obj["country"])
          .where("MobilePhone" ,isEqualTo: _obj["number"])
          .get().then((querySnapshot) {
          querySnapshot.docs.forEach((result) {
          _e = result.data();
          //print(result.data);
        });
      });

    return _e;
  }



  static add_group(Map<String, dynamic> _obj) async {

    firestoreUploadFile _fileUpload = new firestoreUploadFile();
    ChatRooms  _room = new ChatRooms.init();
    var date = new DateTime.now();

    var _doc_my = Member.myUid;
    var _con_my = firebaseCon.firestore_.collection("Members/$_doc_my/Groups");
    _obj["GroupId"] = _con_my.doc().id;


    Map<String, dynamic> _objGroup = {};
      _objGroup["GroupId"] = _obj["GroupId"];
      _objGroup["Verify"] = 0;

    if(_obj["GroupImgUrl"] != null){

      var _uid = _obj["GroupId"];
      var _dri_img = "profile/$_uid";
      List<File> _list_img = [];
      _list_img.add(_obj["GroupImgUrl"]);
      var upCallback = await _fileUpload.uploadMultipleFiles(_dri_img, _uid, _list_img);
      _room.RoomImgUrl = upCallback["ImageUrl"];

    }

       Map<String, dynamic> _info = {};

      _obj["GroupListMember"].forEach((element) async {

        if(element["Uid"] == _doc_my){
          _objGroup["Verify"] = 1;
        }

        _objGroup["Uid"] = element["Uid"];

        //_room.MemberList.add(element["Uid"].toString());

        _info[element["Uid"].toString()] = element;

        // _info.putIfAbsent(element["Uid"].toString(), element);
        // print(element);

        var _doc_my_fri = element["Uid"];
        var _con_my_fri = firebaseCon.firestore_.collection("Members/$_doc_my_fri/Groups");
        await _con_my_fri.doc(_obj["GroupId"]).set(_objGroup);

      });

    _room.MemberInfo = _info;
    _room.RoomType = "Group";
    _room.FriendID = _obj["GroupId"];
    _room.RoomName = _obj["GroupName"];

    var obj_ = _room.toJson();
    obj_["CreateDateTime"] = date;
    obj_["UpdateDateTime"] = date;

    var _value = await ChatService.create_rooms(obj_);


    return _obj;
  }


}


