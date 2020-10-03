import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'main/_account.dart';
import 'main/_chat.dart';
import 'main/_discovery.dart';
import 'main/_home.dart';
import 'main/_moments.dart';
import './config/app_config.dart' as config;
import 'model/member.dart';
import 'services/_auth.dart';
import 'shared/widgets/mycircleavatar.dart';

class TabsWidget extends StatefulWidget {





  int currentTab = 0;
  int selectedTab = 0;
  String currentTitle = '';
  Widget currentPage = HomeWidget();

  TabsWidget({
    Key key,
    this.currentTab,
  }) : super(key: key);

  @override
  _TabsWidgetState createState() {
    return _TabsWidgetState();
  }
}

class _TabsWidgetState extends State<TabsWidget> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();


  @override
  initState() {

    AuthService().member_online();
    _selectTab(widget.currentTab);
    super.initState();
  }


  void changeTabs(int tabIndex) {
    setState(() {
      widget.selectedTab = tabIndex;
    });
  }


  @override
  void didUpdateWidget(TabsWidget oldWidget) {
    _selectTab(oldWidget.currentTab);
    super.didUpdateWidget(oldWidget);
  }

  void _selectTab(int tabItem) {

    setState(() {

      widget.currentTab = tabItem;
      widget.selectedTab = tabItem;

      switch (tabItem) {
        case 0:
          widget.currentTitle = 'Home';
          widget.currentPage = HomeWidget();
          break;
        case 1:
          widget.currentTitle = 'Chat';
          widget.currentPage = ChatWidget();
          break;
        case 2:
          widget.currentTitle = 'Moments';
          widget.currentPage = MessagesWidget();
          break;
        case 3:
          widget.currentTitle = 'Discovery';
          widget.currentPage = DiscoveryWidget();
          break;
        case 4:
          widget.currentTitle = 'Account';
          widget.currentPage = AccountWidget();
          break;
      }

    });

  }



  @override
  Widget build(BuildContext context) {

    return Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        key: _scaffoldKey,
        body: widget.currentPage,
        bottomNavigationBar: Container(
//            height: 90,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(10), topLeft: Radius.circular(10)
              ),
              boxShadow: [
                BoxShadow(color: Colors.black26, spreadRadius: -0.5, blurRadius: 10),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0),
              ),
              child: BottomNavigationBar(
                  backgroundColor: Theme.of(context).primaryColor,
                  selectedFontSize: 11.5,
                  selectedItemColor: Theme.of(context).accentColor,
                  unselectedFontSize: 10.5,
                  elevation: 30,
                  currentIndex: widget.currentTab,
                  onTap: (int index) {
                    setState(() {
                      widget.selectedTab = index;
                     });
                    this._selectTab(index);
//            _navigateToScreens(widget.selectedTab);
                  },
                  type: BottomNavigationBarType.fixed,
                  items: [
                    new BottomNavigationBarItem(

                        icon: widget.selectedTab == 0 ?
                        ImageIcon(
                          AssetImage("assets/images/ic_nav_main/menubar_home-ac@2x.png" ),
                          size: config.App(context).appWidth(6.3),
                        ) : ImageIcon(
                          AssetImage("assets/images/ic_nav_main/menubar_home@2x.png"),
                          size: config.App(context).appWidth(6.3),
                        ),

                        title: new Text(
                            "Home",
                            style: TextStyle(
                            )
                        )),
                    new BottomNavigationBarItem(
                        icon: widget.selectedTab == 1 ?
                        ImageIcon(
                          AssetImage("assets/images/ic_nav_main/menubar_chat-ac@2x.png"  ),
                          size: config.App(context).appWidth(6.3),
                        ) : ImageIcon(
                          AssetImage("assets/images/ic_nav_main/menubar_chat@2x.png"  ),
                          size: config.App(context).appWidth(6.3),
                        ),
                        title: new Text(
                            "Chat",
                            style: TextStyle(
                            )
                        )),
                    new BottomNavigationBarItem(
                        icon: widget.selectedTab == 2 ?
                        ImageIcon(
                          AssetImage("assets/images/ic_nav_main/menubar_moment-ac@2x.png"  ),
                          size: config.App(context).appWidth(6.3),
                        ) : ImageIcon(
                          AssetImage("assets/images/ic_nav_main/menubar_moment@2x.png"  ),
                          size: config.App(context).appWidth(6.3),
                        ),
                        title: new Text(
                          "Moments",
                          style: TextStyle(
                          ),
                        )),
                    new BottomNavigationBarItem(
                        icon: widget.selectedTab == 3 ?
                        ImageIcon(
                          AssetImage("assets/images/ic_nav_main/menubar_discovery-ac@2x.png"  ),
                          size: config.App(context).appWidth(6.3),
                        ) : ImageIcon(
                          AssetImage("assets/images/ic_nav_main/menubar_discovery@2x.png"  ),
                          size: config.App(context).appWidth(6.3),
                        ),
                        title: new Text(
                          "Discovery",
                          style: TextStyle(
                          ),
                        )),
                    new BottomNavigationBarItem(
                        icon: Container(
                          height: config.App(context).appWidth(6.3),
                          width: config.App(context).appWidth(6.3),
                          padding: widget.selectedTab == 4 ? const EdgeInsets.all(2.0) : const EdgeInsets.all(0.0),
                          decoration: BoxDecoration(
                            color: widget.selectedTab == 4 ? Theme.of(context)
                                .accentColor
                                .withOpacity(1.0) : Theme.of(context)
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

                          child: MyCircleAvatar(
                            imgUrl: Member.photoUrl,
                            width: config.App(context).appWidth(6.0),
                            height: config.App(context).appWidth(6.0),
                          ),

                        ),
                        title: new Text(
                            "Account",
                            style: TextStyle(
                            )
                        ))
                  ]
              ),
            )
        )
    );
  }


}
