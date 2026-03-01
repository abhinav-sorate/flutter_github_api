import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_github_api/core/constants/status.enum.dart';
import 'package:flutter_github_api/features/users/presentation/bloc/user_bloc.dart';
import 'package:flutter_github_api/features/users/presentation/widgets/user_header.dart';
import 'package:flutter_github_api/features/users/presentation/widgets/user_repo_list.dart';

class UserDetailsScreen extends StatefulWidget {
  final String username;
  const UserDetailsScreen({super.key, required this.username});

  @override
  State<UserDetailsScreen> createState() => _UserDetailsScreenState();
}

class _UserDetailsScreenState extends State<UserDetailsScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    _scrollController.addListener(() {
      final state = context.read<UserBloc>().state;
      if (_scrollController.position.extentAfter < 300 &&
          state.hasMoreRepo &&
          !state.isRepoLoadMore &&
          state.getUserReposStatus.isSuccess) {
        context.read<UserBloc>().add(LoadMoreRepos());
      }
    });

    context.read<UserBloc>().add(GetUserDetails(username: widget.username));
    context.read<UserBloc>().add(GetUserRepos(username: widget.username));
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("User Details")),
      body: Column(
        children: [
          UserHeader(),
          const Divider(),
          Expanded(child: UserRepoList(scrollController: _scrollController)),
        ],
      ),
    );
  }
}
