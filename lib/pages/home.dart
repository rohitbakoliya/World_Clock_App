import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  Map data = {};
  @override
  Widget build(BuildContext context) {

    data = data.isNotEmpty ? data : ModalRoute.of(context).settings.arguments;
    print(data);

    String bgImage = data['isDayTime'] ? 'day1.jpg' : 'night1.jpg';
    Color bgColor = data['isDayTime'] ? Colors.blue : Colors.indigo[700];
    return Scaffold(
      backgroundColor: bgColor,
      body: Container(
        decoration : BoxDecoration(
          image: DecorationImage(
              image : AssetImage('assets/$bgImage'),
              fit : BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0.0 , 120.0 , 0 , 0),
          child: SafeArea(
              child: Column(
                children: <Widget>[
                   FlatButton.icon(
                       onPressed: () async{
                         dynamic result = await Navigator.pushNamed(context, '/location');
                         setState(() {
                           data = {
                             'time' : result['time'],
                             'location' : result['location'],
                             'isDayTime' : result['isDayTime'],
                             'flag' : result['flag'],
                           };
                         });
                       },
                       icon: Icon(Icons.edit_location,
                       size: 30.0,
                       color: Colors.grey[300],
                       ),
                       label: Text('Edit Location' ,
                       style: TextStyle(
                           color: Colors.grey[300],
                           fontSize: 18.0
                       ),
                       )
                   ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                     children: <Widget>[
                         Text(
                           data['location'],
                           style : TextStyle(
                             fontSize : 28,
                             color: Colors.white,
                             letterSpacing: 2.0,
                           )
                         )
                       ],
                    ),
                    SizedBox(height: 20),
                    Text(
                      data['time'],
                      style: TextStyle(
                        fontSize: 65.0,
                        color : Colors.white,
                      ),
                    )
                ],
              )
          ),
        ),
      ),
    );
  }
}
