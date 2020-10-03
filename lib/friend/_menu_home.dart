
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../config/app_config.dart' as config;
import 'menu/_friend_list.dart';
import 'menu/_group_list.dart';
import 'menu/_official_list.dart';



class MenuHomeItemWidget extends StatelessWidget {

  Map<String, dynamic> obj_arr;

  MenuHomeItemWidget({
    Key key,
    this.obj_arr,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return InkWell(
      onTap: (){
        on_action(context,obj_arr["id"]);
      },
      child: Container(
          margin: const EdgeInsets.only(right: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                height: 50,
                width: 50,
                margin: const EdgeInsets.only(left: 5, bottom: 10),
                padding: const EdgeInsets.all(0.0),
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                        colors: [config.HexColor("#CEE6E6"), config.HexColor("#CEE6E6")]
                        ),

                  // borderRadius: BorderRadius.circular(18),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                        color: Theme.of(context)
                            .hintColor
                            .withOpacity(0.15),
                        offset: Offset(0, 1),
                        blurRadius: 4
                    )
                  ],
                  image: new DecorationImage(
                    image: new AssetImage(obj_arr["imgUrl"]),
                    fit: BoxFit.contain,
                  ),
                ),

                // child: Image(
                //     image: new AssetImage(obj_arr["imgUrl"]),
                // ),

              ),
              Container(
                  child: Center(
                    child: Text(
                      obj_arr["name"],
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: Colors.black87
                      ),
                    ),
                  )
              )

            ],
          )
      ),
    );


  }

  on_action(BuildContext context,String _i){

    if(_i == "1"){
      Navigator.of(context).push(PageRouteBuilder(
          opaque: false,
          pageBuilder: (BuildContext context, _, __) => MyFriendWidget()
        )
      );
    }
    else if(_i == "2")
      {
        Navigator.of(context).push(PageRouteBuilder(
            opaque: false,
            pageBuilder: (BuildContext context, _, __) => MyGroupFriendWidget()
         )
        );
      }
    else if(_i == "3"){
      Navigator.of(context).push(PageRouteBuilder(
          opaque: false,
          pageBuilder: (BuildContext context, _, __) => MyOfficialsWidget()
       )
      );
    }
    else {
      Navigator.of(context)
          .pushNamed('/page_error', arguments: 1);
    }


  }


}
