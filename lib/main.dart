import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_github_api/core/bloc/user_bloc.dart';
import 'package:flutter_github_api/core/locator.dart';
import 'package:flutter_github_api/features/users/presentation/screens/user_search_screen.dart';

void main() async {
  await dotenv.load();
  initLocator();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GitHub Users',
      home: BlocProvider(
        create: (_) => locator<UserBloc>(),
        child: const UserSearchScreen(),
      ),
    );
  }
}
