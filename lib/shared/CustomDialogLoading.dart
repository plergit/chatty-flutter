import 'package:flutter/material.dart';


class Consts {
  Consts._();

  static const double padding = 8.0;
  static const double avatarRadius = 55.0;
}

class CustomDialogLoading extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Consts.padding),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: dialogContent(context),
    );
  }

  dialogContent(BuildContext context) {

    return Center(
      child: Container(
//        height: 90.0,
//        width: 90.0,
        child: Image.asset(
          "assets/images/icons/loadingimg.png",
          height: 55.0,
          width: 55.0,
        ),
      ),
    );

  }



}