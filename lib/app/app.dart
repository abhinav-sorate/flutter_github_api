import 'package:flutter/material.dart';
import 'package:flutter_github_api/app/router/app_router.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GitHub Users',
      home: MaterialApp.router(
        title: 'GitHub Users',
        debugShowCheckedModeBanner: false,
        routerConfig: router,
      ),
    );
  }
}
