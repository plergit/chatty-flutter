import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';


import 'package:chatty/chat/menus/_asset_image.dart';
import 'package:chatty/friend/_select_list_friend.dart';
import 'package:chatty/model/chat.dart';
import 'package:chatty/model/member.dart';
import 'package:chatty/services/_chat.dart';
import 'package:chatty/services/_connect.dart';
import 'package:chatty/services/_location_map.dart';
import 'package:chatty/shared/files/imagePicker/compressImageSize.dart';
import 'package:chatty/shared/widgets/mycircleavatar.dart';
import 'package:chatty/shared/widgets/popupLoading.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:photo/photo.dart';
//import 'package:keyboard_visibility/keyboard_visibility.dart';
import '../config/app_config.dart' as config;
import '_messages.dart';
import 'package:photo_manager/photo_manager.dart';

import 'menus/_preview.dart';
import 'package:path/path.dart' as path;

import 'dart:async';
import 'dart:typed_data' show Uint8List;

import 'menus/_recorder_audio.dart';
import 'dart:io' as io;

import 'package:intl/intl.dart' show DateFormat;



// import 'package:flutter_localizations/flutter_localizations.dart';
// import 'package:google_map_location_picker/generated/l10n.dart' as location_picker;
// import 'package:google_map_location_picker/google_map_location_picker.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';


import 'package:google_map_location_picker/google_map_location_picker.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';




class RoomChatWidget extends StatefulWidget {

  Map<String, dynamic> objRoom;
  var infoFriend;



  RoomChatWidget({
    this.objRoom,
    this.infoFriend,
  });



  @override
  _ChatScreenState createState() => _ChatScreenState();
}



class _ChatScreenState extends State<RoomChatWidget> with SingleTickerProviderStateMixin {

  bool _showBottom = false;
  String _showType = "";
  bool _keyboardState = false;

  int _limit = 20;
  final int _limitIncrement = 20;


  final textController = TextEditingController();
  final ScrollController listScrollController = ScrollController();

  ChatRooms _chat = new ChatRooms.init();
  Conversation _conversation = new Conversation.init();


  StreamSubscription _recorderSubscription;
  StreamSubscription _playerSubscription;
  StreamSubscription _recordingDataSubscription;


  FlutterSoundRecorder recorderModule = FlutterSoundRecorder();

  StreamController<Uint8List> recordingDataController;

  String _recorderTxt = '00:00:00';
  String _playerTxt = '00:00:00';
  Codec _codec = Codec.pcm16WAV;
  IOSink sink;
  double _dbLevel;
  bool _isRecording = false;
  String _path = "";
  double _duration = null;
  double sliderCurrentPosition = 0.0;
  double maxDuration = 1.0;
  Media _media = Media.file;

  bool _encoderSupported = true; // Optimist
  bool _decoderSupported = true; // Optimist

  bool _select_mic = false;



  List<Map<String, dynamic>> messages = [];

  final firebaseUser = FirebaseAuth.instance;

  FocusNode _focus = new FocusNode();

  @override
  void initState() {

    super.initState();

    listScrollController.addListener(_scrollListener);
    _focus.addListener(_onFocusChange);
    _update_read_messages();

    initRecorder();
  }


  _scrollListener() {

    if (listScrollController.offset >=
        listScrollController.position.maxScrollExtent &&
        !listScrollController.position.outOfRange) {
      print("reach the bottom");
      setState(() {
        _limit += _limitIncrement;
      });
    }
    if (listScrollController.offset <=
        listScrollController.position.minScrollExtent &&
        !listScrollController.position.outOfRange) {
      print("reach the top");
      setState(() {
        print("reach the top");
      });
    }
  }


  void _update_read_messages() async {
    // print(widget.objRoom["MemberInfo"]);

    ChatRooms.MemberInRoom = widget.objRoom["MemberInfo"];
    // MemberInRoom
    ChatService.update_read_messages(widget.objRoom);


  }

  void _onFocusChange(){
    if(_showBottom == true && _focus.hasFocus == true){
      setState(() {
        _showBottom = false;
      });
    }
  }

  @override
  void dispose() {





    super.dispose();
  }


  Stream<QuerySnapshot> chats;

  Widget chatMessages(){
    return StreamBuilder(
      stream: firebaseCon.firestore_
          .collection("Rooms")
          .doc(widget.objRoom["RoomID"])
          .collection("Message")
          .limit(_limit).orderBy('CreateDatetime', descending: true)
          .snapshots(),
      builder: (context, snapshot){

        if(snapshot.hasData){
          _update_read_messages();
        }

        return snapshot.hasData ?

        ListView.builder(
            physics: BouncingScrollPhysics(),
            reverse: true,
            controller: listScrollController,
            itemCount: snapshot.data.docs.length,
            itemBuilder: (context, index){
              return MessagesWidget(
                conversation: snapshot.data.docs[index].data(),
              );
            }) : Container();
      },
    );
  }

