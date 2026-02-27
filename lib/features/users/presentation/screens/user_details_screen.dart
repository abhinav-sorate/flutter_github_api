import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_github_api/core/constants/status.enum.dart';
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
      appBar: AppBar(title: const Text("User Details")),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(children: [_buildUserHeader()]),
          ),
        ],
      ),
    );
  }
}

Widget _buildUserHeader() {
  return BlocBuilder<UserBloc, UserState>(
    builder: (context, state) {
      final user = state.userDetails!;

      if (state.getUserDetailsStatus.isLoading) {
        return const Center(child: CircularProgressIndicator());
      }

      if (state.getUserDetailsStatus.isSuccess) {
        return Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(user.avatarUrl),
              ),
              const SizedBox(height: 12),
              Text(
                user.username,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              Text(user.fullname, style: TextStyle(color: Colors.grey)),
              const SizedBox(height: 16),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _FollowInfo(title: "Followers", count: user.followers),
                  SizedBox(width: 24),
                  _FollowInfo(title: "Following", count: user.following),
                ],
              ),
            ],
          ),
        );
      }

      if (state.getUserDetailsStatus.isError) {
        return Center(child: Text('Something went wrong'));
      }

      return const Center(child: Text('User Details'));
    },
  );
}

class _FollowInfo extends StatelessWidget {
  final String title;
  final int count;

  const _FollowInfo({required this.title, required this.count});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          count.toString(),
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        Text(title, style: const TextStyle(color: Colors.grey)),
      ],
    );
  }
}
