import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: LoginForm(),
    );
  }
}

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isLoading = false;
  String _errorText = '';

  void _login() async {
    setState(() {
      _isLoading = true;
    });

    // Simulate a login process (replace with actual login logic)
    await Future.delayed(Duration(seconds: 2));

    // Example logic for checking credentials (replace with your authentication logic)
    if (_emailController.text == 'test@example.com' &&
        _passwordController.text == 'password') {
      // Login successful
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', true);

      // Navigate to home screen or next screen after login
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      // Login failed
      setState(() {
        _isLoading = false;
        _errorText = 'Invalid email or password';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextField(
            controller: _emailController,
            decoration: InputDecoration(
              labelText: 'Email',
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 16.0),
          TextField(
            controller: _passwordController,
            obscureText: true,
            decoration: InputDecoration(
              labelText: 'Password',
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: _isLoading ? null : _login,
            child: _isLoading
                ? CircularProgressIndicator()
                : Text('Login'),
          ),
          SizedBox(height: 8.0),
          if (_errorText.isNotEmpty)
            Text(
              _errorText,
              style: TextStyle(color: Colors.red),
            ),
          SizedBox(height: 16.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Don't have an account? "),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/signup');
                },
                child: Text('Sign up'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