  @override
  Widget build(BuildContext context) {

   // print(widget.infoFriend);

    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;


    var _roomMame = "${widget.infoFriend["RoomName"]} ${ChatRooms.MemberInRoom.length > 2 ? "(${ChatRooms.MemberInRoom.length.toString()})" : " "}" ;


    return GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
          setState(() {
            _showBottom = false;
          });


          // if(_mPlayer.isPlaying){
          //   stopPlayer();
          //   // _mPlayer.closeAudioSession();
          //   // _mPlayer = null;
          // }
          //
          // if(_mRecorder.isRecording){
          //   stopRecorder();
          //   // _mRecorder.closeAudioSession();
          //   // _mRecorder = null;
          // }


        },
        child:Scaffold(
          backgroundColor: Colors.white,
          appBar: PreferredSize(
              preferredSize: Size.fromHeight(55.0),
              child: AppBar(
                elevation: 0,
                backgroundColor: Theme.of(context).accentColor,
                automaticallyImplyLeading: false, // hides leading widget
                flexibleSpace: Container(
                    padding: EdgeInsets.only(
                        left: 0,
                        right: 0,
                        top: MediaQuery.of(context).padding.top,
                        bottom: 0),
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          height: 50,
                          width: double.infinity,
                          child: Stack(children: <Widget>[
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Container(
                                  margin : EdgeInsets.only(left: 45,right: 0),
                                  child: Row(
                                    children: <Widget>[
                                      MyCircleAvatar(
                                        imgUrl: widget.infoFriend['ImgUrl'],
                                        width: 40,
                                        height: 40,
                                      ),
                                      SizedBox(width: 15),
                                      Expanded(
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text(
                                              _roomMame,
//                                              widget.objRoom['RoomName'],
                                              style: Theme.of(context).textTheme.subhead.apply(
                                                color: Colors.white,
                                              ),
                                              overflow: TextOverflow.clip,
                                            ),

                                          ],
                                        ),
                                      ),
                                      Container(
                                        margin: const EdgeInsets.only(right: 8,top: 5),
                                        child:  Row(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            IconButton(
                                              padding: EdgeInsets.only(left: 10,right: 15),
                                              onPressed:  ()  {

                                                // Navigator.of(context)
                                                //     .pushNamed('/add_friend', arguments: 1);
                                              },
                                              icon: Icon(
                                                Icons.call,
                                                color: Theme.of(context).primaryColor,
                                                size: 23,
                                              ),
                                            ),
                                            IconButton(
                                              padding: EdgeInsets.only(left: 10,right: 5),
                                              onPressed:  ()  {

                                                // Navigator.of(context)
                                                //     .pushNamed('/add_friend', arguments: 1);
                                              },
                                              icon: Icon(
                                                Icons.more_vert,
                                                color: Theme.of(context).primaryColor,
                                                size: 23,
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
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
                      ],
                    )),
              )),

        body: Column(
          children: <Widget>[

            Expanded(
              child: Container(
//                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                padding: const EdgeInsets.only(left: 8,right: 8),
                child : chatMessages(),
              )
            ),

            Container(
              margin : EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom),
              child: Container(
                decoration: BoxDecoration(
                  color: config.HexColor("#f6f6f6"),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      width: 35,
                      height: 35,
                      margin : EdgeInsets.only(bottom: 5,top: 5,left: 10,right: 5),
                      decoration: BoxDecoration(
                        color:  Theme.of(context).accentColor,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(15),
                            topRight: Radius.circular(15),
                            bottomRight: Radius.circular(15),
                            bottomLeft: Radius.circular(15)
                        ),
                      ),
                      child: InkWell(
                          child : Icon(
                            _showBottom != true ? Icons.add : Icons.close,
                            size: 25,
                            color: Colors.white,
                          ), onTap : () {

                        setState(() {
                          FocusScope.of(context).requestFocus(new FocusNode());
                          _showType = "option";
                          _showBottom != true ? _showBottom = true : _showBottom = false;
                        });

                      }),
                    ),
                    Expanded(

                      child: TextField(
                        controller : textController,
                        focusNode: _focus,
//                            textInputAction: TextInputAction.go,
                        textInputAction: TextInputAction.newline,
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        onSubmitted: (value) {
                          print("search");
                        },
                        decoration: InputDecoration(
                            hintText: "พิมพ์ข้อความ...",
                            border: InputBorder.none,
                        ),
                        style: TextStyle(
                            color: Colors.black54 ,
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    IconButton(
                      alignment: Alignment.center,
                        icon: new ImageIcon(
                          AssetImage(
                          "assets/images/icons/ic-emoji-btn.png"
                          ),
                          size: 25,
                          color: Theme.of(context).accentColor,
                          ),
                          onPressed: (){

                            setState(() {
                              FocusScope.of(context).requestFocus(new FocusNode());
                              _showType = "emoji";
                              _showBottom != true ? _showBottom = true : _showBottom = false;
                            });

                          },
                    ),
//                    assets/images/icons/icon-send.png

                    IconButton(
                        icon: new ImageIcon(
                          AssetImage("assets/images/icons/icon-send.png"),
                          size: 35,
                          color: Theme.of(context).accentColor,
                      ), onPressed: () async {

                      onSendMessage(textController.text,0);
                    }),
                    SizedBox(width: 5,)
                  ],
                ),
              ),
            ),

            // buildRecorderAudio()

            _showBottom == true ? _showType == "option" ? buildOption() :
            _showType == "emoji" ?  buildSticker() : buildRecorderAudio() :
            Container(),

          ],
        ),


    ));
  }

  List<Map<String,dynamic>> _listSelectFriend  = [];

  Widget buildOption() {
    return Container(
      height: 200,
      margin : EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom),
      padding: EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: GridView.count(
        mainAxisSpacing: 20.0,
        crossAxisSpacing: 20.0,
        shrinkWrap: true,
        crossAxisCount: 3,
        childAspectRatio: 16/9.8,
        children: List.generate(
          _menuOption.length, (index) {
          var _arr = _menuOption[index];
          // print(_arr["imgUrl"]);

          return Container(
            decoration: BoxDecoration(
              color: Colors.transparent,
            ),
            child: InkWell(
              onTap: () async{

                //print(_arr);

                if(_arr["menu"] == 1){


                  // _getImageList();

                  // loadAssets();

                  _pickAsset(PickType.all).then((result){

                    if(result != null){
                      uploadFileImage(result);
                    }

                  });

                }
                else if(_arr["menu"] == 2){

                  // print(_arr);



                  setState(() {
                    FocusScope.of(context).requestFocus(new FocusNode());
                    _showType = "recorder_audio";
                    _showBottom = true ;
                  });

                  // _init_audio_recorder();

                  // bool hasPermission = await FlutterAudioRecorder.hasPermissions;


                  // Navigator.of(context).push(
                  //     PageRouteBuilder(
                  //         opaque: false,
                  //         pageBuilder: (BuildContext context, _, __) =>
                  //             Demo()
                  //     )
                  // );

                  // var recorder = FlutterAudioRecorder("file_path", audioFormat: AudioFormat.AAC); // or AudioFormat.WAV
                  // await recorder.initialized;


                }
                else if(_arr["menu"] == 3){

                  // _getImageList();
                  //await _pickFile(ImageSource.gallery);
                  // FilePickerResult result = await FilePicker.platform.pickFiles(allowMultiple: true);

                  FilePicker.platform.pickFiles(
                    allowMultiple: false,
                    type: FileType.custom,
                    allowedExtensions: ['audio','pdf', 'doc'],
                  ).then((result) {

                    if(result != null){
                      _uploadFileDoc(result);
                    }


                  });

                }
                else if(_arr["menu"] == 4){

                    Navigator.of(context).push(
                    PageRouteBuilder(
                    opaque: false,
                    pageBuilder: (BuildContext context, _, __) =>
                        FriendListSelectWidget(
                            friends_list : _listSelectFriend
                        )
                    )
                    ).then((value) {
                      if (value != null) {

                       List<Map<String, dynamic>> _listContact = [];

                        for(var _a in value["_arrselect"]){

                          var _friendUid = _a["Uid"];
                          var _friendinfo = _a["friend_info"];
                          var _obj = {
                            "Uid":_friendUid,
                            "FullName":_friendinfo["FullName"],
                            "ImgUrl":_friendinfo["ImgUrl"]
                          };

                          _listContact.add(_obj);

                        }

                        onSendMessage(_listContact,4);

                      }
                    });

                }


                else if(_arr["menu"] == 5){

                  // LocationResult result = await showLocationPicker(context, "AIzaSyA_-5IFdFyzMXbxClKz6F2uHRJbdDLoXBg");

//                   LocationResult result = await showLocationPicker(
//                     context, "AIzaSyA_-5IFdFyzMXbxClKz6F2uHRJbdDLoXBg",
//                     initialCenter: LatLng(45.521563, -122.677433),
//                     //  automaticallyAnimateToCurrentLocation: true,
// //                      mapStylePath: 'assets/mapStyle.json',
//                     myLocationButtonEnabled: true,
//                     layersButtonEnabled: true,
//                     // countries: ['TH'],
//
// //                      resultCardAlignment: Alignment.bottomCenter,
//                   );


                  // print(result.address);






                // Navigator.push(
                // context,
                // MaterialPageRoute(
                // builder: (context) => GetLocationPicker(),
                // ),
                // );



                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => PlacePicker(
                  //       apiKey: "AIzaSyA_-5IFdFyzMXbxClKz6F2uHRJbdDLoXBg",   // Put YOUR OWN KEY here.
                  //       onPlacePicked: (result) {
                  //
                  //         print("sssssssss");
                  //
                  //         print(result);
                  //         Navigator.of(context).pop();
                  //       },
                  //       initialPosition: GetLocationPicker.kInitialPosition,
                  //       useCurrentLocation: true,
                  //
                  //     ),
                  //   ),
                  // );




                  LocationResult result = await showLocationPicker(
                    context, firebaseCon.kGoogleApiKey,
                    // initialCenter: LatLng(13.647229132525382, 100.33053405582905),
                    //  automaticallyAnimateToCurrentLocation: true,
//                      mapStylePath: 'assets/mapStyle.json',
                    myLocationButtonEnabled: true,
                    layersButtonEnabled: true,
                    // countries: ['TH', 'EN'],
                     // resultCardAlignment: Alignment.bottomCenter,
                  );
                  print("result-select = ${result}");
                  // setState(() {
                  //
                  //
                  //
                  // });




                  // Navigator.of(context).push(
                  //     PageRouteBuilder(
                  //         opaque: false,
                  //         pageBuilder: (BuildContext context, _, __) =>
                  //             PlacePicker(
                  //               apiKey: firebaseCon.kGoogleApiKey,
                  //               // initialPosition:  firebaseCon.kGoogleApiKey,
                  //               initialPosition: LatLng(31.1975844, 29.9598339),
                  //               useCurrentLocation: true,
                  //               selectInitialPosition: true,
                  //
                  //               //usePlaceDetailSearch: true,
                  //               onPlacePicked: (result) {
                  //
                  //                 // print(result);
                  //
                  //                 // print(result.address);
                  //
                  //                 // selectedPlace = result;
                  //                 Navigator.of(context).pop();
                  //                 // setState(() {});
                  //               },
                  //               forceSearchOnZoomChanged: true,
                  //               automaticallyImplyAppBarLeading: false,
                  //               // autocompleteLanguage: "ko",
                  //               // region: 'au',
                  //               // selectInitialPosition: true,
                  //               selectedPlaceWidgetBuilder: (_, selectedPlace, state, isSearchBarFocused) {
                  //                 print("state: $state, isSearchBarFocused: $isSearchBarFocused");
                  //                 return isSearchBarFocused
                  //                     ? Container(
                  //                   child: Text("dddd"),
                  //                 )
                  //                     : FloatingCard(
                  //                   topPosition: 0,
                  //                   bottomPosition: 0.0, // MediaQuery.of(context) will cause rebuild. See MediaQuery document for the information.
                  //                   leftPosition: 0.0,
                  //                   rightPosition: 0.0,
                  //                   width: 200,
                  //                   borderRadius: BorderRadius.circular(12.0),
                  //                   child: state == SearchingState.Searching
                  //                       ? Center(child: CircularProgressIndicator())
                  //                       : RaisedButton(
                  //                     child: Text("Pick Here"),
                  //                     onPressed: () {
                  //                       // IMPORTANT: You MUST manage selectedPlace data yourself as using this build will not invoke onPlacePicker as
                  //                       //            this will override default 'Select here' Button.
                  //                       print("do something with [selectedPlace] data");
                  //                       Navigator.of(context).pop();
                  //                     },
                  //                   ),
                  //                 );
                  //               },
                  //               // pinBuilder: (context, state) {
                  //               //   if (state == PinState.Idle) {
                  //               //     return Icon(Icons.favorite_border);
                  //               //   } else {
                  //               //     return Icon(Icons.favorite);
                  //               //   }
                  //               // },
                  //             )
                  //     )
                  // );

                  // GetLocation



                }



              },
              child: Container(
                child:  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[

                        Container(
                          height: 40,
                          width: 40,
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment.topRight,
                                end: Alignment.bottomLeft,
                                colors: [config.HexColor("#F7F7F7"), config.HexColor("#F7F7F7")]
                            ),
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                  color: Theme.of(context)
                                      .hintColor
                                      .withOpacity(0.10),
                                  offset: Offset(0, 1),
                                  blurRadius: 4
                              )
                            ],
                          ),

                          child: Image(
                            image: new AssetImage(_arr["imgUrl"]),
                          ),

                          // child: ImageIcon(
                          //   AssetImage(_arr["imgUrl"].toString()),
                          //   size: 25,
                          //   color: Theme.of(context).accentColor,
                          // ),

                        ),

                        Container(
                            margin: const EdgeInsets.only(top: 3, bottom: 0),
                            child: Center(
                              child: Text(
                                _arr["name"],
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black87
                                ),
                              ),
                            )
                        )

                      ],
                    )
                ),

              ),
            ),
          );
        },
        ),
      ),
    );
  }

  Widget buildSticker() {
    return Container(
      height: 200,
      margin : EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom),
      padding: EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: GridView.count(
        mainAxisSpacing: 20.0,
        crossAxisSpacing: 20.0,
        shrinkWrap: true,
        crossAxisCount: 3,
        childAspectRatio: 16/9.8,
        children: List.generate(
          _listSticker.length, (index) {
          var _arr = _listSticker[index];
          // print(_arr["imgUrl"]);

          return Container(
            decoration: BoxDecoration(
              color: Colors.transparent,
            ),
            child: InkWell(
              onTap: (){
                onSendMessage(_arr["imgUrl"], 2);
                setState(() {
                  _showBottom = false;
                });
              },
              child: Container(
                height: 40,
                width: 40,
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      colors: [config.HexColor("#F7F7F7"), config.HexColor("#F7F7F7")]
                  ),
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                        color: Theme.of(context)
                            .hintColor
                            .withOpacity(0.10),
                        offset: Offset(0, 1),
                        blurRadius: 4)
                  ],
                ),

                child: Image(
                  image: new AssetImage(_arr["imgUrl"]),
                ),

                // child: ImageIcon(
                //   AssetImage(_arr["imgUrl"].toString()),
                //   size: 25,
                //   color: Theme.of(context).accentColor,
                // ),

              ),
            ),
          );
        },
        ),
      ),
    );
  }

  Widget buildRecorderAudio() {


    return Container(
      height: 200,
      margin : EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom),
      padding: EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(0),
            bottomRight: Radius.circular(0),
            topLeft: Radius.circular(0),
            topRight: Radius.circular(0),
          ),
          image: DecorationImage(
            fit: BoxFit.cover,
            image: Image.asset("assets/images/icons/background_recorder.png").image,
          ),
        ),
        child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // new Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: <Widget>[
              //     Padding(
              //       padding: const EdgeInsets.all(8.0),
              //       child: new FlatButton(
              //         onPressed: () {
              //           switch (_currentStatus) {
              //             case RecordingStatus.Initialized:
              //               {
              //                 _start();
              //                 break;
              //               }
              //             case RecordingStatus.Recording:
              //               {
              //                 _pause();
              //                 break;
              //               }
              //             case RecordingStatus.Paused:
              //               {
              //                 _resume();
              //                 break;
              //               }
              //             case RecordingStatus.Stopped:
              //               {
              //                 _init();
              //                 break;
              //               }
              //             default:
              //               break;
              //           }
              //         },
              //         child: _buildText(_currentStatus),
              //         color: Colors.lightBlue,
              //       ),
              //     ),
              //     new FlatButton(
              //       onPressed:
              //       _currentStatus != RecordingStatus.Unset ? _stop : null,
              //       child:
              //       new Text("Stop", style: TextStyle(color: Colors.white)),
              //       color: Colors.blueAccent.withOpacity(0.5),
              //     ),
              //     SizedBox(
              //       width: 8,
              //     ),
              //     new FlatButton(
              //       onPressed: onPlayAudio,
              //       child:
              //       new Text("Play", style: TextStyle(color: Colors.white)),
              //       color: Colors.blueAccent.withOpacity(0.5),
              //     ),
              //
              //
              //   ],
              // ),


              // new Text("Status : $_currentStatus"),
              // new Text('Avg Power: ${_current?.metering?.averagePower}'),
              // new Text('Peak Power: ${_current?.metering?.peakPower}'),
              // new Text("File path of the record: ${_current?.path}"),
              // new Text("Format: ${_current?.audioFormat}"),
              // new Text(
              //     "isMeteringEnabled: ${_current?.metering?.isMeteringEnabled}"),
              // new Text("Extension : ${_current?.extension}"),
              // new Text(
              //     "Audio recording duration : ${_current?.duration.toString()}"
              // ),

              GestureDetector(
                onLongPressStart: (_e){
                  setState(() {
                    _select_mic = true;
                  });
                  // _start_audio_recorder();
                  startRecorder();
                },
                onLongPressEnd: (_e){
                  setState(() {
                    _select_mic = false;
                  });
                  // _stop_audio_recorder();

                  stopRecorder();

                },
                child: ClipOval(
                  child: Container(
                    width: 100,
                    height: 100,
                    decoration: new BoxDecoration(
                      color: Colors.white,
                      image: new DecorationImage(
                        image: new AssetImage( _select_mic == false ? "assets/images/icons/icon-unselect-mic.png" : "assets/images/icons/icon-select-mic.png"),
                        fit: BoxFit.cover,
                      ),
                    ),

                  ),
                ),
              )
            ]
        ),
      ),
    );
  }

  void onSendMessage(content,int type) {
    // type: 0 = text, 1 = image, 2 = sticker

    var date = new DateTime.now();
    String time = "${date.hour}:${date.minute}:${date.second}";

    if(content != ''){

      Map<String, dynamic> _obj_r = {};

      widget.objRoom["MemberInfo"].forEach((final String key, final value) {

          var _r_date = null;
          int _r = 0;

          if(value["Uid"] == Member.myUid.toString() ){
            _r_date = date;
            _r = 1;
          }
          _obj_r[value["Uid"]]  =  {
            "Read": _r,
            "DateTimeRead" : _r_date
          };

      });

      _conversation.Read = _obj_r;

      var _obj = _conversation.toJson();
      _obj["CreateDatetime"] = date;
      _obj["UpdateDatetime"] = date;
      _obj["Uid"] = Member.myUid;
      _obj["Name"] = Member.myName;
      _obj["Message"] = content;
      _obj["RoomID"] = widget.objRoom['RoomID'];
      _obj["ContactImgUrl"] = Member.photoUrl;
      _obj["Messagetype"] = type;

      var _e = ChatService.send_message(_obj);

      setState(() {
        textController.clear();
      });

      listScrollController.animateTo(0.0,
          duration: Duration(milliseconds: 300), curve: Curves.easeOut);

    }



  }


  void _onLoading() {

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => PopupLoading(),
    );

  }


  Future uploadFileImage(List<Map<String,dynamic>> r) async {

    setState(() {
      _showBottom = false;
    });

    List< Map<String,dynamic>> _urlFile = [];

    _onLoading();

    for(var _a in r){

      File imageFile = File(_a["image_url"]);
      String filePath = imageFile.path;
      var fileType = path.rootPrefix(filePath);
      String _Type = path.extension(filePath);
      String fileName = "${DateTime.now().millisecondsSinceEpoch.toString()}$_Type";
      String _dirRoom = "images/chat/${widget.objRoom['RoomID']}/$fileName";

      //print(fileType);

      // Map<String, dynamic> file_ = await size_image().compressImage(imageFile);

      if(AssetType.image == _a["type"]){
        // print(_a);
        Map<String, dynamic> file_ = await size_image().compressImage(imageFile);
        imageFile = file_["x2"];
      }


      StorageReference reference = FirebaseStorage.instance.ref().child(_dirRoom);
      StorageUploadTask uploadTask = await reference.putFile(imageFile);
      StorageTaskSnapshot storageTaskSnapshot = await uploadTask.onComplete;

      await storageTaskSnapshot.ref.getDownloadURL().then((downloadUrl) {
        String image_url = downloadUrl;

        Map<String,dynamic> _obj = {
          "image_url" : image_url,
          "type" : _a["type"].toString()
        };
        _urlFile.add(_obj);

      }, onError: (e) {

        print(e.toString());

      });

      // print(_urlFile);
    }

    if(_urlFile.length == r.length){

      Navigator.pop(context);
      setState(() {
        onSendMessage(_urlFile , 1);
      });

    }
    else{
      Navigator.pop(context);
    }

  }

  Future _uploadFileDoc(result) async {

    List<String> _urlFile = [];

    for(var _arr in result.files){
      _urlFile.add(_arr.path);
    }

    File imageFile = File(_urlFile[0]);

    String fileType = imageFile.path;

    String _fname = path.basename(imageFile.path);

    String _Type = path.extension(fileType);


    String fileName = "${DateTime.now().millisecondsSinceEpoch.toString()}$_Type";
    String _dirRoom = "images/chat/${widget.objRoom['RoomID']}/$fileName";

    _onLoading();


    StorageReference reference = FirebaseStorage.instance.ref().child(_dirRoom);
    StorageUploadTask uploadTask = reference.putFile(imageFile);
    StorageTaskSnapshot storageTaskSnapshot = await uploadTask.onComplete;

    storageTaskSnapshot.ref.getDownloadURL().then((downloadUrl) {

      String image_url = downloadUrl;
      Navigator.pop(context);

      Map<String,dynamic> _obj = {
        "image_url" : image_url,
        "name" : _fname
      };

      setState(() {
        onSendMessage(_obj, 3);
      });

    }, onError: (e) {
      Navigator.pop(context);
      print(e.toString());
      //Fluttertoast.showToast(msg: 'This file is not an image');
    });


  }


  List<Asset> imagesLise = List<Asset>();

  Future<void> loadAssets() async {
    List<Asset> resultList = List<Asset>();
    String error = 'No Error Dectected';

    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 300,
        enableCamera: true,
        selectedAssets: imagesLise,
        cupertinoOptions: CupertinoOptions(takePhotoIcon: "chat"),
        materialOptions: MaterialOptions(
          actionBarColor: "#abcdef",
          actionBarTitle: "Example App",
          allViewTitle: "All Photos",
          useDetailsView: false,
          selectCircleStrokeColor: "#000000",
        ),
      );
    } on Exception catch (e) {
      error = e.toString();
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    // setState(() {
    imagesLise = resultList;
    //   _error = error;
    // });


  }

  Future _pickAsset(PickType type, {List<AssetPathEntity> pathList}) async {
    /// context is required, other params is optional.
    /// context is required, other params is optional.
    /// context is required, other params is optional.

    // PhotoPicker.clearThumbMemoryCache();



    List<AssetEntity> imgList = await PhotoPicker.pickAsset(
      // BuildContext required
      context: context,
      /// The following are optional parameters.
      themeColor: Theme.of(context).accentColor,
      // the title color and bottom color

      textColor: Colors.white,
      // text color
      padding: 1.0,
      // item padding
      dividerColor: Colors.grey,
      // divider color
      disableColor: Colors.grey.shade300,
      // the check box disable color
      itemRadio: 0.88,
      // the content item radio
      maxSelected: 8,
      // max picker image count
      // provider: I18nProvider.english,
      provider: I18nProvider.english,

      // i18n provider ,default is chinese. , you can custom I18nProvider or use ENProvider()
      rowCount: 3,
      // item row count

      thumbSize: 150,
      // preview thumb size , default is 64
      sortDelegate: SortDelegate.common,

      // default is common ,or you make custom delegate to sort your gallery
      checkBoxBuilderDelegate: DefaultCheckBoxBuilderDelegate(
        activeColor: Colors.white,
        unselectedColor: Theme.of(context).accentColor,
        checkColor: Colors.green,
      ),
      // default is DefaultCheckBoxBuilderDelegate ,or you make custom delegate to create checkbox
      //loadingDelegate: this,
      // if you want to build custom loading widget,extends LoadingDelegate, [see example/lib/main.dart]

      badgeDelegate: const DurationBadgeDelegate(),
      // badgeDelegate to show badge widget

      pickType: type,
      photoPathList: pathList,
    );

    if (imgList == null || imgList.isEmpty) {
      print("No pick item.");
      return;
    } else {

      List<Map<String,dynamic>> r = [];



      for (var e in imgList)
      {


        var file = await e.file;


        if(e.type == AssetType.video){

          // var thumbData = await e.thumbDataWithSize(100, 100);
          // file.absolute.;

          var thumbData = await e.thumbData;

          var _im = Image.memory(thumbData).image;

          // print(_im);

          var _im2 = AssetImageWidget(
            assetEntity: e,
            width: 300,
            height: 200,
            boxFit: BoxFit.cover,
          );

          Uint8List data = (await thumbData)
              .buffer
              .asUint8List();

          //print(data);


          // var _im = Image.memory(
          //   thumbData,
          //   fit: BoxFit.cover,
          // ).image;

          // String mediaUrl = await entity.getMediaUrl();



        }


        Map<String,dynamic> _obj = {
          "image_url" : file.path,
          "type" : e.type
        };

        r.add(_obj);
      }
      // currentSelected = r.join("\n\n");

      List<AssetEntity> preview = [];
      preview.addAll(imgList);

      // print(imgList);

      // Navigator.push(context,
      //     MaterialPageRoute(builder: (_) => PreviewPage(list: preview)));

      return r;
    }
    // setState(() {});
  }


  void setCodec(Codec codec) async {
    //_encoderSupported = await recorderModule.isEncoderSupported(codec);
    setState(() {
      _codec = codec;
    });
  }

  Future<void> _initializeExample(bool withUI) async {
    await setCodec(_codec);
  }


  Future<void> initRecorder() async {
    //playerModule = await FlutterSoundPlayer().openAudioSession();
    recorderModule.openAudioSession(
        focus: AudioFocus.requestFocusTransient,
        category: SessionCategory.playAndRecord,
        mode: SessionMode.modeDefault,
        device: AudioDevice.speaker);
    await _initializeExample(false);

    if (Platform.isAndroid) {
      //await copyAssets();
    }
  }

  void startRecorder() async {
    try {
      // Request Microphone permission if needed
      PermissionStatus status = await Permission.microphone.request();
      if (status != PermissionStatus.granted) {
        throw RecordingPermissionException("Microphone permission not granted");
      }

      Directory tempDir = await getTemporaryDirectory();
       _path = '${tempDir.path}/${recorderModule}-flutter_sound${ext[_codec.index]}';

      if (_media == Media.stream) {
        assert(_codec == Codec.pcm16);
        File outputFile = File(_path);
        if (outputFile.existsSync())
          await outputFile.delete();
        sink = outputFile.openWrite();
        recordingDataController = StreamController<Uint8List>();
        _recordingDataSubscription =
            recordingDataController.stream.listen((Uint8List buffer) {
              sink.add(buffer);
            });
        await recorderModule.startRecorder(
          toStream: recordingDataController.sink,
          codec: _codec,
          numChannels: 1,
          sampleRate: SAMPLE_RATE,
        );
      } else {
        await recorderModule.startRecorder(
          toFile: _path,
          codec: _codec,
          bitRate: 8000,
          numChannels: 1,
          sampleRate: 8000,
        );
      }
      print('startRecorder');

      _recorderSubscription = recorderModule.onProgress.listen((e) {
        if (e != null && e.duration != null) {
          DateTime date = new DateTime.fromMillisecondsSinceEpoch(
              e.duration.inMilliseconds,
              isUtc: true);
          String txt = DateFormat('mm:ss:SS').format(date);

          // print(txt);

          this.setState(() {
            _recorderTxt = txt.substring(0, 8);
            _dbLevel = e.decibels;
          });
        }
      });

      // this.setState(() {
      //   this._isRecording = true;
      //   this._path = path;
      // });

    } catch (err) {
      print('startRecorder error: $err');
      // setState(() {
      //   stopRecorder();
      //   this._isRecording = false;
      //   cancelRecordingDataSubscription();
      //   cancelRecorderSubscriptions();
      // });
    }
  }


  void cancelRecorderSubscriptions() {
    if (_recorderSubscription != null) {
      _recorderSubscription.cancel();
      _recorderSubscription = null;
    }
  }


  void cancelRecordingDataSubscription() {
    if (_recordingDataSubscription != null) {
      _recordingDataSubscription.cancel();
      _recordingDataSubscription = null;
    }
    recordingDataController = null;
    if (sink != null) {
      sink.close();
      sink = null;
    }
  }


  Future<void> getDuration() async {

    Duration d = await flutterSoundHelper.duration(this._path);
    _duration = d != null ? d.inMilliseconds / 1000.0 : null;

    _uploadFileAudio(_path , _duration.toString());

    //print("get data ${_duration}");

  }

  void stopRecorder() async {
    try {
      await recorderModule.stopRecorder();
      print('stopRecorder ${recorderModule.tmpUri}');
      cancelRecorderSubscriptions();
      cancelRecordingDataSubscription();
      getDuration();

      // _uploadFileAudio();

    } catch (err) {
      print('stopRecorder error: $err');
    }
    this.setState(() {
      this._isRecording = false;
    });
  }

  Future<bool> fileExists(String path) async {
    return await File(path).exists();
  }

  Future _uploadFileAudio(String _p,String _t) async {

    File imageFile = File(_path);

    String fileType = imageFile.path;

    String _fname = path.basename(imageFile.path);

    String _Type = path.extension(fileType);


    String fileName = "${DateTime.now().millisecondsSinceEpoch.toString()}$_Type";
    String _dirRoom = "images/chat/${widget.objRoom['RoomID']}/$fileName";

    _onLoading();

    StorageReference reference = FirebaseStorage.instance.ref().child(_dirRoom);
    StorageUploadTask uploadTask = reference.putFile(imageFile);
    StorageTaskSnapshot storageTaskSnapshot = await uploadTask.onComplete;

    storageTaskSnapshot.ref.getDownloadURL().then((downloadUrl) {

      String image_url = downloadUrl;
      Navigator.pop(context);

      Map<String,dynamic> _obj = {
        "image_url" : image_url,
        "time" : _t
      };

      setState(() {
        onSendMessage(_obj, 5);
      });

    }, onError: (e) {
      Navigator.pop(context);
      print(e.toString());
      //Fluttertoast.showToast(msg: 'This file is not an image');
    });


  }


}

