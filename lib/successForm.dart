//Page is displayed when the data is submitted successfully.
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Screen1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final unit = MediaQuery.of(context).size.width * 0.95;

    return Scaffold(
        backgroundColor: Color.fromRGBO(236, 219, 218, 1),
        appBar: AppBar(
          title: Text('Data Submitted'),
        ),
        body: Center(
          child: Column(children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              //ROW 1
              children: [
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 25.0),
                  child: Image(
                    height: unit / 1.2,
                    width: unit / 1.2,
                    image: AssetImage('images/submit_image.jpg'),
                  ),
                ),
              ],
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 20),
              child: Text(
                'Note: The values entered may take more time for updating when viewed through Mobile Phone.',
                textAlign: TextAlign.justify,
                style: TextStyle(fontSize: 17),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
              child: Text(
                'For better results, view the google sheet from PC/Desktop/Laptop.',
                textAlign: TextAlign.justify,
                style: TextStyle(fontSize: 17),
              ),
            ),
            Row(
                //ROW 2
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  RaisedButton(
                    child: Text('View Sheet'),
                    color: Colors.brown,
                    textColor: Colors.white,
                    shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(10.0),
                    ),
                    onPressed: () {
                      launch('https://bit.ly/3uEcS2x');
                      Navigator.pop(context);
                    },
                  ),
                  RaisedButton(
                    child: Text('Go back'),
                    color: Colors.green,
                    textColor: Colors.white,
                    shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(10.0),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ]),
          ]),
        ));
  }
}
