import 'package:chatty/model/member.dart';
import 'package:chatty/shared/widgets/mycircleavatar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../config/app_config.dart' as config;



class homeProfileWidget extends StatefulWidget {
  @override
  _HomeProfileState createState() => _HomeProfileState();
}

class _HomeProfileState extends State<homeProfileWidget>  {

  @override
  initState() {
    super.initState();


  }


  @override
  void dispose() {
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;


    return Scaffold(

        body: new GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(new FocusNode());
          },
          child: Stack(
            children: [

              Positioned(
                   bottom:0,
                   right: 0,
                   top: 0,
                   left: 0,
                   child: Member.photoBgUrl != null ? Container(
                     alignment: Alignment.topCenter,
                     height: 150.0,
                     width: width,
                     decoration: new BoxDecoration(
                       color: Colors.black38.withOpacity(0.15),
                       image: new DecorationImage(
                         image: NetworkImage(Member.photoBgUrl),
                         fit: BoxFit.cover,
                       ),
                     ),
                   ) : Container(
                     alignment: Alignment.topCenter,
                     height: 150.0,
                     width: width,
                     decoration: new BoxDecoration(
                       image: new DecorationImage(
                         image: new AssetImage("assets/images/bg-profile.png"),
                         fit: BoxFit.cover,
                       ),
                     ),
                   ),
                ),

              Positioned(
                bottom:60,
                right: 0,
                top: 0,
                left: 0,
                child: Container(
                  alignment: Alignment.topCenter,
                  decoration: new BoxDecoration(
                    color: Colors.black12.withOpacity(0.4),
                  ),
                ),
              ),

              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Container(
                    padding: EdgeInsets.only(
                        left: 4,
                        right: 5,
                        top: MediaQuery.of(context).padding.top,
                        bottom: 0),
                    width: MediaQuery.of(context).size.width,
                    child: Wrap(direction: Axis.horizontal, children: <Widget>[
                      Container(
                        height: 45,
                        width: double.infinity,
                        child: Stack(children: <Widget>[
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                                margin : EdgeInsets.only(left: 50,right: 0),
                                child: Text(
                                  "โปรไฟล์",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w600,
                                      color: Theme.of(context).primaryColor),
                                )
                            ),
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
                                      "assets/images/icons/icon-back.png"),
                                  size: 20,
                                  color: Theme.of(context).primaryColor,
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
                    ])
                ),
              ),

              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  height: 450,
                  padding: const EdgeInsets.only(top: 0,bottom: 0),
                  color: Colors.transparent,
                  child: Stack(
                    children: [

                      Positioned(
                        top: 60,
                        left: 0,
                        right: 0,
                        bottom: 0,
                        child: Container(
                          height: 350,
                          color: Colors.white,
                          child: Column(
                            children: [
                              SizedBox(
                                height: 50,
                              ),
                              Expanded(

//                      height: 100,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [

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
                                              fontWeight: FontWeight.w700,
                                              color: Colors.black54
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(top: 10, bottom: 0),
                                      decoration: BoxDecoration(
                                        color:  Colors.transparent,
//                                shape: BoxShape.circle,
                                      ),
                                      child: Text(
                                        Member.myMemberID == null ? "-": Member.myMemberID,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.black54
                                        ),
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(top: 10, bottom: 0),
                                      decoration: BoxDecoration(
                                        color:  Colors.transparent,
//                                shape: BoxShape.circle,
                                      ),
                                      child:  Text(
                                        Member.StatusProfile == null ? "" : Member.StatusProfile.toString(),
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.black54
                                        ),
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(top: 10, bottom: 0),
                                      decoration: BoxDecoration(
                                        color:  Colors.transparent,
//                                shape: BoxShape.circle,
                                      ),
                                      child: InkWell(
                                          child: Container(
                                              width: (width-100),
                                              child: Text(
                                                  "แก้ไขโปรไฟล์",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    fontSize: 18,
                                                    color: config.HexColor("#60B7B5"),
                                                    fontWeight: FontWeight.w600,
                                                  )
                                              ),
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(16),
                                                color: config.HexColor("#F1F1F1"),
                                              ),
                                              margin: EdgeInsets.only(top: 0),
                                              padding: EdgeInsets.all(12)
                                          ),
                                          onTap: () {

                                            Navigator.of(context).pushNamed('/profile', arguments: 1);

                                          }),
                                    ),

                                  ],
                                ),
                              ),
                              Container(
                                height: 1.0,
                                margin:
                                EdgeInsets.only(top: 20, bottom: 4, left: 8, right: 8),
                                decoration: BoxDecoration(
                                  border: Border(
                                    top: BorderSide(
                                      color: Theme.of(context).focusColor,
                                      width: 0.6,
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                height: 80,
                                color: Colors.white,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [

                                    Expanded(
                                      child: Container(
                                        child: Text(
                                          "โมเมนต์",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black54
                                          ),
                                        ),
                                      ),
                                    ),

                                    Expanded(
                                      child: Container(
                                        child: Text(
                                          "รูป & วีดีโอ",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black54
                                          ),
                                        ),
                                      ),
                                    ),

                                  ],

                                ),
                              )
                            ],
                          ),
                        )
                      ),

                      Align(
                          alignment: Alignment.topCenter,
                          child: Container(
                            height: 120,
                            child: Container(
                                height: 120,
                                width: 120,
                                padding: const EdgeInsets.all(4.0),
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
                                        blurRadius: 4)
                                  ],
                                ),

                                child: Stack(
                                  children: <Widget>[
                                    MyCircleAvatar(
                                      imgUrl: Member.photoUrl,
                                      width: 120,
                                      height: 120,
                                    ),
                                    Positioned(
                                      bottom : 1,
                                      right: 0,
                                      left: 0,
                                      height: 55,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color:  Colors.black38,
                                          borderRadius: BorderRadius.only(
                                              bottomRight: Radius.circular(60), bottomLeft: Radius.circular(60)
                                          ),
                                        ),
                                        child: IconButton(
                                          padding: EdgeInsets.only(left: 5,right: 5,top: 5,bottom: 5),
                                          onPressed:  ()  {
//                                        Navigator.of(context).pushNamed('/add_friend', arguments: 1);
                                          },
                                          icon: Icon(
                                            Icons.camera_alt,
                                            color: Theme.of(context).primaryColor,
                                            size: 20,
                                          ),
                                        ),
                                      ),
                                    )

                                  ],
                                )
                            ),
                          )
                      ),

                    ],
                  )
                ),
              )

            ],
          ),
        )
    );
  }


}


