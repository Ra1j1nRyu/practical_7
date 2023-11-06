import 'package:flutter/material.dart';

class TestScreen extends StatelessWidget {
  final String message;
  const TestScreen({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Text('MyTest screen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(message),
          ],
        ),
      ),
    );
  }
}