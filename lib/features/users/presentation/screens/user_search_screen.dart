import 'package:flutter/material.dart';
import 'package:flutter_github_api/features/users/presentation/providers/search_users_notifier.dart';
import 'package:flutter_github_api/features/users/presentation/widgets/user_list.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class UserSearchScreen extends ConsumerStatefulWidget {
  const UserSearchScreen({super.key});

  @override
  ConsumerState<UserSearchScreen> createState() => _UserSearchScreenState();
}

class _UserSearchScreenState extends ConsumerState<UserSearchScreen> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    final notifier = ref.read(searchUsersProvider.notifier);
    if (_scrollController.position.extentAfter < 300 && notifier.hasMore) {
      notifier.loadMore();
    }
  }

  void _onSearch(String query) {
    if (query.trim().isEmpty) {
      ref.read(searchUsersProvider.notifier).clear();
    } else {
      ref.read(searchUsersProvider.notifier).search(query);
    }
  }

  void _onClear() {
    _controller.clear();
    ref.read(searchUsersProvider.notifier).clear();
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
            child: ValueListenableBuilder(
              valueListenable: _controller,
              builder: (context, value, _) {
                return TextField(
                  controller: _controller,
                  decoration: InputDecoration(
                    hintText: 'Search users...',
                    border: const OutlineInputBorder(),
                    suffixIcon: value.text.isNotEmpty
                        ? IconButton(
                            icon: const Icon(Icons.clear),
                            onPressed: _onClear,
                          )
                        : null,
                  ),
                  onChanged: _onSearch,
                );
              },
            ),
          ),
          Expanded(child: UserList(scrollController: _scrollController)),
        ],
      ),
    );
  }
}
