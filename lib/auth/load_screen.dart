import 'package:flutter/material.dart';
import 'test_screen.dart';
import 'auth_screen.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

class LoadScreen extends StatefulWidget {
  final String message;
  final String login;
  final String pass;

  const LoadScreen({
    Key? key,
    required this.message,
    required this.login,
    required this.pass,
  }) : super(key: key);

  @override
  State<LoadScreen> createState() => _LoadScreenState();
}

class _LoadScreenState extends State<LoadScreen> {
  bool _auth = false;
  final Logger logger = Logger();

  @override
  void initState() {
    super.initState();
    processingHttp(widget.message, widget.login, widget.pass);
  }

  Future<void> processingHttp(String message, String email, String password) async {
    try {
      final http.Response response = await http.post(
        Uri.parse('http://test.a77r.ru/test_reply_server.php'),
        body: <String, String>{
          'message': message,
          'email': email,
          'password': password,
        },
      );

      final result = json.decode(response.body);
      if (result['title'] is String && result['title'] == 'test_string') {
        _auth = true;
      }
    } catch (err) {
      logger.e('error: $err'); // Используем логгер вместо print
    } finally {
      Future.delayed(const Duration(seconds: 3), () {
        getScreenWidget();
      });
    }
  }

  void getScreenWidget() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => _auth
            ? const TestScreen(
                message: 'Регистрация завершена, ответ сервера получен.',
              )
            : const AuthScreen(),
      ),
      (Route<dynamic> route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ожидаем...'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(widget.message),
            const SizedBox(
              width: 10.0,
              height: 30.0,
            ),
            const CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
