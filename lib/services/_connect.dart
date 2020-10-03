

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';




class firebaseCon{

 static const kGoogleApiKey = "AIzaSyA_-5IFdFyzMXbxClKz6F2uHRJbdDLoXBg";

 static FirebaseAuth auth_ = FirebaseAuth.instance;
 static FirebaseFirestore firestore_ = FirebaseFirestore.instance;
 static FirebaseDatabase counterRef_ = FirebaseDatabase.instance;

}

