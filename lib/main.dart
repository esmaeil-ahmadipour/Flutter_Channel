import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _batteryPercentage = "Battery Percentage";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("MyApp with Android Channel"),
      ),
      body: Container(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            MaterialButton(
              shape: RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(16.0),
                side: BorderSide(color: Colors.blueAccent[700],width: 2.0),
              ),
              padding: EdgeInsets.all(8.0),
              splashColor: Colors.blueAccent,
              onPressed: _getBatteryInformation,
              color: Colors.blueAccent[700],
              child: Text(
                "Get Battery Info !",
                style: TextStyle(fontSize: 32),
              ),
            ),
            Container(
              child: Text(
                _batteryPercentage,
                style: TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }

  static const batteryChannel = const MethodChannel("battery");

  Future<void> _getBatteryInformation() async {
    String batteryPercentage;

    try {
      var result = await batteryChannel.invokeMethod('getBatteryLevel');
      batteryPercentage = "Battery level at $result %";
    } on PlatformException catch (e) {
      batteryPercentage = "Failed to get battery level :: ${e.message} %";
    }

    setState(() {
      _batteryPercentage = batteryPercentage;
    });
  }
}
