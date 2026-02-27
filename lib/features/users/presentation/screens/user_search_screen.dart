import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_github_api/app/router/route_names.dart';
import 'package:flutter_github_api/core/bloc/user_bloc.dart';
import 'package:flutter_github_api/core/constants/status.enum.dart';
import 'package:go_router/go_router.dart';

class UserSearchScreen extends StatefulWidget {
  const UserSearchScreen({super.key});

  @override
  State<UserSearchScreen> createState() => _UserSearchScreen();
}

class _UserSearchScreen extends State<UserSearchScreen> {
  final _controller = TextEditingController();

  void _onSearch(String query) {
    context.read<UserBloc>().add(SearchUsers(keyword: query));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Search GitHub Users')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              controller: _controller,
              decoration: const InputDecoration(
                hintText: 'Search users...',
                border: OutlineInputBorder(),
              ),
              onChanged: _onSearch,
            ),
          ),
          Expanded(child: _buildUserList()),
        ],
      ),
    );
  }
}

Widget _buildUserList() {
  return BlocBuilder<UserBloc, UserState>(
    builder: (context, state) {
      if (state.getUserSearchStatus.isLoading) {
        return const Center(child: CircularProgressIndicator());
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
                    user.type == 'Organization' ? Icons.business : Icons.person,
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
                context.push(Routes.userDetails);
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
