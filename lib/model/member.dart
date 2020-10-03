import 'package:flutter/material.dart';


class Member {

  String id = UniqueKey().toString();
  String MemberID = null;
  String Uid = null;
  String FullName = null;
  String Username = null;
  String Password = null;
  String Email = null;
  String MobilePhone = null;
  String Country = null;
  String Gender = null;
  DateTime DateOfBirth = null;
  String State = null;
  DateTime CreateDatetime = null;
  DateTime UpdateDatetime =  null;
  Map<String, dynamic> Verify = { "Email": null ,"MobilePhone": null};
  String ImgUrl = null;
  String ImgBgUrl = null;

  Member.init();
  Member({this.Uid});


  Map<String, dynamic> toJson() =>
      {
        'MemberID': MemberID,
        'Uid': Uid,
        'FullName': FullName,
        'Username': Username,
        'Password': Password,
        'Email': Email,
        'MobilePhone': MobilePhone,
        'Country': Country,
        'Gender': Gender,
        'DateOfBirth': DateOfBirth,
        'State': State,
        'CreateDateTime': CreateDatetime,
        'UpdateDateTime': UpdateDatetime,
        'Verify': Verify ,
        'ImgUrl': ImgUrl,
        'ImgBgUrl': ImgBgUrl,
      };


  static String myUid = "";
  static String myMemberID = "";
  static String myName = "";
  static String myEmail = "";
  static String myMobilePhone = "";
  static String photoUrl = "";
  static String photoBgUrl = "";
  static String StatusProfile = "";
  static DateTime dateOfBirth ;



}
