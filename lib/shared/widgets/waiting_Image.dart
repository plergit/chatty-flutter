import 'package:flutter/material.dart';


class WaitingImage extends StatelessWidget {

  final Color backgroundColor;
  final Color foregroundColor;
  final double value;

  final double radiusTopLeft;
  final double radiusTopRight;
  final double radiusBottomLeft;
  final double radiusBottomRight;

  const WaitingImage({
    Key key,

    this.backgroundColor = Colors.black12,
    this.foregroundColor = Colors.black12,
    this.value,

    this.radiusTopLeft = 0.0,
    this.radiusTopRight = 0.0,
    this.radiusBottomLeft = 0.0,
    this.radiusBottomRight = 0.0,

  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return  Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius : BorderRadius.only(topLeft: Radius.circular(radiusTopLeft) , topRight: Radius.circular(radiusTopRight),
              bottomLeft : Radius.circular(radiusBottomLeft),bottomRight : Radius.circular(radiusBottomRight) ),
        ),

        child: Center(
          child: Container(
              margin: const EdgeInsets.only(bottom: 10, top: 10),
              height: 40.0,
              width: 40.0,
              child: Image.asset('assets/images/icons/loadingimg.png',fit: BoxFit.fill,color: Colors.blueGrey.withOpacity(0.3)
              )
            ),
        ),

    );
  }
}