
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../config/app_config.dart' as config;



class OfficialsItemWidget extends StatelessWidget {

  Map<String, dynamic> obj_arr;

  OfficialsItemWidget({
    Key key,
    this.obj_arr,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

//    print(obj_arr);

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
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        backgroundImage: AssetImage(obj_arr["img"])
                        // NetworkImage(obj_arr["img"]),
                      ),
                    ),

                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 5, bottom: 10),
                child: Text(
                  obj_arr["name"],
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),

            ],
          )
      ),
    );




  }
}


