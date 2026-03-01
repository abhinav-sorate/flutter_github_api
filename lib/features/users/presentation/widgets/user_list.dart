import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_github_api/app/router/route_names.dart';
import 'package:flutter_github_api/core/constants/status.enum.dart';
import 'package:flutter_github_api/features/users/presentation/bloc/user_bloc.dart';
import 'package:flutter_github_api/features/users/presentation/widgets/shimmers/user_list_shimmer.dart';
import 'package:go_router/go_router.dart';

class UserList extends StatelessWidget {
  const UserList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        if (state.getUserSearchStatus.isLoading) {
          return const UserListShimmer();
        }

        if (state.getUserSearchStatus.isNotFound) {
          return Center(child: Text('User not found'));
        }

        if (state.getUserSearchStatus.isSuccess) {
          return ListView.builder(
            itemCount: state.userSearchList.length,
            itemBuilder: (_, index) {
              final user = state.userSearchList[index];
              return ListTile(
                leading: CachedNetworkImage(
                  imageUrl: user.avatarUrl,
                  width: 40,
                  height: 40,
                ),
                title: Text(user.username),
                subtitle: Row(
                  children: [
                    Icon(
                      user.type == 'Organization'
                          ? Icons.business
                          : Icons.person,
                      size: 14,
                    ),
                    const SizedBox(width: 4),
                    Text(user.type),
                    const SizedBox(width: 4),
                    Text(user.id.toString()),
                  ],
                ),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {
                  context.push(Routes.userDetailsPath(user.username));
                },
              );
            },
          );
        }

        if (state.getUserSearchStatus.isError) {
          return Center(child: Text('Something went wrong'));
        }

        return const Center(child: Text('Search GitHub users'));
      },
    );
  }
}
