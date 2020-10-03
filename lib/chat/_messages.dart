import 'dart:io';
import 'package:chatty/model/member.dart';
import 'package:chatty/shared/widgets/mycircleavatar.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_player/video_player.dart';
import '../config/app_config.dart' as config;
import '_full_photo_in_room.dart';
import 'package:path/path.dart' as path;

class MessagesWidget extends StatelessWidget {

  Map<String, dynamic> conversation;

  MessagesWidget({this.conversation});

  @override
  Widget build(BuildContext context) {

    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    // print(conversation["Read"]);


    return new Container(
      child: conversation != null ?
      conversation['Uid'] != Member.myUid ?
      getReceivedMessage(context) : getSentMessage(context) : Container(),
    );
  }




  Widget getSentMessage(context) {

    var date = conversation["CreateDatetime"].toDate();
    String time = "${date.hour}:${date.minute}";

    if(conversation["Messagetype"] == null || conversation["Messagetype"] == 0){
      return Align(
          alignment: Alignment.centerRight,
          child: _message_text(context , conversation)
      );
    }
    else if(conversation["Messagetype"] == 2){
      return Align(
          alignment: Alignment.centerRight,
          child: _message_stick(conversation),
        );
    }
    else if(conversation["Messagetype"] == 1) {

      return Container(
        padding: EdgeInsets.only(top: 0,left: 100,right: 0,bottom: 0),
        child: _message_img_video(conversation),
      );

     }
    else if(conversation["Messagetype"] == 4){

      return Container(
        margin: EdgeInsets.only(top: 10,left: 150,right: 0,bottom: 0),
        padding: EdgeInsets.only(top: 8,left: 8,right: 8,bottom: 8),
        decoration: BoxDecoration(
          // color: config.HexColor("#79b5b5"),
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(10),
            bottomRight: Radius.circular(10),
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          ),
        ),
        alignment: Alignment.centerRight,
        child: _message_contact(context , conversation),
      );
    }
    else if(conversation["Messagetype"] == 3){

      return Container(
        margin: EdgeInsets.only(top: 10,left: 150,right: 0,bottom: 0),
        // padding: EdgeInsets.only(top: 8,left: 8,right: 8,bottom: 8),
        // decoration: BoxDecoration(
        //   // color: config.HexColor("#79b5b5"),
        //   borderRadius: BorderRadius.only(
        //     bottomLeft: Radius.circular(0),
        //     bottomRight: Radius.circular(0),
        //     topLeft: Radius.circular(0),
        //     topRight: Radius.circular(0),
        //   ),
        // ),
        alignment: Alignment.centerRight,
        child: _message_file(context , conversation),
      );
    }
    else if(conversation["Messagetype"] == 5){

      return Container(
        margin: EdgeInsets.only(top: 10,left: 150,right: 0,bottom: 0),
        padding: EdgeInsets.only(top: 8,left: 8,right: 8,bottom: 8),
        decoration: BoxDecoration(
          // color: config.HexColor("#79b5b5"),
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(10),
            bottomRight: Radius.circular(10),
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          ),
        ),
        alignment: Alignment.centerRight,
        child: _message_audio(context , conversation),
      );
    }

    // _message_audio(context , obj)
  }

  Widget getReceivedMessage(context) {

    var date = conversation["CreateDatetime"].toDate();
    String time = "${date.hour}:${date.minute}";
//    print(time);

    if(conversation["Messagetype"] == null || conversation["Messagetype"] == 0){
      return Align(
        alignment: Alignment.centerLeft,
        child: Container(
          constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width - 80),
          padding: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
//        margin: EdgeInsets.symmetric(vertical: 3),
          margin: const EdgeInsets.only(top: 0.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              new Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  new Container(
                    margin: const EdgeInsets.only(right: 8.0),
                    child: MyCircleAvatar(
                      imgUrl: conversation['ContactImgUrl'],
                      width: 40,
                      height: 40,
                    ),
                  ),
                ],
              ),
              new Flexible(
                child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    new Text(
                        conversation['Name'] != null ? conversation['Name'] : "ชื่อ" ,
                        style: Theme.of(context).textTheme.body2.merge(
                            TextStyle(
                                color: Colors.black54,
                                fontSize: 12.5
                            )
                        )
                    ),
                    new Container(
                      margin: const EdgeInsets.only(top: 5.0),
                      decoration: BoxDecoration(
                          color: config.HexColor("#E5E6EA"),
//                        #E5E6EA
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(15),
                              topLeft: Radius.circular(2),
                              bottomLeft: Radius.circular(15),
                              bottomRight: Radius.circular(15)
                          )
                      ),
                      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                      child: new Text(
                        conversation["Message"],
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 12.5,
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.bottomLeft,
                      margin: const EdgeInsets.only(left: 8,top: 2),
//              color: Colors.black54,
                      child: Text(
                        time,
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w300,
                          color: Colors.black54 ,
//                    height: 1.1,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

            ],
          ),
        ),
      );
    }
    else if(conversation["Messagetype"] == 2){
      return Align(
        alignment: Alignment.centerLeft,
        child: Container(
          width: 150,
          height: 150,
          margin: EdgeInsets.only(left: 0,right: 2,bottom: 20),
          child: Image(
            image: new AssetImage(conversation["Message"]),
          ),
        ),
      );
    }
    else if(conversation["Messagetype"] == 1){

      var ab = conversation["Message"];
      var _imgCount = ab.length > 3 ? 3 : ab.length;

      return Container(
        padding: EdgeInsets.only(top: 0,left: 0,right: 100,bottom: 0),
        child: Row(
          children: [

            Expanded(
                child: Container(
                    padding: EdgeInsets.only(top: 6,left: 6,right: 6,bottom: 4),
                    margin: EdgeInsets.only(left: 0,top: 5),
                    decoration: BoxDecoration(
                      color: Colors.black12,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                      ),
                    ),

                    child: StaggeredGridView.countBuilder(
                      crossAxisCount:  _imgCount == 1 ? 1 : 4,
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: _imgCount,
                      itemBuilder: (BuildContext context, int index) {

                        var _url = ab[index];

                        return  Container(
                          // padding: EdgeInsets.only(top: 5,left: 5,right: 5,bottom: 5),
                          // color: Colors.green,
                            child: Container(
                              child: InkWell(
                                child: Container(
                                  // width: 200,
                                  // height: 300,
                                  margin: EdgeInsets.only(left: 0,right: 0,bottom: 0),
                                  decoration: BoxDecoration(
                                    color: Colors.black12,
                                    borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(2),
                                      bottomRight: Radius.circular(2),
                                      topLeft: Radius.circular(2),
                                      topRight: Radius.circular(2),
                                    ),
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(
                                          _url
                                      ),
                                    ),
                                  ),

                                  // child: myPhotoList(conversation["Message"])
                                ),
                                onTap: (){
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => FullPhotoInRoomScreen(
                                              url: _url
                                          )
                                      )
                                  );
                                },
                              ),
                            )
                        );

                      },
                      staggeredTileBuilder: (int index) {

                        StaggeredTile _v = new StaggeredTile.count(0, 0);

                        if(_imgCount == 1){
                          _v = new StaggeredTile.count(2, 1.2);
                        }
                        else if(_imgCount == 2){
                          _v = new StaggeredTile.count(2, 3.2);
                        }
                        else{

                          if(index == 0){
                            _v = StaggeredTile.count(2, 3.6);
                          }
                          else if(index == 1){
                            _v = StaggeredTile.count(2, 2.3);
                          }
                          else
                          {
                            _v = StaggeredTile.count(2, 1.3);
                          }

                        }

                        return _v;
                      }
                      ,
                      mainAxisSpacing: 2.0,
                      crossAxisSpacing: 2.0,
                    )

                )
            ),
            Container(
              width: 50,
              child: Container(
                margin: const EdgeInsets.only(right: 8,top: 5),
                child: IconButton(
                  padding: EdgeInsets.only(left: 10,right: 5),
                  onPressed:  ()  {
                    // Navigator.of(context)
                    //     .pushNamed('/add_friend', arguments: 1);
                  },
                  icon: Icon(
                    Icons.share_outlined,
                    color: Colors.blueGrey,
                    size: 25,
                  ),
                ),
              ),
            ),

          ],
        ),
      );
    }

  }

  Widget myPhotoList(String MyImages) {

    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          // fit: BoxFit.contain,
          image: NetworkImage(
              MyImages
          ),
        ),
      ),

    );

  }

  Container _image_view(BuildContext context,String _url){

    return Container(
      child: InkWell(
        child: Container(
          // width: 200,
          // height: 300,
          margin: EdgeInsets.only(left: 0,right: 0,bottom: 0),
          decoration: BoxDecoration(
            color: Colors.black12,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(8),
              bottomRight: Radius.circular(8),
              topLeft: Radius.circular(8),
              topRight: Radius.circular(8),
            ),
            image: DecorationImage(
              fit: BoxFit.cover,
              image: NetworkImage(
                  _url
              ),
            ),
          ),

          // child: myPhotoList(conversation["Message"])
        ),
        onTap: (){
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => FullPhotoInRoomScreen(
                      url: _url))
          );
        },
      ),
    );

  }

  Container _message_text(context , obj){

    var date = obj["CreateDatetime"].toDate();
    String time = "${date.hour}:${date.minute}";
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Container(
//            constraints: BoxConstraints(minWidth: 100, maxWidth: 200),
            constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width - 80),
            padding: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
            margin: EdgeInsets.symmetric(vertical: 3),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                new Flexible(
                  child: Container(
//                    margin: const EdgeInsets.only(top: 5.0),
                    decoration: BoxDecoration(
                        color: config.HexColor("#79b5b5"),
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(15),
                            topRight: Radius.circular(15),
                            bottomLeft: Radius.circular(15),
                            bottomRight: Radius.circular(15)
                        )),
                    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                    child: new Text(
                      obj["Message"],
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 12.5,
                      ),
//                      style: TextStyle(
//                        fontSize: 15,
//                        fontWeight: FontWeight.w300,
//                        color: Colors.white ,
//                        height: 1.1,
//                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
              margin: const EdgeInsets.only(right: 8,bottom: 4),
//                  color: Colors.black54,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "Read",
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w300,
                      color: Colors.black54 ,
                      height: 1.2,
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
//                    conversation["CreateDatetime"],
                    time,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w300,
                      color: Colors.black54 ,
                      height: 1.1,
                    ),
                  ),
                ],
              )
          ),
        ],
      ),
    );

  }

  Container _message_stick(obj){
    var date = obj["CreateDatetime"].toDate();
    String time = "${date.hour}:${date.minute}";
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
            margin: EdgeInsets.symmetric(vertical: 3),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                new Flexible(
                  child: Container(
//                    margin: const EdgeInsets.only(top: 5.0),
                    decoration: BoxDecoration(
                        // color: config.HexColor("#79b5b5"),
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(0),
                            topRight: Radius.circular(0),
                            bottomLeft: Radius.circular(0),
                            bottomRight: Radius.circular(0)
                        )),
                    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                    child: new Container(
                      // width: 150,
                      // height: 150,
                      margin: EdgeInsets.only(left: 0,right: 2,bottom: 0),
                      child: Image(
                        image: new AssetImage(obj["Message"]),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
              margin: const EdgeInsets.only(right: 8,bottom: 4),
//                  color: Colors.black54,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "Read",
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w300,
                      color: Colors.black54 ,
                      height: 1.2,
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
//                    conversation["CreateDatetime"],
                    time,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w300,
                      color: Colors.black54 ,
                      height: 1.1,
                    ),
                  ),
                ],
              )
          ),
        ],
      ),
    );
  }

  Container _message_img_video(obj){

    var date = obj["CreateDatetime"].toDate();
    String time = "${date.hour}:${date.minute}";

    var ab = obj["Message"];
    var _imgCount = ab.length > 3 ? 3 : ab.length;

    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
            margin: EdgeInsets.symmetric(vertical: 3),
            child: Row(
              children: [
                Container(
                  width: 50,
                  child: Container(
                    margin: const EdgeInsets.only(right: 8,top: 5),
                    child: IconButton(
                      padding: EdgeInsets.only(left: 10,right: 5),
                      onPressed:  ()  {
                        // Navigator.of(context)
                        //     .pushNamed('/add_friend', arguments: 1);
                      },
                      icon: Icon(
                        Icons.share_outlined,
                        color: Colors.blueGrey,
                        size: 25,
                      ),
                    ),
                  ),
                ),
                Expanded(
                    child: Container(
                        padding: EdgeInsets.only(top: 4,left: 4,right: 4,bottom: 2),
                        margin: EdgeInsets.only(left: 0,top: 5),
                        decoration: BoxDecoration(
                          color: config.HexColor("#79b5b5"),
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10),
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                          ),
                        ),

                        child: StaggeredGridView.countBuilder(
                          crossAxisCount:  _imgCount == 1 ? 1 : 4,
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: _imgCount,
                          itemBuilder: (BuildContext context, int index)  {

                            Map<String,dynamic> _obj = ab[index];

                            String _type = "";

                            if(_obj["type"] == "AssetType.image"){
                              _type = "image";
                            }
                            else if(_obj["type"] == "AssetType.video"){
                              _type = "video";
                            }


                            if(_type == "video") {
                              // _controller = VideoPlayerController.network(_obj["image_url"])
                              //   ..initialize().then((_) {
                              //     // setState(() {});  //when your thumbnail will show.
                              //   });

                            }



                            return  Container(
                              // padding: EdgeInsets.only(top: 5,left: 5,right: 5,bottom: 5),
                              // color: Colors.green,
                              child: Container(
                                child:  _type == "image" ? InkWell(
                                  child: Container(
                                    // width: 200,
                                    // height: 300,
                                    margin: EdgeInsets.only(left: 0,right: 0,bottom: 0),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(8),
                                        bottomRight: Radius.circular(8),
                                        topLeft: Radius.circular(8),
                                        topRight: Radius.circular(8),
                                      ),
                                      image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: Image.network(
                                            _obj["image_url"]
                                        ).image,
                                      ),
                                    ),

                                    // child: myPhotoList(conversation["Message"])
                                  ),
                                  onTap: (){
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => FullPhotoInRoomScreen(
                                                url: _obj["image_url"]
                                            )
                                        )
                                    );
                                  },
                                ) : Container(
                                  child: Container(

                                    child: Stack(
                                      children: [

                                        Positioned(
                                            top:0,
                                            left: 0,
                                            right: 0,
                                            bottom: 0,
                                            child:  Container(

                                              decoration: BoxDecoration(
                                                color: Colors.white.withOpacity(0.5),
                                                borderRadius: BorderRadius.only(
                                                  bottomLeft: Radius.circular(8),
                                                  bottomRight: Radius.circular(8),
                                                  topLeft: Radius.circular(8),
                                                  topRight: Radius.circular(8),
                                                ),
                                                // image: DecorationImage(
                                                //   fit: BoxFit.cover,
                                                //   image: Image.network(
                                                //       _obj["image_url"]
                                                //   ).image,
                                                // ),
                                              ),
                                            )
                                        ),

                                        Positioned(
                                            top:0,
                                            left: 0,
                                            right: 0,
                                            bottom: 0,
                                            child:  Center(
                                              child: Icon(
                                                Icons.play_circle_outline,
                                                size: 40,
                                              ),
                                            )
                                        )

                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );


                          },
                          staggeredTileBuilder: (int index) {

                            StaggeredTile _v = new StaggeredTile.count(0, 0);

                            if(_imgCount == 1){
                              _v = new StaggeredTile.count(2, 1.2);
                            }

                            else if(_imgCount == 2){
                              _v = new StaggeredTile.count(2, 3.2);
                            }

                            else{

                              if(index == 0)
                              {
                                _v = StaggeredTile.count(2, 3.6);
                              }
                              else if(index == 1)
                              {
                                _v = StaggeredTile.count(2, 2.3);
                              }
                              else
                              {
                                _v = StaggeredTile.count(2, 1.3);
                              }

                            }

                            return _v;
                          }
                          ,
                          mainAxisSpacing: 4.0,
                          crossAxisSpacing: 4.0,
                        )

                    )
                )
              ],
            ),
          ),
          Container(
              margin: const EdgeInsets.only(right: 8,bottom: 4),
//                  color: Colors.black54,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "Read",
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w300,
                      color: Colors.black54 ,
                      height: 1.2,
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
//                    conversation["CreateDatetime"],
                    time,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w300,
                      color: Colors.black54 ,
                      height: 1.1,
                    ),
                  ),
                ],
              )
          ),
        ],
      ),
    );

  }

  Container _message_contact(context , obj){

    var _contac = conversation["Message"];
    var date = obj["CreateDatetime"].toDate();
    String time = "${date.hour}:${date.minute}";

    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Container(
//            constraints: BoxConstraints(minWidth: 100, maxWidth: 200),
            constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width - 80),
            padding: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
            margin: EdgeInsets.symmetric(vertical: 3),
            child: Row(
              // mainAxisSize: MainAxisSize.min,
              // crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  width: 50,
                  child: Container(
                    margin: const EdgeInsets.only(right: 8,top: 5),
                    child: IconButton(
                      padding: EdgeInsets.only(left: 10,right: 5),
                      onPressed:  ()  {
                        // Navigator.of(context)
                        //     .pushNamed('/add_friend', arguments: 1);
                      },
                      icon: Icon(
                        Icons.share_outlined,
                        color: Colors.blueGrey,
                        size: 25,
                      ),
                    ),
                  ),
                ),
                Expanded(
                    child: Container(
//                    margin: const EdgeInsets.only(top: 5.0),
                      decoration: BoxDecoration(
                          color: config.HexColor("#79b5b5"),
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(15),
                              topRight: Radius.circular(15),
                              bottomLeft: Radius.circular(15),
                              bottomRight: Radius.circular(15)
                          )),
                      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                      child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          itemCount: _contac.length,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (BuildContext context, int index) {

                            var _arrInfo = _contac[index];

                            return Container(
                              height: 45,
                              child: Container(
                                padding: EdgeInsets.only(top: 2,left: 3,right: 3,bottom: 2),
                                color: Colors.white,
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: 10,
                                    ),
                                    SizedBox(
                                      width: 25,
                                      height: 25,
                                      child: MyCircleAvatar(
                                        imgUrl: _arrInfo["ImgUrl"],
                                        width: 25,
                                        height: 25,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Expanded(

                                        child: Container(
                                            height: 50,
                                            child: Align(
                                              child: Text(
                                                _arrInfo["FullName"],
                                                overflow: TextOverflow.fade,
                                                softWrap: false,
                                                maxLines: 1,
                                                style: Theme.of(context).textTheme.body2.merge(
                                                    TextStyle(
                                                        fontWeight: FontWeight.w400,
                                                        fontSize: 16,
                                                        color: Colors.black87
                                                    )
                                                ),
                                              ),
                                              alignment: Alignment.centerLeft,
                                            )
                                        )
                                    ),

                                  ],
                                ),
                              ),
                            );
                          }

                      ),
                    )
                )
              ],
            ),
          ),
          Container(
              margin: const EdgeInsets.only(right: 8,bottom: 4),
//                  color: Colors.black54,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "Read",
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w300,
                      color: Colors.black54 ,
                      height: 1.2,
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
//                    conversation["CreateDatetime"],
                    time,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w300,
                      color: Colors.black54 ,
                      height: 1.1,
                    ),
                  ),
                ],
              )
          ),
        ],
      ),
    );

  }

  Container _message_file(context , obj){

    var _contac = conversation["Message"];
    var date = obj["CreateDatetime"].toDate();
    String time = "${date.hour}:${date.minute}";

    return Container(
      child: Column(
        // crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Container(
           // constraints: BoxConstraints(minWidth: 100, maxWidth: 200),
           //  constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width - 80),
           //  padding: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
           //  margin: EdgeInsets.symmetric(vertical: 3),
            child: Row(
              // mainAxisSize: MainAxisSize.min,
              // crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  width: 50,
                  child: Container(
                    margin: const EdgeInsets.only(right: 8,top: 5),
                    child: IconButton(
                      padding: EdgeInsets.only(left: 10,right: 5),
                      onPressed:  ()  {
                        // Navigator.of(context)
                        //     .pushNamed('/add_friend', arguments: 1);
                      },
                      icon: Icon(
                        Icons.share_outlined,
                        color: Colors.blueGrey,
                        size: 25,
                      ),
                    ),
                  ),
                ),
                Expanded(
                    child: Container(
//                    margin: const EdgeInsets.only(top: 5.0),
                      decoration: BoxDecoration(
                          color: config.HexColor("#79b5b5"),
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(15),
                              topRight: Radius.circular(15),
                              bottomLeft: Radius.circular(15),
                              bottomRight: Radius.circular(15)
                          )),
                      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                      child: Row(
                        children: [
                          Container(
                            child: Icon(
                              Icons.file_present,
                              color: Colors.white,
                              size: 25,
                            ),
                          ),
                          SizedBox(
                            width: 4,
                          ),
                         Expanded(child:  Container(
                             child: new Text(
                               _contac["name"],
                               overflow: TextOverflow.fade,
                               softWrap: true,
                               maxLines: 2,
                               style: TextStyle(
                                 color: Theme.of(context).primaryColor,
                                 fontSize: 12.5,
                               ),
//                      style: TextStyle(
//                        fontSize: 15,
//                        fontWeight: FontWeight.w300,
//                        color: Colors.white ,
//                        height: 1.1,
//                      ),
                             )

                           // Text(_contac["name"]),

                         ))

                        ],
                      ),
                    )
                )
              ],
            ),
          ),
          Container(
              margin: const EdgeInsets.only(right: 8,bottom: 4),
//                  color: Colors.black54,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "Read",
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w300,
                      color: Colors.black54 ,
                      height: 1.2,
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
//                    conversation["CreateDatetime"],
                    time,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w300,
                      color: Colors.black54 ,
                      height: 1.1,
                    ),
                  ),
                ],
              )
          ),
        ],
      ),
    );

  }

  Container _message_audio(context , obj){

    var _contac = conversation["Message"];
    var date = obj["CreateDatetime"].toDate();
    String time = "${date.hour}:${date.minute}";

    return Container(
      child: Column(
        // crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Container(
            // constraints: BoxConstraints(minWidth: 100, maxWidth: 200),
            //  constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width - 80),
            //  padding: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
            //  margin: EdgeInsets.symmetric(vertical: 3),
            child: Row(
              // mainAxisSize: MainAxisSize.min,
              // crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  width: 50,
                  child: Container(
                    margin: const EdgeInsets.only(right: 8,top: 5),
                    child: IconButton(
                      padding: EdgeInsets.only(left: 10,right: 5),
                      onPressed:  ()  {
                        // Navigator.of(context)
                        //     .pushNamed('/add_friend', arguments: 1);
                      },
                      icon: Icon(
                        Icons.share_outlined,
                        color: Colors.blueGrey,
                        size: 25,
                      ),
                    ),
                  ),
                ),
                Expanded(
                    child: Container(
//                    margin: const EdgeInsets.only(top: 5.0),
                      decoration: BoxDecoration(
                          color: config.HexColor("#79b5b5"),
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(15),
                              topRight: Radius.circular(15),
                              bottomLeft: Radius.circular(15),
                              bottomRight: Radius.circular(15)
                          )),
                      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                      child: Row(
                        children: [
                          Container(
                            child: Icon(
                              Icons.play_circle_outline,
                              color: Colors.white,
                              size: 25,
                            ),
                          ),
                          SizedBox(
                            width: 4,
                          ),
                          Expanded(child:  Container(
                              child: new Text(
                                _contac["time"],
                                // "00:00",
                                overflow: TextOverflow.fade,
                                softWrap: true,
                                maxLines: 2,
                                style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontSize: 12.5,
                                ),
//                      style: TextStyle(
//                        fontSize: 15,
//                        fontWeight: FontWeight.w300,
//                        color: Colors.white ,
//                        height: 1.1,
//                      ),
                              )

                            // Text(_contac["name"]),

                          )),
                          Container(
                            child: Icon(
                              Icons.multitrack_audio_outlined,
                              color: Colors.white,
                              size: 25,
                            ),
                          ),
                        ],
                      ),
                    )
                )
              ],
            ),
          ),
          Container(
              margin: const EdgeInsets.only(right: 8,bottom: 4),
//                  color: Colors.black54,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "Read",
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w300,
                      color: Colors.black54 ,
                      height: 1.2,
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
//                    conversation["CreateDatetime"],
                    time,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w300,
                      color: Colors.black54 ,
                      height: 1.1,
                    ),
                  ),
                ],
              )
          ),
        ],
      ),
    );

  }


}

