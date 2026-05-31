import 'package:flutter/material.dart';
import 'package:flutter_github_api/app/app.dart';
import 'package:flutter_github_api/core/locator.dart';

void main() async {
  initLocator();
  runApp(const App());
}
