import 'package:flutter/material.dart';
import 'package:flutter_github_api/features/users/presentation/providers/user_repos_notifier.dart';
import 'package:flutter_github_api/features/users/presentation/widgets/user_header.dart';
import 'package:flutter_github_api/features/users/presentation/widgets/user_repo_list.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class UserDetailsScreen extends HookConsumerWidget {
  const UserDetailsScreen({super.key, required this.username});

  final String username;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scrollController = useScrollController();

    useEffect(() {
      void onScroll() {
        if (!scrollController.hasClients ||
            !scrollController.position.hasContentDimensions) {
          return;
        }

        final notifier = ref.read(userReposProvider(username).notifier);
        if (scrollController.position.extentAfter < 300 && notifier.hasMore) {
          notifier.loadMore(username);
        }
      }

      scrollController.addListener(onScroll);
      return () => scrollController.removeListener(onScroll);
    }, [scrollController, username]);

    return Scaffold(
      appBar: AppBar(title: const Text('User Details')),
      body: Column(
        children: [
          UserHeader(username: username),
          const Divider(),
          Expanded(
            child: UserRepoList(
              username: username,
              scrollController: scrollController,
            ),
          ),
        ],
      ),
    );
  }
}
