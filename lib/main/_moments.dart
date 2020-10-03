import 'package:chatty/model/moment.dart';
import 'package:chatty/moments/_moment_item.dart';
import 'package:chatty/shared/widgets/waiting_image_searching.dart';
import 'package:flutter/material.dart';
import '../config/app_config.dart' as config;

//import 'package:flutter_slidable/flutter_slidable.dart';


class MessagesWidget extends StatefulWidget {
  @override
  _MessagesWidget createState() => new _MessagesWidget();
}


class _MessagesWidget extends State<MessagesWidget> {


  ScrollController controllerScrollMain;

  Moment _message = new Moment.init();

  List<Map<String, dynamic>> _messageList =  [];


  @override
  void initState() {
    super.initState();

    try{
      _message.get_list_moments().then((value){
        setState(() {
          _messageList = value;
        });
      });
    }
    catch(e){
      print(e.toString());
    };



  }

  @override
  void dispose() {

    super.dispose();
  }



  @override
  Widget build(BuildContext context) {

    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    // _topbar = MediaQuery.of(context).padding.top;

//    print(_topbar);

    return new Scaffold(

      appBar: PreferredSize(
          preferredSize: Size.fromHeight(50.0),
          child: AppBar(
            elevation: 1,
            backgroundColor: Theme.of(context).accentColor,
            automaticallyImplyLeading: false, // hides leading widget
            flexibleSpace: Container(
                padding: EdgeInsets.only(left: 0 ,right: 0, top : MediaQuery.of(context).padding.top, bottom: 0),
                width: MediaQuery.of(context).size.width,
                child: Wrap(
                    direction: Axis.horizontal,
                    children: <Widget>[

                      Container(
                        height: 50,
                        width: double.infinity,
                        child:  Stack(
                            children: <Widget>[
                              Align(
                                alignment: Alignment.topLeft,
                                child: Container(
                                    height: 50.0,
                                    width: 90.0,
                                    child: Center(
                                      child: Text(
                                        "Moment",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.w600,
                                            color: Theme.of(context).primaryColor
                                        ),
                                      ),
                                    )
                                ),
                              ),
                              Align(
                                alignment: Alignment.topCenter,
                              ),
                              Align(
                                alignment: Alignment.topRight,
                                child:  Container(
                                  height: 50.0,
                                  width: 50.0,
                                  child: IconButton(
                                    padding: EdgeInsets.only(left: 10,right: 5),
                                    onPressed:  ()  {

//                                Navigator.of(context)
//                                    .pushNamed('/add_friend', arguments: 1);

                                    },
                                    icon: Icon(
                                      Icons.notifications_none,
                                      color: Theme.of(context).primaryColor,
                                      size: 23,
                                    ),
                                  ),
                                ),
                              ),
                            ]),
                      ),

                    ])
            ),
          )
      ),
      backgroundColor: Theme.of(context).backgroundColor,
      body: SingleChildScrollView(

        physics: BouncingScrollPhysics(),
        controller: controllerScrollMain,

        child : _messageList.length > 0 ? ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        primary: false,
        itemCount: _messageList.length,
        itemBuilder: (context, index) {

          Map<String, dynamic> _message = _messageList.elementAt(index);

          return MomentItemMain(message: _message);

        },
      ) : Container(
          height: (height-150),
          child: Center(
            child: WaitingImageSearching(),
          ),
        ),

      ),

    );

  }


}









