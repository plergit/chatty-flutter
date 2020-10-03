
import 'package:chatty/shared/widgets/mycircleavatar.dart';
import 'package:flutter/material.dart';




class FriendItemWidget extends StatelessWidget {

  Map<String, dynamic> obj_arr;

  FriendItemWidget({
    Key key,
    this.obj_arr,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

//    print(obj_arr);

    return Container(

      decoration: BoxDecoration(
//        color: Colors.transparent,
        color: Theme.of(context).primaryColor.withOpacity(1.0),
        border: Border(
          bottom: BorderSide(
            color: Colors.black26,
            width: 0.4,
          ),
        ),
      ),
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Stack(
            children: <Widget>[
              SizedBox(
                width: 50,
                height: 50,
                child: MyCircleAvatar(
                  imgUrl: obj_arr["ImgUrl"],
                  width: 50,
                  height: 50,
                ),


              ),
//               Positioned(
//                 top: 3,
//                 right: 3,
//                 width: 12,
//                 height: 12,
//                 child: Container(
//                   decoration: BoxDecoration(
// //                    color: widget.message.user.userState == UserState.available
// //                        ? Colors.green
// //                        : widget.message.user.userState == UserState.away ? Colors.orange : Colors.red,
//                     color:  Colors.green,
//                     shape: BoxShape.circle,
//                   ),
//                 ),
//               )
            ],
          ),
          SizedBox(width: 10),
          Flexible(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[

                Expanded(
                  child: Container(
                    height: 50,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Expanded(
                          child: Text(
                            obj_arr["FullName"],
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
                        ),
                        Expanded(
                          child: Text(
                            obj_arr["StatusProfile"] != null ? obj_arr["StatusProfile"] : "",
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            style: Theme.of(context).textTheme.caption.merge(
                                TextStyle(fontWeight: FontWeight.w300 )),
                          ),
                        ),


                      ],
                    ),
                  )
                ),
                SizedBox(width: 5),
              ],
            ),
          )
        ],
      ),
    );




  }
}


