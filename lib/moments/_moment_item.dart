import 'package:chatty/shared/widgets/mycircleavatar.dart';
import 'package:flutter/material.dart';
//import 'package:cached_network_image/cached_network_image.dart';
import '../shared/waiting_Image.dart';
import '../model/moment.dart';

class MomentItemMain extends StatelessWidget {


  Map<String, dynamic> message;
  MomentItemMain({Key key, this.message}) : super(key: key);

//  Review review;

  @override
  Widget build(BuildContext context) {

    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    // print(message);

    return InkWell (

      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          border: Border(
            bottom: BorderSide(
              color: Colors.black26,
              width: 0.4,
            ),
          ),
        ),

        margin: EdgeInsets.only(left: 0, right: 0,top: 4,bottom: 4),
        padding: EdgeInsets.only(left: 0, right: 0,top: 10,bottom: 15),

        child: Column(

          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,

          children: <Widget>[

            Container(
              height: 45,
              width: width-25,
              child: Column(
                   crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
              Container(
              margin : EdgeInsets.only(left: 5,right: 0),
            child: Row(
              children: <Widget>[
                Container(
                  width: 40,
                  height: 40,
                  margin : EdgeInsets.only(left: 0,right: 10),
                  child: SizedBox(
                    child: MyCircleAvatar(
                      imgUrl: message["LogoMoment"],
                      width: 40,
                      height: 40,
                    )
                  ),
                ),
                Expanded(
                  child: Container(
                    height: 40,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          message["Title"],
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontSize: 15.0,
                              fontWeight: FontWeight.w600,
                              color: Colors.black54),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(right: 10,top: 5),
                  child:  Icon(
                    Icons.more_horiz,
                    color: Colors.black54,
                    size: 20,
                  ),
                )
              ],
            )
        ),

              ]),
            ),

            SizedBox(height : 5),
            Container(
              height: 220,
              child: myPhotoList(message["ImageMoment"][0]),
            ),
            SizedBox(height : 5),
            Container(
              padding: EdgeInsets.only(left: 10, right: 10,top: 4,bottom: 4),
              child: Text(
                message["Message"],
                style: TextStyle(
                  fontSize: 13
                ),
                overflow: TextOverflow.fade,
//                  softWrap: false,
              ),

            ),
            SizedBox(height : 5),
            Container(
              height: 30,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

                  IconButton(
                    padding: EdgeInsets.only(left: 10,right: 5),
                    onPressed:  ()  {

//                    Navigator.of(context)
//                                    .pushNamed('/add_friend', arguments: 1);

                    },
                    icon: Icon(
                      Icons.favorite_border,
                      color: Theme.of(context).focusColor,
                      size: 25,
                    ),
                  ),

                  InkWell(
                      child: Container(
                          width: 70,
                          margin : EdgeInsets.only(right: 10 ,left: 10),
                          child: Text("12 Like",
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 15, color: Colors.black45)),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(0),
                            color: Colors.transparent,
                          ),
                      ),
                      onTap: () {
//                                  Navigator.push(
//                                      context, MaterialPageRoute(builder: (context) => SignUpWidget()));
                      }),

                ],
              ),
            )


          ],
        ),




      )

    );



  }


  Widget myPhotoList(String MyImages) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.fill,
          image: NetworkImage(
              MyImages),
        ),
      ),

    );
  }


}


