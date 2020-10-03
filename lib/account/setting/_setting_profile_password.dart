
import 'package:chatty/shared/ModalBottomSheet.dart';
import 'package:flutter/material.dart';

class SettingProfilePasswordWidget extends StatefulWidget {

  @override
  _SettingProfilePasswordState createState() => new _SettingProfilePasswordState();
}

class _SettingProfilePasswordState extends State<SettingProfilePasswordWidget> {

  @override
  void initState() {
    super.initState();
  }


  TextEditingController usernameController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(" ", style: TextStyle(color: Colors.black54)),
        ),
        body: new GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus(new FocusNode());
            },
            child: Container(
              color: Colors.green[50],
//                child:
            )
        )
    );
  }









  void _modalAlertSuccess(context, String title, String description) {

    showModalBottomSheet(
        context: context,
        isDismissible: false,
        elevation: 0,
        useRootNavigator: false,
        backgroundColor: Colors.transparent,
        builder: (BuildContext bc) {
          return modalBottomCostom(
            typeModel: "success",
            context: context,
            title: title,
            description: description,
            iconIn: Icons.check_circle,
            colorIcon: Colors.green,
          );
        }).then((val) {

      Navigator.pop(context);


      print(val);

    });
    ;
  }


  void _modalAlertError(context, String title, String description)  {
    showModalBottomSheet(
        context: context,
        isDismissible: false,
        elevation: 0,
        useRootNavigator: false,
        backgroundColor: Colors.transparent,
        builder: (BuildContext bc) {
          return modalBottomCostom(
            typeModel: "error",
            context: context,
            title: title,
            description: description,
            iconIn: Icons.error,
            colorIcon: Colors.red,
          );
        }).then((val) {
//        return val;
    });
  }

}


