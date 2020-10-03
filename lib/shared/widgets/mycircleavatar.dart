import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../waiting_Image.dart';

class MyCircleAvatar extends StatelessWidget {
  final String imgUrl;
  final double width;
  final double height;


  const MyCircleAvatar({
    Key key,
    @required this.imgUrl,
    @required this.width,
    @required this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: Colors.white,
          width: 0,
        ),
      ),
      child: imgUrl != null && imgUrl != "" ? CachedNetworkImage(
        imageUrl: "$imgUrl",
        fit: BoxFit.cover,
        imageBuilder: (context, imageProvider) => Container(
          child: CircleAvatar(
            backgroundImage: NetworkImage(
                "$imgUrl"
            ),
          ),
        ),
        placeholder: (context, url) =>  CircleAvatar(
          backgroundImage: Image.asset('assets/images/icons/loadingimg.png',fit: BoxFit.fill,color: Colors.blueGrey.withOpacity(0.3)).image,
        ),
        errorWidget: (context, url, error) {
          return Container(
            child: CircleAvatar(
              backgroundImage: Image.asset('assets/images/icons/loadingimg.png',fit: BoxFit.fill,color: Colors.blueGrey.withOpacity(0.3)).image,
            ),
          );
        },
      ) : Container(
        width: width,
        height: height,
        child: CircleAvatar(
          backgroundImage: Image.asset('assets/images/icons/loadingimg.png',fit: BoxFit.fill,color: Colors.blueGrey.withOpacity(0.3)).image,
        ),
      ),

//      CircleAvatar(
//        backgroundImage: NetworkImage("$imgUrl"),
//      ),


    );
  }
}
