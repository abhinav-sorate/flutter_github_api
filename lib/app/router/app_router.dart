import 'package:flutter/material.dart';
import 'package:flutter_github_api/app/router/route_names.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_github_api/features/users/presentation/screens/user_search_screen.dart';
import 'package:flutter_github_api/features/users/presentation/screens/user_details_screen.dart';

final GoRouter router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: Routes.home,
      builder: (BuildContext context, GoRouterState state) {
        return const UserSearchScreen();
      },
      routes: <RouteBase>[
        GoRoute(
          path: Routes.userDetails,
          builder: (BuildContext context, GoRouterState state) {
            final username = state.pathParameters['username']!;
            return UserDetailsScreen(username: username);
          },
        ),
      ],
    ),
  ],
);
