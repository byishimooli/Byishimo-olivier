import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'login_screen.dart';
import 'signUpScreen.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(brightness: Brightness.light),
      darkTheme: ThemeData(brightness: Brightness.dark),
      themeMode: ThemeMode.system,
      home: LoginScreen(),
      routes: {
        '/login': (context) => LoginScreen(),
        '/home': (context) => const AppHome(),
        '/signup': (context) => SignupScreen(),
      },
    );
  }
}

class AppHome extends StatefulWidget {
  const AppHome({Key? key}) : super(key: key);

  @override
  _AppHomeState createState() => _AppHomeState();
}

class _AppHomeState extends State<AppHome> {
  ThemeMode _themeMode = ThemeMode.light;

  void _toggleTheme() {
    setState(() {
      _themeMode =
          _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(".appable/"),
        leading: const Icon(Icons.open_with_rounded),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.account_tree_sharp),
        onPressed: _toggleTheme,
      ),
      body: Center(
        child: Text('Home Screen'),
      ),
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
      appBar: AppBar(title: Text('Battery Status')),
      body: Center(child: Text(_batteryStatus)),
    );
  }
}
