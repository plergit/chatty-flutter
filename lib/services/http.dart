import 'dart:convert';
import 'package:http/http.dart' as Http;



mixin httpService {

  static String urlsServer = "https://us-central1-chatty-838c4.cloudfunctions.net";
  // static String urlsServer = "http://192.168.1.23:5001/chatty-838c4/us-central1";

  static Future<dynamic> http_post(String _url,Map<String, dynamic> _req) async {
    var body = json.encode(_req);
    var url = urlsServer+"/"+_url;

    var response = await Http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: body
    ).timeout(const Duration(seconds: 5)).then((response) {

      var res = <String, dynamic>{
        "data": response.body,
        "code": 202
      };
      return res;
    }).catchError((err){

      var res = <String, dynamic>{
        "data": "เกิดข้อผิดพลาด กรุณาลองใหม่อีกครั้ง",
        "code": 505
      };
      return res;
    });

    return response;
  }

  static Future<dynamic> http_get(String _url,Map<String, dynamic> _req) async {
    var body = json.encode(_req);
    var url = urlsServer+"/"+_url+"?"+body;
    var response = await Http.get(
        url,
        headers: {"Content-Type": "application/json"},
    ).timeout(const Duration(seconds: 5)).then((response) {
      var res = <String, dynamic>{
        "data": response.body,
        "code": 202
      };
      return res ;
    }).catchError((err){
      var res = <String, dynamic>{
        "data": "เกิดข้อผิดพลาด กรุณาลองใหม่อีกครั้ง",
        "code": 505
      };
      return res;
    });

    return response;
  }



}