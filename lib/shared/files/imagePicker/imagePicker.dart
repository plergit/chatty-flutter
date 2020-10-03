import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:async';





class ImagePickerWidget extends StatelessWidget {

  BuildContext context;

  Future<File> _futureImage;
  //File _imageFile;
  File _imageFile;

  final _picker = ImagePicker();

  ImagePickerWidget
      ({
        this.context,
      });

  @override
  Widget build(BuildContext context) {
    return modalBottomPopup();
  }


  Widget modalBottomPopup() {

    return Container(
      child: new Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        children: <Widget>[

          Container(
            margin: const EdgeInsets.only(
              top: 20,
            ),
            padding: const EdgeInsets.only(top: 5, left: 10, right: 10),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor.withOpacity(1.0),
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20)
              ),
            ),

              child: Wrap(
                children: <Widget>[

                  Container(
                    height: 45,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              SizedBox(width: 5),
                              Icon(
                                Icons.image,
                                color: Colors.blueGrey,
                                size: 18,
                              ),
                              SizedBox(width: 5),
                              Text("เลือกรูป",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                  )),
                            ],
                          ),
                        ),


                        Container(
                          margin: const EdgeInsets.only(bottom: 3, top: 6),
                          child: InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Container(
                              height: 30,
                              width: 30,
//                                                  padding: const EdgeInsets.all(1.0),
                              decoration: BoxDecoration(
//                                color: Colors.red,
//                                borderRadius: BorderRadius.only(topLeft: Radius.circular(0),topRight: Radius.circular(0),
//                                    bottomLeft:  Radius.circular(10),bottomRight:  Radius.circular(0)),
//                                  shape: BoxShape.circle,
                              ),
                              child:  Align(
                                alignment: Alignment.center,
                                child: Icon(
                                  Icons.close,
                                  color: Colors.deepOrange,
                                  size: 27,
                                ),
                              ),
                            ),

                          ),
                        ),


                      ],
                    ),
                  ),

                  Container(
                    height: 2.0,
                    margin: EdgeInsets.only(top: 4, bottom: 2, left: 8, right: 8),
                    decoration: BoxDecoration(
                      border: Border(
                        top: BorderSide(
                          color: Theme.of(context).focusColor,
                          width: 0.5,
                        ),
                      ),
                    ),
                  ),

                  Container(
                    margin:
                    EdgeInsets.only(left: 20, right: 20, top: 10, bottom: (MediaQuery.of(context).padding.bottom + 30) ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        InkWell(
                          onTap: () async => await _pickImage(ImageSource.camera),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[

                              Container(
                                width: 90,
                                height: 70,
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: Theme.of(context).focusColor.withOpacity(0.2),
//                                  shape: BoxShape.circle,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Icon(
                                    Icons.camera,
                                    size: 40,
                                    color: Theme.of(context).focusColor
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                "กล้องถ่ายรูป",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Theme.of(context)
                                        .hintColor
                                        .withOpacity(0.8),
                                    fontSize: 14),
                              )
                            ],
                          ),
                        ),

                        InkWell(
                          onTap: () async => await _pickImage(ImageSource.gallery),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              Container(
                                width: 90,
                                height: 70,
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: Theme.of(context).focusColor.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(20),
//                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                    Icons.folder_open,
                                    size: 40,
                                    color: Theme.of(context).focusColor
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                "อัลบั้มรูป",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Theme.of(context)
                                        .hintColor
                                        .withOpacity(0.8),
                                    fontSize: 14),
                              )
                            ],
                          ),
                        ),

//                    SizedBox(height : 8),
                      ],
                    ),
                  ),

                ],
              )
          )

        ],
      ),
    );
  }


  Future<void> _pickImage(ImageSource source) async {


    try {
      final pickedFile = await _picker.getImage(
        source: source,
        maxWidth: 1024,
        maxHeight: 720,
        imageQuality: 100,
      );

      File tmpFile = File(pickedFile.path);

      pushViewImage(tmpFile);

    } catch (e) {
      print(e);
    }

    // setState(() {
    //   _imageFile = pickedFile;
    // });


  }


  // Future<void> _pickImage(ImageSource source) async {
  //
  //   File selected = await ImagePicker.pickImage(source: source);
  //   if (selected != null) {
  //     _imageFile = selected;
  //     pushViewImage(selected);
  //   }
  //
  // }

  void pushViewImage(File file) async {


//    _onLoading();
//    Future.delayed(const Duration(milliseconds: 500), () {
//      compressImage(file.path).then((value) {
//        Navigator.pop(context);
        Navigator.pop(context , file);
//      });
//    });

  }

  void _onLoading() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          child: Container(
            width: 50,
            height: 50,
            child: CircularProgressIndicator(),
          )
        );
      },
    );
  }




}


 class DeleteFileLocal{

   static delete_file(Map<String, dynamic> file_){


     try {

       final dirxs =  Directory(file_["x1"].path);
       dirxs.deleteSync(recursive: true);

       final dirxm = Directory(file_["x2"].path);
       dirxm.deleteSync(recursive: true);

     } on Exception catch (_) {
       print('never reached');
     }

  }

}
