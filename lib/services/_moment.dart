import 'package:chatty/model/friend.dart';
import 'package:chatty/model/member.dart';
import '_connect.dart';

class MommentService {

  static load_moments() async {

    List<Map<String, dynamic>> _e = [];
    await firebaseCon.firestore_.collection("Moments").get().then((querySnapshot) {
      querySnapshot.docs.forEach((result) {
        _e.add(result.data());
      });
    });
    return _e;
  }



}