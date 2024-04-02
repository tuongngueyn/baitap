import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('nguyen van tuong : 20212616'),
        ),
        body: Container(
          alignment: Alignment.bottomCenter,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.call),
                    color: Colors.teal,
                    onPressed: () {
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.navigation),
                    color: Colors.teal,
                    onPressed: () {
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.share),
                    color: Colors.teal,
                    onPressed: () {
                    },
                  ),
                ],
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}