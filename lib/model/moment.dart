import 'package:chatty/services/_moment.dart';

class Moment {

  String MomentID;
  String LogoMoment;
  String ImageMoment;
  String Title;
  String Message;
  List Like = [];
  DateTime CreateDatetime;
  DateTime UpdateDatetime;

  Moment.init();

  Map<String, dynamic> toJson() =>
      {
        'MomentID': MomentID,
        'LogoMoment': LogoMoment,
        'ImageMoment': ImageMoment,
        'Title': Title,
        'Message': Message,
        'Like': Like,
        'CreateDateTime': CreateDatetime,
        'UpdateDateTime': UpdateDatetime
      };

  Future get_list_moments() async{
    var list = await MommentService.load_moments();
    return list;
  }


}

