import 'package:chatty/account/auth/_signin.dart';
import 'package:chatty/model/member.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import '_connect.dart';

class AuthService {


  Member _userFromFirebaseUser(User user) {
    return user != null ? Member(Uid: user.uid) : null;
  }

  Future loadUserInfo(User user) async {

    try {

      var _e = await firebaseCon.firestore_.collection("Members").doc(user.uid).get();
      var _data = _e.data();

      var _phone = "";

      if(_data["MobilePhone"] != null){

        var newPhone = _data["MobilePhone"].substring(_data["MobilePhone"].length - 4);
        var viewPhone = newPhone.toString().padLeft(10, 'x');
        _phone = "${_data["Country"]} ${viewPhone}";

      }

      // print(newPhone.toString().padLeft(10, 'X'));

      Member.myUid = _data["Uid"];
      Member.myMemberID = _data["MemberID"];
      Member.myName = _data["FullName"];
      Member.myEmail = _data["Email"];
      Member.myMobilePhone = _phone;
      Member.photoUrl = _data["ImgUrl"];
      Member.photoBgUrl = _data["ImgBgUrl"];
      Member.StatusProfile = _data["StatusProfile"] != null ? _data["StatusProfile"] : null;
      Member.dateOfBirth = _data["DateOfBirth"] != null ? _data["DateOfBirth"].toDate() : null;



    } catch (e) {
      print(e.toString());
    }



  }

  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      var result = await firebaseCon.auth_.signInWithEmailAndPassword(
          email: email, password: password);
      User user = result.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future signUpWithEmailAndPassword(String email, String password) async {
    try {
      var result = await firebaseCon.auth_.createUserWithEmailAndPassword(
          email: email, password: password);
      User user = result.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future resetPass(String email) async {
    try {
      return await firebaseCon.auth_.sendPasswordResetEmail(email: email);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future registerInApp(Map<String, dynamic> _member) async {

    var _uid = _member["Uid"];
    var _e = await firebaseCon.firestore_.collection("Members").where("Uid" ,isEqualTo: _uid).get();

    if(_e.docs.length == 0){
      var _s = await firebaseCon.firestore_.collection("Members").doc(_uid).set(_member);
      return "ok";
    }
    else{
      return "ok";
    }



  }

  Future registerUser(Map<String, dynamic> _member) async {
    var _uid = _member["Uid"];
    var _e = await firebaseCon.firestore_.collection("Members").doc(_uid).set(_member).then((_){
      return "success!";
    });
    return _e;
  }

  Future updateName(String name) async{

    try {
      User userInfo = firebaseCon.auth_.currentUser;

      userInfo.updateProfile(displayName:name);
      await userInfo.reload();

      Member.myName = name;
      var _doc =  firebaseCon.firestore_.collection("Members").doc(Member.myUid);
      await _doc.update({"FullName":name});
      return "ok";

    }
    catch (e)
    {
      return null;
    }

  }

  Future updateStatus(String name) async{

    try {

      Member.StatusProfile = name;
      var _doc = firebaseCon.firestore_.collection("Members").doc(Member.myUid);
      await _doc.update({"StatusProfile":name});

      return "ok";
    }
    catch (e)
    {
      return null;
    }

  }

  Future updatePerson(String imageUrl) async{

    try {
      User userInfo = firebaseCon.auth_.currentUser;

      Member.photoUrl = imageUrl;

      userInfo.updateProfile(photoURL: imageUrl);
      await userInfo.reload();


      var _doc_m = firebaseCon.firestore_.collection("Members").doc(Member.myUid);
      await _doc_m.update({"ImgUrl":imageUrl});


      var _fil_key = "MemberInfo.${Member.myUid}.Uid";

      var _doc_f = await firebaseCon.firestore_.collection("Rooms").where(_fil_key ,isEqualTo : Member.myUid).get();

      var _fil_up = "MemberInfo.${Member.myUid}.ImgUrl";

      for(var _arr in _doc_f.docs){
        var _roomid = _arr.id;
        var _doc_f_up = firebaseCon.firestore_.collection("Rooms").doc(_roomid);
        await _doc_f_up.update({_fil_up:imageUrl});
      }

      return "ok";

    } catch (e) {
      print(e);
      return null;
    }

  }

  Future updateBgProfile(String imageUrl) async{

    try {
      var _doc =  firebaseCon.firestore_.collection("Members").doc(Member.myUid);
      await _doc.update({"ImgBgUrl":imageUrl});
      Member.photoBgUrl = imageUrl;
      return "ok";
    } catch (e) {
      return null;
    }

  }

  Future updateBirthday(DateTime _date) async{

    try {

      Member.dateOfBirth = _date;
      var _doc = firebaseCon.firestore_.collection("Members").doc(Member.myUid);
      await _doc.update({"DateOfBirth":_date});
      return "ok";
    }
    catch (e)
    {
      return null;
    }

  }

  Future updateId(String _id) async{
    try {


      var _e = await firebaseCon.firestore_.collection("Members").where("MemberID" ,isEqualTo: _id).get();

      if(_e.docs.length == 0){

        var _doc =  firebaseCon.firestore_.collection("Members").doc(Member.myUid);
        await _doc.update({"MemberID":_id});
        Member.myMemberID = _id;
        return "ok";
      }
      else{
        return "repeatedly";
      }


    } catch (e) {
      return null;
    }

  }

  Future updateEmail(String _email) async{
    try {




      var _e = await firebaseCon.firestore_.collection("Members").where("Email" ,isEqualTo: _email).get();

      if(_e.docs.length == 0){

        var _doc =  firebaseCon.firestore_.collection("Members").doc(Member.myUid);
        await _doc.update({"Email":_email});
        User userInfo = firebaseCon.auth_.currentUser;
        userInfo.updateEmail(_email);
        await userInfo.reload();
        Member.myEmail = _email;
        return "ok";

      }
      else{
        return "repeatedly";
      }



    } catch (e) {
      return null;
    }

  }


  Future updatePhone(String _dialCode,String _phone) async{
    try {


      // verification_phone("$_dialCode$_phone");

      // var _doc =  firebaseCon.firestore_.collection("Members").doc(Member.myUid);
      // await _doc.update({
      //   "MobilePhone":_phone,
      //   "Country":_dialCode
      // });

      User userInfo = firebaseCon.auth_.currentUser;
      // userInfo.updatePhoneNumber(phoneCredential);
      // await userInfo.reload();
      // Member.myEmail = _phone;

      return "ok";
    } catch (e) {
      return null;
    }

  }

  Future verification_phone(String phoneNumber) async {

    // User userInfo = firebaseCon.auth_.currentUser;

    // print(phoneNumber);

    await firebaseCon.auth_.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      timeout: const Duration(seconds: 5),
      verificationFailed: (FirebaseAuthException e) {
        if (e.code == 'invalid-phone-number') {
          print('The provided phone number is not valid.');
        }
        return null;
        // Handle other errors
      }, verificationCompleted: (PhoneAuthCredential phoneAuthCredential) {

        // print("dddd1 $phoneAuthCredential");
        return null;
     }, codeAutoRetrievalTimeout: (String verificationId) {

       // print("dddd2 $verificationId");
       return null;
     }, codeSent: (String verificationId, int forceResendingToken) {

       // print("dddd3 $verificationId --- $forceResendingToken");

       //await userInfo.updatePhoneNumber(verificationId);
       return verificationId;
     },

    );


    // firebaseCon.auth_.verifyPhoneNumber(
    //     phoneNumber: phoneNumber,
    //     timeout: const Duration(minutes: 2),
    //     verificationCompleted: (credential) async
    //     {
    //       print(credential);
    //       await userInfo.updatePhoneNumber(credential);
    //       // either this occurs or the user needs to manually enter the SMS code
    //     },
    //     verificationFailed: null,
    //     codeSent: (verificationId, [forceResendingToken]) async {
    //
    //       print(forceResendingToken);
    //
    //       String smsCode;
    //       // get the SMS code from the user somehow (probably using a text field)
    //       final AuthCredential credential = PhoneAuthProvider.getCredential(verificationId: verificationId, smsCode: smsCode);
    //       await (userInfo).updatePhoneNumber(credential);
    //     },
    //     codeAutoRetrievalTimeout: null
    // );

  }

  Future member_online() async {

    String _uid = Member.myUid;

    firebaseCon.counterRef_.reference().child('Members').once().then((DataSnapshot snapshot) {
      firebaseCon.counterRef_.reference().child("Members/${_uid}").onDisconnect().update({"online":false}).then((_) {

        firebaseCon.firestore_.collection('Members')
            .doc(Member.myUid)
            .update({
          "online": true ,
        });
        firebaseCon.counterRef_.reference().child("Members/${_uid}").update({"online":true});

      });

    });

  }


  // @override
  // Future resetPassword(String email) async {
  //
  //  try {
  //    return await firebaseCon.auth_.sendPasswordResetEmail(email: email);
  //  } catch (e) {
  //    // print(e.toString());
  //    return e.toString();
  //  }
  //
  // }

  Future resetPassword(String email) async {
    return firebaseCon.auth_.sendPasswordResetEmail(email: email);
  }

  Future signOut() async {
    try {
      return await firebaseCon.auth_.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

}


