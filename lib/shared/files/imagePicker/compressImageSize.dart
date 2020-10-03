import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'dart:math' as Math;
//import 'package:image/image.dart' as Im;


import 'dart:io' as Io;
import 'package:image/image.dart';


class size_image{

  Future<Map<String, dynamic>> compressImage(File _file) async {

    final tempDir = await getTemporaryDirectory();
    final path = tempDir.path;

    var date = new DateTime.now();
    var file_name = date.millisecondsSinceEpoch.toString();

//    var image = Im.decodeImage(_file.readAsBytesSync());

    Image image = decodeImage(_file.readAsBytesSync());


    // Image xsImage = copyResize(image, width: 500);
    Image xmImage = copyResize(image, width: 1024);

    // var re_x1_img = new Io.File('$path/img-xs-$file_name.jpg')
    //   ..writeAsBytesSync(encodeJpg(xsImage, quality: 80));

    var re_x2_img = new Io.File('$path/img-xm-$file_name.jpg')
      ..writeAsBytesSync(encodeJpg(xmImage, quality: 100));


    final dirxs =  Directory(_file.path);
    dirxs.deleteSync(recursive: true);

    Map<String, dynamic> _arrFile = {
      "name" : "$file_name.jpg",
      // "x1" : re_x1_img,
      "x2" : re_x2_img,
    };
    return _arrFile;
  }


}