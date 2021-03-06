import 'package:flutter/material.dart';
import 'package:social_chat_bot_assistant/components/loading.dart';
import 'package:social_chat_bot_assistant/screens/Login/components/background.dart';
import 'package:social_chat_bot_assistant/components/already_have_an_account_acheck.dart';
import 'package:social_chat_bot_assistant/components/rounded_button.dart';
import 'package:social_chat_bot_assistant/components/rounded_input_field.dart';
import 'package:social_chat_bot_assistant/components/rounded_password_field.dart';
import 'package:social_chat_bot_assistant/screens/Signup/signup_screen.dart';
import 'package:flutter_svg/svg.dart';
import 'package:social_chat_bot_assistant/services/auth_service.dart';

class EmailFieldValidator {
  static String validate(String value) {
    return value.isEmpty ? 'Enter an valid email' : null;
  }
}

class PasswordFieldValidator {
  static String validate(String value) {
    return  value.length < 6 ? 'Enter a password 6+ chars long' : null;
  }
}

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final AuthService _authService = AuthService();
  final _formKey = GlobalKey<FormState>();

  bool loading = false;
  String error = '';
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return loading
        ? Loading()
        : Background(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'LOGIN',
                    style: TextStyle(fontSize: 25, fontFamily: 'Lobster'),
                  ),
                  SizedBox(height: size.height * 0.03),
                  SvgPicture.asset(
                    "assets/icons/login.svg",
                    height: size.height * 0.35,
                  ),
                  SizedBox(height: size.height * 0.03),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        SizedBox(height: 20.0),
                        RoundedInputField(
                          hintText: "Your Email",
                          validator: (val) => EmailFieldValidator.validate(val),
                          onChanged: (val) {
                            setState(() {
                              email = val;
                            });
                          },
                        ),
                        RoundedPasswordField(
                          validator: (val) => PasswordFieldValidator.validate(val),
                          onChanged: (val) {
                            setState(() => password = val);
                          },
                        ),
                        RoundedButton(
                          text: "LOGIN",
                          press: () async {
                            if (_formKey.currentState.validate()) {
                              setState(() {
                                loading = true;
                              });

                              dynamic result = await _authService
                                  .signInWithEmailAndPassword(email, password);
                              if (result == null) {
                                setState(() {
                                  error =
                                      'Could not sign in with those credentials';
                                  loading = false;
                                });
                              } else {
                                Navigator.of(context).pop();
                                print("result not null");
                              }
                            }
                          },
                        ),
                        SizedBox(height: 10.0),
                        Text(
                          error,
                          style: TextStyle(color: Colors.red, fontSize: 14.0),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: size.height * 0.03),
                  AlreadyHaveAnAccountCheck(
                    press: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return SignUpScreen();
                          },
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          );
  }
}
