import 'package:flutter/material.dart';


class WaitingImageSearching extends StatelessWidget {


  const WaitingImageSearching({
    Key key,

  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return  Center(
      child: Container(

        alignment: AlignmentDirectional.center,
        decoration: new BoxDecoration(
          color: Colors.white
        ),
        child: Center(
          child: Container(
              width: 80,
              height: 80,
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
                image: new AssetImage("assets/images/icons/icon-search-not.png"),
              )
          ),
        )
      ),
    );
  }
}