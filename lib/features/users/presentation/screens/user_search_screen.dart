import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_github_api/core/constants/status.enum.dart';
import 'package:flutter_github_api/features/users/presentation/bloc/user_bloc.dart';
import 'package:flutter_github_api/features/users/presentation/widgets/user_list.dart';

class UserSearchScreen extends StatefulWidget {
  const UserSearchScreen({super.key});

  @override
  State<UserSearchScreen> createState() => _UserSearchScreen();
}

class _UserSearchScreen extends State<UserSearchScreen> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    _scrollController.addListener(() {
      final state = context.read<UserBloc>().state;
      if (_scrollController.position.extentAfter < 300 &&
          state.hasMoreSearch &&
          !state.isSearchLoadMore &&
          state.getUserSearchStatus.isSuccess) {
        context.read<UserBloc>().add(LoadMoreUsers());
      }
    });
    super.initState();
  }

  void _onSearch(String query) {
    context.read<UserBloc>().add(SearchUsers(keyword: query));
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
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
              decoration: InputDecoration(
                hintText: 'Search users...',
                border: const OutlineInputBorder(),
                suffixIcon: _controller.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _controller.clear();
                          context.read<UserBloc>().add(
                            const SearchUsers(keyword: ''),
                          );
                          setState(() {}); // to update UI
                        },
                      )
                    : null,
              ),
              onChanged: (value) {
                setState(() {}); // to update UI
                _onSearch(value);
              },
            ),
          ),
          Expanded(child: UserList(scrollController: _scrollController)),
        ],
      ),
    );
  }
}
