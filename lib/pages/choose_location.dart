import 'package:flutter/material.dart';
import 'package:world_time/services/world_time.dart';
import 'package:world_time/services/list_of_cities.dart';
class ChooseLocation extends StatefulWidget {
  @override
  _ChooseLocationState createState() => _ChooseLocationState();
}

class _ChooseLocationState extends State<ChooseLocation> {

//list of cities are here

  Future<void> updateTime(index) async{
    WorldTime instance = locations[index];
    await instance.getTime();
    Navigator.pop(context, {'location' : instance.location,
      'flag' : instance.flag,
      'time' : instance.time,
      'isDayTime' : instance.isDayTime,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text('Choose Location'),
        centerTitle: true,
        backgroundColor: Colors.blueGrey[900],

      ),
      body : Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4.0 , vertical: 1.0),
        child: ListView.builder(
            itemCount: locations.length,
            itemBuilder: (context , index)=>Card(
              child : ListTile(
                onTap: () async{
                  await updateTime(index);
                },
                title: Text(locations[index].location),
                leading: Padding(
                  padding: const EdgeInsets.fromLTRB(6, 0, 0, 0),
                  child: CircleAvatar(
                      backgroundImage : AssetImage('assets/${locations[index].flag}'),
                  ),
                ),
              )
            ),
        ),
      ),
    );
  }
}

