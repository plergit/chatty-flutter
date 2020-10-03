
import 'package:chatty/shared/widgets/mycircleavatar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../config/app_config.dart' as config;



class GroupItemWidget extends StatelessWidget {

  Map<String, dynamic> obj_arr;

  GroupItemWidget({
    Key key,
    this.obj_arr,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

   // print(obj_arr);

    return Container(
      child: Container(
          margin: const EdgeInsets.only(right: 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                height: 55,
                width: 55,
                margin: const EdgeInsets.only(left: 5, bottom: 10),
                padding: const EdgeInsets.all(4.0),
                decoration: BoxDecoration(
                ),
                child:  Stack(
                  children: <Widget>[
                    SizedBox(
                      width: 50,
                      height: 50,
                      child: MyCircleAvatar(
                        imgUrl: obj_arr["RoomImgUrl"],
                        width: 50,
                        height: 50,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 5, bottom: 10),
                child: Text(
                  obj_arr["RoomName"],
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: Colors.black
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 5, bottom: 10),
                child: Text(
                  " (${obj_arr["MemberInfo"].length})",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              )

            ],
          )
      ),
    );




  }
}


