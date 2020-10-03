
import 'dart:io';

import 'package:chatty/model/member.dart';
import 'package:chatty/services/_auth.dart';
import 'package:chatty/shared/ModalBottomSheet.dart';
import 'package:chatty/shared/files/uploads/_firestore.dart';
import 'package:chatty/shared/widgets/mycircleavatar.dart';
import 'package:chatty/shared/widgets/popupLoading.dart';
import 'package:flutter/material.dart';

class SettingImageProfileWidget extends StatefulWidget {

  Map<String , dynamic> Obj;

  SettingImageProfileWidget({this.Obj});

  @override
  _SettingImageProfileState createState() => new _SettingImageProfileState();
}

class _SettingImageProfileState extends State<SettingImageProfileWidget> {

  @override
  void initState() {
    super.initState();
  }

  Member _member = new Member.init();


  @override
  Widget build(BuildContext context) {

    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;




    return Scaffold(
      backgroundColor: Colors.white.withOpacity(1.00),
      body: Container(
        child: Container(
//              height: 190.0,
            width: width,
            margin: const EdgeInsets.only(bottom: 0),
            decoration: new BoxDecoration(
//              color: Colors.black12.withOpacity(0.2),
              image: new DecorationImage(
                image: new AssetImage("assets/images/bg-profile.png"),
                fit: BoxFit.cover,
              ),
            ),
            child: Stack(
              children: <Widget>[

                widget.Obj["_type"] == "bg" ? Container(
                  alignment: Alignment.topCenter,
                  width: width,
                  decoration: new BoxDecoration(
                    color: Colors.black38.withOpacity(0.15),
                      image: new DecorationImage(
                        image: Image.file(widget.Obj["_file"] , fit: BoxFit.cover ).image,
                        fit: BoxFit.cover,
                      ),
                  ),
                ) : Member.photoBgUrl != null ? Container(
                  decoration: new BoxDecoration(
                    color: Colors.black38.withOpacity(0.15),
                    image: new DecorationImage(
                      image: NetworkImage(Member.photoBgUrl),
                      fit: BoxFit.cover,
                    ),
                  ),
                ) : Container() ,

                Positioned(
                  bottom: 0,
                  right: 0,
                  left: 0,
                  // height: 70,
                  child: Container(
                    decoration: BoxDecoration(
                      color:  Colors.transparent,
//                        shape: BoxShape.circle,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
//                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [


                        Container(
                          height: 0.0,
                          margin:
                          EdgeInsets.only(top: 0, bottom: 0, left: 0, right: 0),
                          decoration: BoxDecoration(
                            border: Border(
                              top: BorderSide(
                                color: Theme.of(context).primaryColor,
                                width: 0.6,
                              ),
                            ),
                          ),
                        ),

                        Container(
                          height: 100,
                          padding:
                          EdgeInsets.only(top: 20, bottom: MediaQuery.of(context).padding.bottom, left: 0, right: 0),
                          color: Colors.white,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [

                              Expanded(
                                child: InkWell(
                                  onTap:  ()  {
                                    delete_file(widget.Obj["_file"]);
                                    Navigator.pop(context, {"action": "close"});
                                  },
                                  child : Container(
                                    height: 50,
                                          child: Text(
                                    "ยกเลิก",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black54
                                    ),
                                  ),
                                )),
                              ),

                              Expanded(
                                child: InkWell(
                                    onTap:  ()  {
                                      _save_file();
                                    },
                                    child : Container(
                                            height: 50,
                                            child: Text(
                                                "บันทึก",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    fontSize: 17,
                                                    fontWeight: FontWeight.w600,
                                                    color: Colors.black54
                                                ),
                                              ),
                                )),
                              ),

                            ],

                          ),
                        )


                      ],
                    ),
                  ),
                ),

                Align(
                    alignment: Alignment.center,
                    child: Container(
                      height: 170,
                      child: Column(
                        children: <Widget>[
                          Container(
                            height: 130,
                            width: 130,
                            padding: const EdgeInsets.all(1.0),
                            decoration: BoxDecoration(
                              color: Theme.of(context)
                                  .primaryColor
                                  .withOpacity(1.0),
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                    color: Theme.of(context)
                                        .hintColor
                                        .withOpacity(0.10),
                                    offset: Offset(0, 2),
                                    blurRadius: 0)
                              ],
                            ),

                            child: widget.Obj["_type"] == "logo" ? Container(
                                width: 130,
                                height: 130,
                                decoration: new BoxDecoration(
                                  color: Colors.black38.withOpacity(0.15),
                                  shape: BoxShape.circle,
                                  image: new DecorationImage(
                                    image: Image.file(widget.Obj["_file"] , fit: BoxFit.cover ).image,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ) : MyCircleAvatar(
                              imgUrl: Member.photoUrl,
                              width: 130,
                              height: 130,
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 10, bottom: 0),
                            decoration: BoxDecoration(
                              color:  Colors.transparent,
//                                shape: BoxShape.circle,
                            ),
                            child: InkWell(
                              onTap:  ()  {

                              },
                              child : Text(
                                Member.myName,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black54
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                ),

                Container(
                    height: (50+MediaQuery.of(context).padding.top),
                    padding: EdgeInsets.only(left: 0 ,right: 0, top : MediaQuery.of(context).padding.top, bottom: 0),
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(0),
                          bottomRight: Radius.circular(0)),
                    ),
                    child: Wrap(
                        direction: Axis.horizontal,
                        children: <Widget>[
                          Container(
                            height: 45,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Container(
                                  margin: const EdgeInsets.only(left: 10,top: 10),
                                  child: Container(
                                    height: 50.0,
                                    width: 50.0,
                                    child: IconButton(
                                      alignment: Alignment.center,
                                      icon: Icon(
                                        Icons.clear,
                                        color: Colors.black54,
                                        size: 30,
                                      ),
                                      onPressed: () => {
                                        delete_file(widget.Obj["_file"]),
                                        Navigator.pop(context, {"action": "close"}),
                                      },
                                    ),
                                  ),
                                ),

                              ],
                            ),
                          ),
                        ])
                ),

              ],
            )
        ),
      ),
    );
  }

  firestoreUploadFile _fileUpload = new firestoreUploadFile();

  // ignore: non_constant_identifier_names
  void _save_file() async {

    _onLoading();

    var _uid = Member.myUid;
    var _dri_img = "profile/$_uid";
    List<File> _list_img = [];

    _list_img.add(widget.Obj["_file"]);
    var upCallback = await _fileUpload.uploadMultipleFiles(_dri_img, _uid, _list_img);
    //print(upCallback);


    if(widget.Obj["_type"] == "logo"){


      if(Member.photoUrl != null){
        await firestoreUploadFile.delete_file(Member.photoUrl);
      }

      await AuthService().updatePerson(upCallback["ImageUrl"]);

      Navigator.pop(context);
      Navigator.pop(context);
    }
    else if(widget.Obj["_type"] == "bg"){

      if(Member.photoBgUrl != null){
        await firestoreUploadFile.delete_file(Member.photoBgUrl);
      }

      await AuthService().updateBgProfile(upCallback["ImageUrl"]);

      Navigator.pop(context);
      Navigator.pop(context);
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

      Navigator.pop(context);


      print(val);

    });
    ;
  }

  void _modalAlertError(context, String title, String description)  {
    showModalBottomSheet(
        context: context,
        isDismissible: false,
        elevation: 0,
        useRootNavigator: false,
        backgroundColor: Colors.transparent,
        builder: (BuildContext bc) {
          return modalBottomCostom(
            typeModel: "error",
            context: context,
            title: title,
            description: description,
            iconIn: Icons.error,
            colorIcon: Colors.red,
          );
        }).then((val) {
//        return val;
    });
  }

  delete_file(File file_){


    try {
      final dirxs =  Directory(file_.path);
      dirxs.deleteSync(recursive: true);
    } on Exception catch (_) {
      print('never reached');
    }


  }

}


