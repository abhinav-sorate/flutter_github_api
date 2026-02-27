import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_github_api/features/users/presentation/bloc/user_bloc.dart';

class UserDetailsScreen extends StatefulWidget {
  final String username;
  const UserDetailsScreen({super.key, required this.username});

  @override
  State<UserDetailsScreen> createState() => _UserDetailsScreenState();
}

class _UserDetailsScreenState extends State<UserDetailsScreen> {
  @override
  void initState() {
    context.read<UserBloc>().add(GetUserDetails(username: widget.username));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.username)),
      body: Column(children: []),
    );
  }
}
