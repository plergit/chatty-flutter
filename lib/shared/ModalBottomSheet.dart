import 'package:flutter/material.dart';
import 'RaisedGradientButton.dart';
import '../config/app_config.dart' as config;

class modalBottomCostom extends StatelessWidget {



  String typeModel;
  BuildContext context;
  IconData iconIn;
  Color colorIcon;
  Color colorBg;
  String title;
  String description;

  modalBottomCostom
      ({
      this.typeModel,
      this.context,
      this.iconIn : Icons.error_outline,
      this.colorIcon : Colors.white,
      this.colorBg: Colors.white,
      this.title,
      this.description
      });

  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;


    var widget;

    if (typeModel == "success") {
      widget = popupBottomAlertSuccess();
    } else if (typeModel == "warning") {
      widget = popupBottomAlertError();
    } else if (typeModel == "error") {
      widget = popupBottomAlertError();
    } else if (typeModel == "confirm") {
      widget = modalBottomConfirm();
    } else {
      widget = Container();
    }

    return widget;
  }

  Widget popupBottomAlertSuccess() {
    var sizeHeader = (MediaQuery.of(context).size.width);

    return Container(

      child: new Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.4,
            margin: const EdgeInsets.only(
              top: 0,
            ),
            padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor.withOpacity(1.0),
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20)
              ),
            ),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[

                Container(
                  width: sizeHeader,
                  child: Align(
                      alignment: Alignment.center,
                      child: Container(
                        width: sizeHeader / 4,
                        height: sizeHeader / 4,
                        decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                  color: Theme.of(context)
                                      .hintColor
                                      .withOpacity(0.4),
                                  offset: Offset(0, 0),
                                  blurRadius: 0)
                            ]),
                        child:  Stack(
                          children: [

                            Positioned(
                                left: 0,
                                right: 0,
                                top: 0,
                                bottom: 0,
                                child:Container(
//                                width: sizeHeader / 4,
//                                height: sizeHeader / 4,
                                  decoration: BoxDecoration(
                                      color: Colors.green[50],
                                      shape: BoxShape.circle,
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.green[400].withOpacity(0.4),
                                            offset: Offset(0, 0),
                                            blurRadius: 10)
                                      ]),
                                )

                            ),
                            Positioned(
                                left: 8,
                                right: 8,
                                top: 8,
                                bottom: 8,
                                child:Container(
//                                width: sizeHeader / 4,
//                                height: sizeHeader / 4,
                                  decoration: BoxDecoration(
                                      color: Colors.green[100],
                                      shape: BoxShape.circle,
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.green[400].withOpacity(0.4),
                                            offset: Offset(0, 0),
                                            blurRadius: 10)
                                      ]),
                                )

                            ),
                            Positioned(
                                left: 16,
                                right: 16,
                                top: 16,
                                bottom: 16,
                                child:Container(
//                                width: sizeHeader / 4,
//                                height: sizeHeader / 4,
                                  decoration: BoxDecoration(
                                      color: Colors.green[200],
                                      shape: BoxShape.circle,
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.green[400].withOpacity(0.4),
                                            offset: Offset(0, 0),
                                            blurRadius: 0)
                                      ]),
                                )

                            ),
                            Positioned(
                              left: 16,
                              right: 16,
                              top: 16,
                              bottom: 16,
                              child : Container(
                                decoration: BoxDecoration(
                                    color: Colors.green[400],
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.green[400].withOpacity(0.4),
                                          offset: Offset(0, 0),
                                          blurRadius: 10)
                                    ]),
                                child:  Icon(
                                  Icons.check,
                                  color: Colors.white,
                                  size: 50,
                                ),
                              ),

                            ),

                          ],
                        ),
                      )


                  ),
                ),
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(left: 8, right: 8,top: 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          title,
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(height: 10.0),
                        Text(
                          description,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 15.0,
                          ),
                        ),
                      ],
                      //                                  color: Colors.blue,
                    ),
                  ),
                ),
                Container(
                  height: 2.0,
                  margin: EdgeInsets.only(top: 4, bottom: 2, left: 8, right: 8),
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(
                        color: Theme.of(context).focusColor,
                        width: 0.5,
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 20, top: 5),
                  height: 55,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    //                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      SizedBox(
                        width: 15,
                      ),
                      Expanded(
                        child:  InkWell(
                            child: Container(
                                width: 200,
                                child: Text(
                                    "ตกลง",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontSize: 16, color: config.HexColor("#60B7B5"))
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  color: config.HexColor("#F1F1F1"),
                                ),
                                margin: EdgeInsets.only(top: 0),
                                padding: EdgeInsets.all(12)
                            ),
                            onTap: () {

                              Navigator.pop(context, {
                                "action": "ok",
                              });

                            }),

                      ),
                      SizedBox(
                        width: 15,
                      ),

                      //                              ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget popupBottomAlertError() {
    var sizeHeader = (MediaQuery.of(context).size.width);

    return Container(

      child: new Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.4,
            margin: const EdgeInsets.only(
              top: 0,
            ),
            padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor.withOpacity(1.0),
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20)
              ),
            ),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[

                Container(
                  width: sizeHeader,
                  child: Align(
                      alignment: Alignment.center,
                      child: Container(
                        width: sizeHeader / 4,
                        height: sizeHeader / 4,
                        decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                  color: Theme.of(context)
                                      .hintColor
                                      .withOpacity(0.4),
                                  offset: Offset(0, 0),
                                  blurRadius: 0)
                            ]),
                        child:  Stack(
                          children: [

                            Positioned(
                                left: 0,
                                right: 0,
                                top: 0,
                                bottom: 0,
                                child:Container(
//                                width: sizeHeader / 4,
//                                height: sizeHeader / 4,
                                  decoration: BoxDecoration(
                                      color: Colors.red[50],
                                      shape: BoxShape.circle,
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.red[400].withOpacity(0.4),
                                            offset: Offset(0, 0),
                                            blurRadius: 10)
                                      ]),
                                )

                            ),
                            Positioned(
                                left: 8,
                                right: 8,
                                top: 8,
                                bottom: 8,
                                child:Container(
//                                width: sizeHeader / 4,
//                                height: sizeHeader / 4,
                                  decoration: BoxDecoration(
                                      color: Colors.red[100],
                                      shape: BoxShape.circle,
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.red[400].withOpacity(0.4),
                                            offset: Offset(0, 0),
                                            blurRadius: 10)
                                      ]),
                                )

                            ),
                            Positioned(
                                left: 16,
                                right: 16,
                                top: 16,
                                bottom: 16,
                                child:Container(
//                                width: sizeHeader / 4,
//                                height: sizeHeader / 4,
                                  decoration: BoxDecoration(
                                      color: Colors.red[200],
                                      shape: BoxShape.circle,
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.red[400].withOpacity(0.4),
                                            offset: Offset(0, 0),
                                            blurRadius: 0)
                                      ]),
                                )

                            ),
                            Positioned(
                              left: 16,
                              right: 16,
                              top: 16,
                              bottom: 16,
                              child : Container(
                                decoration: BoxDecoration(
                                    color: colorIcon,
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.red[400].withOpacity(0.4),
                                          offset: Offset(0, 0),
                                          blurRadius: 10)
                                    ]),
                                child:  Icon(
                                  Icons.priority_high,
                                  color: Colors.white,
                                  size: 35,
                                ),
                              ),

                            ),

                          ],
                        ),
                      )


                  ),
                ),
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(left: 8, right: 8,top: 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          title,
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(height: 10.0),
                        Text(
                          description,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 15.0,
                          ),
                        ),
                      ],
                      //                                  color: Colors.blue,
                    ),
                  ),
                ),
                Container(
                  height: 2.0,
                  margin: EdgeInsets.only(top: 4, bottom: 2, left: 8, right: 8),
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(
                        color: Theme.of(context).focusColor,
                        width: 0.5,
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 20, top: 5),
                  height: 55,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    //                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      SizedBox(
                        width: 15,
                      ),
                      Expanded(
                        child:  InkWell(
                            child: Container(
                                width: 200,
                                child: Text(
                                    "ตกลง",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontSize: 16, color: config.HexColor("#60B7B5"))
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  color: config.HexColor("#F1F1F1"),
                                ),
                                margin: EdgeInsets.only(top: 0),
                                padding: EdgeInsets.all(12)
                            ),
                            onTap: () {

                              Navigator.pop(context, {
                                "action": "ok",
                              });

                            }),

                      ),
                      SizedBox(
                        width: 15,
                      ),

                      //                              ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget modalBottomConfirm() {

    var sizeHeader = (MediaQuery.of(context).size.width);

    var sizeBottom = (MediaQuery.of(context).padding.bottom);

    return Container(
      child: new Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            //height: MediaQuery.of(context).size.height,
            height: MediaQuery.of(context).size.height * 0.4,
            margin: const EdgeInsets.only(
              top: 0,
            ),
            padding: const EdgeInsets.only(top: 25, left: 10, right: 10),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor.withOpacity(1.0),
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15)
              ),
            ),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  width: sizeHeader,
                  child: Align(
                    alignment: Alignment.center,
                    child: Container(
                      width: sizeHeader / 4,
                      height: sizeHeader / 4,
                      decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                                color: Theme.of(context)
                                    .hintColor
                                    .withOpacity(0.4),
                                offset: Offset(0, 0),
                                blurRadius: 0)
                          ]),
                      child:  Stack(
                        children: [

                          Positioned(
                              left: 0,
                              right: 0,
                              top: 0,
                              bottom: 0,
                              child:Container(
//                                width: sizeHeader / 4,
//                                height: sizeHeader / 4,
                                decoration: BoxDecoration(
                                    color: Colors.green[50],
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.green[400].withOpacity(0.4),
                                          offset: Offset(0, 0),
                                          blurRadius: 10)
                                    ]),
                              )

                          ),
                          Positioned(
                              left: 8,
                              right: 8,
                              top: 8,
                              bottom: 8,
                              child:Container(
//                                width: sizeHeader / 4,
//                                height: sizeHeader / 4,
                                decoration: BoxDecoration(
                                    color: Colors.green[100],
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.green[400].withOpacity(0.4),
                                          offset: Offset(0, 0),
                                          blurRadius: 10)
                                    ]),
                              )

                          ),
                          Positioned(
                              left: 16,
                              right: 16,
                              top: 16,
                              bottom: 16,
                              child:Container(
//                                width: sizeHeader / 4,
//                                height: sizeHeader / 4,
                                decoration: BoxDecoration(
                                    color: Colors.green[200],
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.green[400].withOpacity(0.4),
                                          offset: Offset(0, 0),
                                          blurRadius: 0)
                                    ]),
                              )

                          ),
                          Positioned(
                              left: 16,
                              right: 16,
                              top: 16,
                              bottom: 16,
                              child : Container(
                                decoration: BoxDecoration(
                                    color: Colors.green[400],
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.green[400].withOpacity(0.4),
                                          offset: Offset(0, 0),
                                          blurRadius: 10)
                                    ]),
                                child:  Icon(
                                  iconIn,
                                  color: Colors.white,
                                  size: 50,
                                ),
                              ),

                          ),

                        ],
                      ),
                    )


                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(height: 10.0),
                      Text(
                        description,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 13.0,
                        ),
                      ),
                    ],
                    //                                  color: Colors.blue,
                  ),
                ),
                Container(
                  height: 1.0,
                  margin:
                  EdgeInsets.only(top: 4, bottom: 4, left: 8, right: 8),
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(
                        color: Theme.of(context).focusColor,
                        width: 0.6,
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 5 , top: 10),
                  height: 45,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      SizedBox(
                        width: 15,
                      ),
                      Expanded(
                        child: InkWell(
                            child: Container(
                                width: 200,
                                child: Text(
                                    "ตกลง",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontSize: 16, color: config.HexColor("#60B7B5"))
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  color: config.HexColor("#F1F1F1"),
                                ),
                                margin: EdgeInsets.only(top: 0),
                                padding: EdgeInsets.all(12)
                            ),
                            onTap: () {

                              Navigator.pop(context, {
                                "confirm": "yes",
                              });

                            }),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Expanded(
                          child:  InkWell(
                              child: Container(
                                  width: 200,
                                  child: Text(
                                      "ยกเลิก",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(fontSize: 16, color: Colors.white)
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16),
//                                    color: config.HexColor("#FF732F"),
                                      gradient: LinearGradient(
                                          colors: [ config.HexColor("#FF3147") , config.HexColor("#FF732F")]
                                      )
                                  ),
                                  margin: EdgeInsets.only(top: 0),
                                  padding: EdgeInsets.all(12)
                              ),
                              onTap: () {

                                Navigator.pop(context, {
                                  "confirm": "no",
                                });

                              }),

                      ),
                      SizedBox(
                        width: 15,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: sizeBottom,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

}
