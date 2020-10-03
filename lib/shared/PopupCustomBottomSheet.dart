import 'package:flutter/material.dart';
import 'RaisedGradientButton.dart';

class PopupCostomSelect extends StatelessWidget {


  BuildContext context;
  IconData iconIn;
  Color colorIcon;
  Color colorBg;
  String title;
  var arr_list = [];

  PopupCostomSelect({
      this.arr_list,
      this.context,
      this.iconIn: Icons.error_outline,
      this.colorIcon: Colors.white,
      this.colorBg: Colors.white,
      this.title,
      });

  Widget build(BuildContext context) {
      return modalBottom();
      }

  Widget modalBottom() {

    var sizeHeader = (MediaQuery.of(context).size.width);

    return Container(
//    height: MediaQuery.of(context).size.height * 0.4,
      child: new Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        children: <Widget>[
          Container(
              child: Stack(
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width,
//                          height: MediaQuery.of(context).size.height,
                    height: MediaQuery.of(context).size.height * 0.355,
                    margin: const EdgeInsets.only(
                      top: 0,
                    ),
                    padding: const EdgeInsets.only(top: 5, left: 8, right: 8),
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor.withOpacity(1.0),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(25),
                          topRight: Radius.circular(25)),
                    ),

                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[


                        Container(
                          height: 50,
                          margin: EdgeInsets.only(left: 5, right: 5, top: 0, bottom: 0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Expanded(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      SizedBox(width: 5),
                                      Icon(
                                        iconIn,
                                        color: Theme.of(context).hintColor.withOpacity(0.6),
                                        size: 20,
                                      ),
                                      SizedBox(width: 10),
                                      Text(title,
                                          style: TextStyle(
                                            fontSize: 15,
                                            color:
                                            Theme.of(context).hintColor.withOpacity(0.8),
                                          )),
                                    ],
                                  )
                              ),
                            ],
                          ),
                        ),


                        Container(
                          height: 2.0,
                          margin:
                          EdgeInsets.only(top: 4, bottom: 2, left: 5, right: 5),
                          decoration: BoxDecoration(
                            border: Border(
                              top: BorderSide(
                                color: Theme.of(context).focusColor,
                                width: 0.5,
                              ),
                            ),
                          ),
                        ),

                        Expanded(
                          child: Container(
                            margin: const EdgeInsets.only(left: 5, right: 5),
                            child: ListView.separated(
                              itemCount: arr_list.length,
                              itemBuilder: (context, index) {

                              final _name = arr_list[index];

//                              print(_arr);

                               return InkWell(
                                  onTap: () {
//                                    print(' $index');
                                    Navigator.pop(context, {
                                      "index": index,
                                      "name": _name,
                                    });
                                  },
                                  child: Container(
                                      padding: const EdgeInsets.only(left: 5, right: 5 , top: 5, bottom: 5),
                                      child:   Text(' $_name')
                                  ),
                                );

                              },
                              separatorBuilder: (context, index)=>Divider(
                                color: Colors.black12,
                              ),
                            ),

                          ),
                        ),


                      ],
                    ),
                  ),

                ],
              )),
        ],
      ),
    );


  }


}
