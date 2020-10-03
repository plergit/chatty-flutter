import 'package:flutter/material.dart';
import 'account/_profile.dart';
import 'account/_setting.dart';
import 'account/setting/_setting_image_profile.dart';
import 'friend/_add_friend.dart';
import 'friend/_add_group.dart';
import 'searchs/_friend.dart';



class RouteGenerator {


  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Getting arguments passed in while calling Navigator.pushNamed
    final args = settings.arguments;

    switch (settings.name) {

      case '/add_friend':
        return MaterialPageRoute(builder: (_) => AddFriendWidget());

      case '/add_group':
        return MaterialPageRoute(builder: (_) => AddGRoupWidget());

      case '/setting_profile':
        return MaterialPageRoute(builder: (_) => SettingProfileWidget());

      case '/profile':
        return MaterialPageRoute(builder: (_) => ProfileWidget());

      case '/settingImageProfile':
        return MaterialPageRoute(builder: (_) => SettingImageProfileWidget(
          Obj : args,
        ));

      case '/searchFriend':
        return MaterialPageRoute(builder: (_) => searchFriendWidget(
          Obj : args,
        ));
        // searchFriendWidget

      default:
        // If there is no such named route in the switch statement, e.g. /third
        return _errorRoute();
    }

  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (BuildContext context) {
      return Scaffold(
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
                            child: Container(
                                margin : EdgeInsets.only(left: 50,right: 0),
                                child: Text(
                                  "Error",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w600,
                                      color: Theme.of(context).accentColor),
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
        body: Center(
          child: Container(

            alignment: AlignmentDirectional.center,
            decoration: new BoxDecoration(
              image: new DecorationImage(
                image: new AssetImage("assets/images/bg-profile.png"),
                fit: BoxFit.cover,
              ),

            ),
            child: Container(
              // width: 100,
              // height: 100,
              decoration: new BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      color: Theme.of(context)
                          .hintColor
                          .withOpacity(0.03),
                      offset: Offset(0, 0),
                      blurRadius: 1)
                ],
              ),
              child:  Image(
                  image: new AssetImage("assets/images/icons/icon-comingsoon.png"),
            )
            ),
          ),
        ),
      );
    });
  }
}


class RouteArgument {
  dynamic id;
  List<dynamic> argumentsList;
  RouteArgument({this.id, this.argumentsList});
  @override
  String toString() {
    return '{id: $id, heroTag:${argumentsList.toString()}}';
  }
}