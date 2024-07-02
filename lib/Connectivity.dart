import 'package:flutter/material.dart';
import 'package:connectivity_plus/Connectivity_plus.dart';
import 'dart:async'; // Import this for StreamSubscription

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ConnectivityWidget(),
    );
  }
}

class ConnectivityWidget extends StatefulWidget {
  @override
  _ConnectivityWidgetState createState() => _ConnectivityWidgetState();
}

class _ConnectivityWidgetState extends State<ConnectivityWidget> {
  late Connectivity _connectivity;
  late StreamSubscription<ConnectivityResult> _subscription;

  @override
  void initState() {
    super.initState();
    _connectivity = Connectivity();
    _subscription = _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    String message;
    if (result == ConnectivityResult.mobile || result == ConnectivityResult.wifi) {
      message = 'Internet Connected';
    } else {
      message = 'Internet Disconnected';
    }
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Connectivity Example')),
      body: Center(child: Text('Listen to connectivity changes')),
    );
  }
}
