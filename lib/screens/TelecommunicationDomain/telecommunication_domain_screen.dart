import 'package:flutter/material.dart';
import 'package:social_chat_bot_assistant/screens/TelecommunicationDomain/components/body.dart';
import 'package:social_chat_bot_assistant/components/navigation_drawer.dart';

class TelecommunicationDomainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavigationDrawerWidget(),
      appBar: AppBar(
        title: Text('Telecommunication'),
      ),
      body: Body(),
    );
  }
}