List<Map<String, dynamic>> _listSticker = [
  {
    'imgUrl': 'assets/images/ic-sticker/mimi1.gif'
  },
  {
    'imgUrl': 'assets/images/ic-sticker/mimi2.gif'
  },
  {
    'imgUrl': 'assets/images/ic-sticker/mimi3.gif'
  },
  {
    'imgUrl': 'assets/images/ic-sticker/mimi4.gif'
  },
  {
    'imgUrl': 'assets/images/ic-sticker/mimi5.gif'
  },
  {
    'imgUrl': 'assets/images/ic-sticker/mimi6.gif'
  },
  {
    'imgUrl': 'assets/images/ic-sticker/mimi7.gif'
  },
  {
    'imgUrl': 'assets/images/ic-sticker/mimi8.gif'
  },
  {
    'imgUrl': 'assets/images/ic-sticker/mimi9.gif'
  }
];


List<Map<String, dynamic>> _menuOption = [
  {
    'menu':1,
    'imgUrl': 'assets/images/icons/photo_video.png',
    'name': 'Photo & Video'
  },
  {
    'menu':2,
    'imgUrl': 'assets/images/icons/audio.png',
    'name': 'Audio'
  },
  {
    'menu':3,
    'imgUrl': 'assets/images/icons/files.png',
    'name': 'File'
  },
  {
    'menu':4,
    'imgUrl': 'assets/images/icons/contact.png',
    'name': 'Contact'
  },
  {
    'menu':5,
    'imgUrl': 'assets/images/icons/location.png',
    'name': 'Location'
  },
  {
    'menu':6,
    'imgUrl': 'assets/images/icons/more.png',
    'name': 'More'
  }

];










