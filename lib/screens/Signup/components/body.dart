import 'package:flutter/material.dart';
import 'package:social_chat_bot_assistant/components/already_have_an_account_acheck.dart';
import 'package:social_chat_bot_assistant/components/loading.dart';
import 'package:social_chat_bot_assistant/components/rounded_button.dart';
import 'package:social_chat_bot_assistant/components/rounded_input_field.dart';
import 'package:social_chat_bot_assistant/components/rounded_password_field.dart';
import 'package:social_chat_bot_assistant/screens/Login/login_screen.dart';
import 'package:social_chat_bot_assistant/screens/Signup/components/background.dart';
import 'package:social_chat_bot_assistant/screens/Signup/components/or_divider.dart';
import 'package:social_chat_bot_assistant/screens/Signup/components/social_icon.dart';
import 'package:flutter_svg/svg.dart';
import 'package:social_chat_bot_assistant/services/auth_service.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final AuthService _authService = AuthService();
  final _formKey = GlobalKey<FormState>();

  bool loading = false;
  String firstName = "";
  String lastName = "";
  String birthDay = "";
  String nic = "";
  String phoneNumber = "";
  String email = "";
  String password = "";
  String error = "";

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
                  Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        SizedBox(height: 20.0),
                        Text(
                          'REGISTER',
                          style: TextStyle(fontSize: 25, fontFamily: 'Lobster'),
                        ),
                        SizedBox(height: 20.0),
                        RoundedInputField(
                          hintText: "First Name",
                          validator: (value) =>
                              value.isEmpty ? 'Enter your first name' : null,
                          onChanged: (value) {
                            setState(() {
                              firstName = value;
                            });
                          },
                        ),
                        RoundedInputField(
                          hintText: "Last Name",
                          validator: (value) =>
                              value.isEmpty || value == firstName
                                  ? 'Enter your last name'
                                  : null,
                          onChanged: (value) {
                            setState(() {
                              lastName = value;
                            });
                          },
                        ),
                        RoundedInputField(
                          hintText: "Birth Day (YYYY/MM/DD)",
                          icon: Icons.cake,
                          validator: (value) =>
                              value.isEmpty ? 'Enter your birth day' : null,
                          onChanged: (value) {
                            setState(() {
                              birthDay = value;
                            });
                          },
                        ),
                        RoundedInputField(
                          hintText: "NIC",
                          icon: Icons.branding_watermark,
                          validator: (value) =>
                              value.isEmpty ? 'Enter a valid nic number' : null,
                          onChanged: (value) {
                            setState(() {
                              nic = value;
                            });
                          },
                        ),
                        RoundedInputField(
                          hintText: "Phone Number",
                          icon: Icons.phone,
                          validator: (value) =>
                              value.length < 10 || value.length > 10
                                  ? 'Enter a valid phone number'
                                  : null,
                          onChanged: (value) {
                            setState(() {
                              phoneNumber = value;
                            });
                          },
                        ),
                        RoundedInputField(
                          hintText: "Email",
                          validator: (value) =>
                              value.isEmpty ? 'Enter an valid email' : null,
                          onChanged: (value) {
                            setState(() {
                              email = value;
                            });
                          },
                        ),
                        RoundedPasswordField(
                          validator: (value) => value.length < 6
                              ? 'Enter a password 6+ chars long'
                              : null,
                          onChanged: (value) {
                            setState(() {
                              password = value;
                            });
                          },
                        ),
                        RoundedButton(
                            text: "SIGNUP",
                            press: () async {
                              if (_formKey.currentState.validate()) {
                                setState(() {
                                  loading = true;
                                });
                                dynamic result = await _authService
                                    .createUserWithEmailAndPassword(
                                        email,
                                        password,
                                        firstName,
                                        lastName,
                                        birthDay,
                                        nic,
                                        phoneNumber);
                                if (result == null) {
                                  setState(() {
                                    error = 'Please supply a valid email';
                                    loading = false;
                                  });
                                } else {
                                  Navigator.of(context).pop();
                                }
                              }
                            }),
                        SizedBox(height: 12.0),
                        Text(
                          error,
                          style: TextStyle(color: Colors.red, fontSize: 14.0),
                        )
                      ],
                    ),
                  ),
                  AlreadyHaveAnAccountCheck(
                    login: false,
                    press: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return LoginScreen();
                          },
                        ),
                      );
                    },
                  ),
                  /*OrDivider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SocalIcon(
                        iconSrc: "assets/icons/facebook.svg",
                        press: () {},
                      ),
                      SocalIcon(
                        iconSrc: "assets/icons/twitter.svg",
                        press: () {},
                      ),
                      SocalIcon(
                        iconSrc: "assets/icons/google-plus.svg",
                        press: () {},
                      ),
                    ],
                  )*/
                ],
              ),
            ),
          );
  }
}
