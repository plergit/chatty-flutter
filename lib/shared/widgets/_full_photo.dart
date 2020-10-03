
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import '../../config/app_config.dart' as config;



class FullPhotoScreen extends StatefulWidget {

  final String url;

  FullPhotoScreen({Key key, @required this.url}) : super(key: key);


  @override
  _PhotoScreenState createState() => _PhotoScreenState();
}

class _PhotoScreenState extends State<FullPhotoScreen> {




  @override
  void initState() {


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



}
