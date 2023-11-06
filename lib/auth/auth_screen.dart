import 'package:flutter/material.dart';
import 'load_screen.dart';


class AuthScreen extends StatelessWidget{
  const AuthScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Text('страница авторизации'),
      ),
      body: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 34),
        child: AuthFormField(),
      ),
    );
  }
}

class AuthFormField extends StatefulWidget{
  const AuthFormField({Key? key}) : super(key: key);
  @override
  State<AuthFormField> createState() => _AuthFormFieldState();
}

class _AuthFormFieldState extends State<AuthFormField> {
  final GlobalKey<FormState> _authScreenFormKey = GlobalKey<FormState>();
  String _email = '';
  String _pass = '';
  bool _isShow = false;

  void buttonView() {
    setState(() {
      if (_email.length > 5 && _pass.length > 5) {
        _isShow = _authScreenFormKey.currentState!.validate();
      } else {
        _isShow = false;
      }
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _authScreenFormKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          TextFormField(
            onChanged: (email) {
              _email = email;
              buttonView();
            },
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
              labelText: 'ввести Email',
              prefixIcon: Icon(Icons.mail_outlined),
            ),
            validator: (email) {
              email ??= '';
              const pattern = r'^[\w-\.]+@([\w-]+\.)+[a-zA-Z]{2,6}$';
              final regExp = RegExp(pattern);
              if (!regExp.hasMatch(email)) {
                return 'введите корректный email';
              }
              return null;
            },
          ),
          const SizedBox(height: 24),
          TextFormField(
            onChanged: (password) {
              _pass = password;
              buttonView();
            },
            decoration: const InputDecoration(
              labelText: 'ввести пароль',
              prefixIcon: Icon(Icons.lock_outline),
            ),
            obscureText: true,
            validator: (password) {
              password ??= '';
              if (password != _email) {
                return 'введите корректный пароль';
              }
              return null;
            },
          ),
          const SizedBox(height: 50),
          Visibility(
            visible: _isShow,
            child: ElevatedButton(
              onPressed: () {
                if (_authScreenFormKey.currentState!.validate()) {
                  _authScreenFormKey.currentState!.save();
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LoadScreen(
                        login: _email,
                        pass: _pass,
                        message: 'обработка данных...',
                      ),
                    ),
                    (Route<dynamic> route) => false,
                  );
                }
              },
              child: const Text('отправить'),
            ),
          ),
        ],
      ),
    );
  }
}
