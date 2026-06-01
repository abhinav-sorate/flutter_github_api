import 'package:flutter/material.dart';
import 'package:flutter_github_api/features/users/presentation/providers/user_repos_notifier.dart';
import 'package:flutter_github_api/features/users/presentation/widgets/user_header.dart';
import 'package:flutter_github_api/features/users/presentation/widgets/user_repo_list.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class UserDetailsScreen extends ConsumerStatefulWidget {
  final String username;
  const UserDetailsScreen({super.key, required this.username});

  @override
  ConsumerState<UserDetailsScreen> createState() => _UserDetailsScreenState();
}

class _UserDetailsScreenState extends ConsumerState<UserDetailsScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    final notifier = ref.read(userReposProvider(widget.username).notifier);
    if (_scrollController.position.extentAfter < 300 && notifier.hasMore) {
      notifier.loadMore(widget.username);
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('User Details')),
      body: Column(
        children: [
          UserHeader(username: widget.username),
          const Divider(),
          Expanded(
            child: UserRepoList(
              username: widget.username,
              scrollController: _scrollController,
            ),
          ),
        ],
      ),
    );
  }
}
