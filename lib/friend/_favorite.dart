import 'package:chatty/shared/widgets/mycircleavatar.dart';
import 'package:flutter/material.dart';




class FavoriteItemWidget extends StatelessWidget {

  Map<String, dynamic> obj_arr;

  FavoriteItemWidget({
    Key key,
    this.obj_arr,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

   // print(obj_arr["friend_info"]);

    var _info = obj_arr["friend_info"];

    return Container(
      child: Container(
          margin: const EdgeInsets.only(right: 10),
          child: Column(
            children: <Widget>[
              Container(
                height: 60,
                width: 60,
                margin: const EdgeInsets.only(left: 5, bottom: 10,top: 10),
                padding: const EdgeInsets.all(2.0),
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
                    SizedBox(
                      width: 60,
                      height: 60,
                      child: MyCircleAvatar(
                        imgUrl: _info["ImgUrl"],
                        width: 60,
                        height: 60,
                      ),

//                      CircleAvatar(
//                        backgroundColor: Colors.white,
//                        backgroundImage: NetworkImage(
//                            _info["imgUrl"]),
//                      ),
                    ),
                    Positioned(
                      top: 3,
                      right: 3,
                      width: 12,
                      height: 12,
                      child: Container(
                        decoration: BoxDecoration(
//                    color: widget.message.user.userState == UserState.available
//                        ? Colors.green
//                        : widget.message.user.userState == UserState.away ? Colors.orange : Colors.red,
                          color:  Colors.green,
                          shape: BoxShape.circle,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                child: Text(
                  _info["FullName"],
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87
                  ),
                ),
              )
            ],
          )
      ),
    );
  }
}


