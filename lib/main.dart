import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_github_api/core/bloc/user_bloc.dart';
import 'package:flutter_github_api/core/locator.dart';

void main() async {
  await dotenv.load();
  initLocator();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => locator<UserBloc>(),
      child: const MaterialApp(
        home: Scaffold(body: Center(child: Text('Hello World!'))),
      ),
    );
  }
}
