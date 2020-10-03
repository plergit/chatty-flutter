
import 'dart:io';
import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:chatty/shared/ModalBottomSheet.dart';
import 'package:chatty/shared/widgets/popupLoading.dart';
import 'package:dio/dio.dart';
import 'package:file_utils/file_utils.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:photo_view/photo_view.dart';
import '../config/app_config.dart' as config;
import 'package:path/path.dart' as Path;



class FullPhotoInRoomScreen extends StatefulWidget {

  final String url;

  FullPhotoInRoomScreen({Key key, @required this.url}) : super(key: key);


  @override
  _PhotoScreenState createState() => _PhotoScreenState();
}

class _PhotoScreenState extends State<FullPhotoInRoomScreen> {


  var imgUrl ;
  bool downloading = false;
  var progress = "";
  var path = "No Data";
  var platformVersion = "Unknown";
  // Permission permission1 = Permission.WriteExternalStorage;
  var _onPressed;
  static final Random random = Random();
  Directory externalDir;



  @override
  void initState() {

    imgUrl = widget.url;


    super.initState();
  }




  @override
  Widget build(BuildContext context) {

    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

//    print(widget.objInfo);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(55.0),
          child: AppBar(
            elevation: 0,
            backgroundColor: Theme.of(context).primaryColor,
            automaticallyImplyLeading: false, // hides leading widget
            flexibleSpace: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
//                    color: Colors.green,
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.black38,
                      width: 0.5,
                    ),
                  ),
                ),
                padding: EdgeInsets.only(
                    left: 0,
                    right: 0,
                    top: MediaQuery.of(context).padding.top,
                    bottom: 0
                ),
                width: MediaQuery.of(context).size.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      height: 45,
                      width: double.infinity,
                      child: Stack(children: <Widget>[
                        Align(
                          alignment: Alignment.centerLeft,

                        ),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Container(
                            height: 50.0,
                            width: 50.0,
                            child: IconButton(
                              alignment: Alignment.center,
                              icon: new ImageIcon(
                                AssetImage(
                                    "assets/images/icons/icon-close.png"
                                ),
                                size: 18,
                                color: Colors.black,
                              ),
                              onPressed: () => {
                                Navigator.pop(context, {"action": "close"}),
                              },
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Container(
                            margin: const EdgeInsets.only(right: 8,top: 5),
                            child: IconButton(
                              padding: EdgeInsets.only(left: 10,right: 5),
                              onPressed:  ()  {

                                downloadFile();
                                // Navigator.of(context)
                                //     .pushNamed('/add_friend', arguments: 1);
                              },
                              icon: Icon(
                                Icons.file_download,
                                color: Colors.blueGrey,
                                size: 23,
                              ),
                            ),
                          ),
                        ),
                      ]),
                    ),
                  ],
                )),
          )),
      body: PhotoView(
          imageProvider: CachedNetworkImageProvider(widget.url)
      ),
    );
  }



  Future<void> downloadFile() async {
    Dio dio = Dio();
    bool checkPermission1 = false;

    var status = await Permission.storage.status;
    if (!status.isGranted) {
      await Permission.storage.request();
    }


    checkPermission1 = status.isGranted;


    if (checkPermission1 == true) {

      _onLoading();

      String dirloc = "";
      if (Platform.isAndroid) {
        dirloc = "/sdcard/download/";
      } else {
        dirloc = (await getApplicationDocumentsDirectory()).path;
      }

      var randid = random.nextInt(10000);

      var fileUrl = Uri.decodeFull(Path.basename(imgUrl)).replaceAll(new RegExp(r'(\?alt).*'), '');

      File file = new File(fileUrl);
      String _directory = file.parent.path;
      String _fname = Path.basename(file.path);
      var arr = _fname.split('_');

      print(_fname);

      try {
        FileUtils.mkdir([dirloc]);
        await dio.download(imgUrl, dirloc + _fname.toString() + ".jpg",
            onReceiveProgress: (receivedBytes, totalBytes) {
              setState(() {
                downloading = true;
                progress =
                    ((receivedBytes / totalBytes) * 100).toStringAsFixed(0) + "%";
              });
            });
      } catch (e) {
        print(e);
      }

      Navigator.pop(context);

      _modalAlertSuccess(context, "Successful", "Download Completed.");

      // setState(() {
      //   downloading = false;
      //   progress = "Download Completed.";
      //   path = dirloc + randid.toString() + ".jpg";
      // });
    } else {
      // setState(() {
      //   progress = "Permission Denied!";
        // _onPressed = () {
        //   downloadFile();
        // };
      // });
    }
  }

  void _onLoading() {

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => PopupLoading(),
    );

  }


  void _modalAlertSuccess(context, String title, String description) {

    showModalBottomSheet(
        context: context,
        isDismissible: false,
        elevation: 0,
        useRootNavigator: false,
        backgroundColor: Colors.transparent,
        builder: (BuildContext bc) {
          return modalBottomCostom(
            typeModel: "success",
            context: context,
            title: title,
            description: description,
            iconIn: Icons.check_circle,
            colorIcon: Colors.green,
          );
        }).then((val) {

      //      Navigator.pop(context);

      Navigator.pop(context);

      print(val);

    });
    ;
  }





}
