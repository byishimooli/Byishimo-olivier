import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BatteryWidget(),
    );
  }
}

class BatteryWidget extends StatefulWidget {
  @override
  _BatteryWidgetState createState() => _BatteryWidgetState();
}

class _BatteryWidgetState extends State<BatteryWidget> {
  static const batteryChannel = EventChannel('com.example.BroadcastReceiver/battery');
  String _batteryStatus = 'Battery status: unknown';

  @override
  void initState() {
    super.initState();
    batteryChannel.receiveBroadcastStream().listen((event) {
      setState(() {
        _batteryStatus = event;
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(_batteryStatus)));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Battery is running out')),
      body: Center(child: Text(_batteryStatus)),
    );
  }
}
