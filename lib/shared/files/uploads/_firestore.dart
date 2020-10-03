
import 'dart:async';
import 'dart:io';
import 'package:chatty/shared/files/imagePicker/compressImageSize.dart';
import 'package:chatty/shared/files/imagePicker/imagePicker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';
import 'package:path/path.dart' as Path;


class firestoreUploadFile  {


  Future<Map<String, dynamic>> uploadMultipleFiles(String dir,String refID ,List<dynamic> _fileList) async {

    Map<String, dynamic> _fileUrls ;

    try {

      int nUpload = 0;

      String ImageUrl;

      for (int i = 0; i < _fileList.length; i++) {

        File file_select = _fileList[i];

        Map<String, dynamic> file_ = await size_image().compressImage(file_select);

        var uuid = Uuid().v4();
        String id = uuid.toString();

        var _main = "images";

        var _nam = file_["name"];
        var file_sx = "img-sx_$_nam";
        var file_sm = "img-sm_$_nam";
        var _dir = "$_main/$dir";

        File fileX1 = file_["x1"];
        File fileX2 = file_["x2"];


        final StorageReference _storage_file_sx = FirebaseStorage().ref().child(_dir+"/$file_sx");
        final StorageReference _storage_file_sm = FirebaseStorage().ref().child(_dir+"/$file_sm");

        final StorageUploadTask uploadTaskX1 = _storage_file_sx.putFile(fileX1);
        final StorageUploadTask uploadTaskX2 = _storage_file_sm.putFile(fileX2);
//
        final StreamSubscription<StorageTaskEvent> streamSubscriptionX1 =
        uploadTaskX1.events.listen((event) {
          print('EVENT ${event.type}');
        });
        await uploadTaskX1.onComplete;
        streamSubscriptionX1.cancel();


        final StreamSubscription<StorageTaskEvent> streamSubscriptionX2 =
        uploadTaskX2.events.listen((event) {
          print('EVENT ${event.type}');
        });
        await uploadTaskX2.onComplete;
        streamSubscriptionX2.cancel();

        ImageUrl = await _storage_file_sm.getDownloadURL();

        DeleteFileLocal.delete_file(file_);

        var l = i + 1;
        nUpload = l;
      }

      _fileUrls = {
        "State" : "Complete",
        "ImageUrl" : ImageUrl,
        "Total" : _fileList.length.toString(),
        "Complete" : nUpload.toString()
      };

    } catch (e) {
      print(e);
    }

    return _fileUrls;

  }






  static Future<void> delete_file(String imageFileUrl) async {

    var fileUrl = Uri.decodeFull(Path.basename(imageFileUrl)).replaceAll(new RegExp(r'(\?alt).*'), '');
    File file = new File(fileUrl);
    String _directory = file.parent.path;
    String _fname = Path.basename(file.path);
    var arr = _fname.split('_');
    var _f_name = arr[1];
    var _fx = "$_directory/img-sx_$_f_name";
    var _fm = "$_directory/img-sm_$_f_name";

    final StorageReference firebaseStorageRef1 = FirebaseStorage.instance.ref().child(_fx);
    await firebaseStorageRef1.delete();

    final StorageReference firebaseStorageRef2 = FirebaseStorage.instance.ref().child(_fm);
    await firebaseStorageRef2.delete();


  }





}




