import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';
class WorldTime{
  String time;
  String url;
  String flag; //for background image
  String location;
  bool isDayTime = false;
  WorldTime({this.location , this.flag , this.url});

  Future<void> getTime() async{
    try{
      // make the request
      Response response = await get('http://worldtimeapi.org/api/timezone/$url');
      Map data = jsonDecode(response.body);

      // get properties from json
      String datetime = data['datetime'];
      String offset = data['utc_offset'];
      // create DateTime object
      DateTime now = DateTime.parse(datetime);
      String hours = offset.substring(1,3);
      String minutes;
      print(now);
      if(offset[0]=='-'){
        now = now.subtract(Duration(hours: int.parse(hours)));
        if (offset.length >= 3){
          minutes = offset.substring(4,6);
          now = now.subtract(Duration(minutes: int.parse(minutes)));
        }
      }
      else{
        now = now.add(Duration(hours: int.parse(hours)));
        if (offset.length >= 3){
          minutes = offset.substring(4,6);
          now = now.add(Duration(minutes: int.parse(minutes)));
        }
      }
      print(now);
      print(offset);
      // set the time property
      isDayTime = now.hour > 6 && now.hour < 20 ? true : false;
      time = DateFormat.jm().format(now);
    }
    catch (e) {
      print(e);
      time = 'Could not get time';
    }

  }
}