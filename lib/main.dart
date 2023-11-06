import 'package:flutter/material.dart';
import 'auth/auth_screen.dart';

void main(){
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Авторизация',
    home: AuthScreen(),
  ));
}


