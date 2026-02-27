import 'package:flutter/material.dart';

class UserDetailsScreen extends StatelessWidget {
  final String username;
  const UserDetailsScreen({super.key, required this.username});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(username)),
      body: Column(children: []),
    );
  }
}
