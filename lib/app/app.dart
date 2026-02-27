import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_github_api/app/router/app_router.dart';
import 'package:flutter_github_api/core/bloc/user_bloc.dart';
import 'package:flutter_github_api/core/locator.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GitHub Users',
      home: BlocProvider(
        create: (_) => locator<UserBloc>(),
        child: MaterialApp.router(
          title: 'GitHub Users',
          debugShowCheckedModeBanner: false,
          routerConfig: router,
        ),
      ),
    );
  }
}
