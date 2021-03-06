import 'package:flutter/material.dart';
import 'package:social_chat_bot_assistant/components/navigation_drawer.dart';
import 'package:social_chat_bot_assistant/screens/Help/components/body.dart';

class HelpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavigationDrawerWidget(),
      appBar: AppBar(
        title: Text('HELP'),
      ),
      body: Body(),
    );
  }
}
