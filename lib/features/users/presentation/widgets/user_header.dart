import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_github_api/core/constants/status.enum.dart';
import 'package:flutter_github_api/features/users/presentation/bloc/user_bloc.dart';
import 'package:flutter_github_api/features/users/presentation/widgets/shimmers/user_header_shimmer.dart';

class UserHeader extends StatelessWidget {
  const UserHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        if (state.getUserDetailsStatus.isLoading) {
          return const UserHeaderShimmer();
        }

        if (state.getUserDetailsStatus.isSuccess) {
          final user = state.userDetails!;

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
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  user.fullname,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  spacing: 10,
                  children: [
                    Icon(
                      user.type == 'Organization'
                          ? Icons.business
                          : Icons.person,
                      size: 14,
                    ),
                    Flexible(
                      child: Text(
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        user.username,
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                  ],
                ),
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
