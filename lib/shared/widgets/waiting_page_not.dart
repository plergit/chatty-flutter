import 'package:flutter/material.dart';


class WaitingImageComingsoon extends StatelessWidget {


  const WaitingImageComingsoon({
    Key key,

  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return  Center(
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
                        .withOpacity(0.0),
                    offset: Offset(0, 0),
                    blurRadius: 0)
              ],
            ),
            child:  Image(
              image: new AssetImage("assets/images/icons/icon-comingsoon.png"),
            )
        ),
      ),
    );
  }
}