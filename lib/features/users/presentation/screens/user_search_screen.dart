import 'package:flutter/material.dart';
import 'package:flutter_github_api/features/users/presentation/providers/search_users_notifier.dart';
import 'package:flutter_github_api/features/users/presentation/widgets/user_list.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class UserSearchScreen extends HookConsumerWidget {
  const UserSearchScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = useTextEditingController();
    final scrollController = useScrollController();

    useEffect(() {
      void onScroll() {
        if (!scrollController.hasClients ||
            !scrollController.position.hasContentDimensions) {
          return;
        }

        final notifier = ref.read(searchUsersProvider.notifier);
        if (scrollController.position.extentAfter < 300 && notifier.hasMore) {
          notifier.loadMore();
        }
      }

      scrollController.addListener(onScroll);
      return () => scrollController.removeListener(onScroll);
    }, [scrollController]);

    void onSearch(String query) {
      final notifier = ref.read(searchUsersProvider.notifier);
      if (query.trim().isEmpty) {
        notifier.clear();
      } else {
        notifier.search(query);
      }
    }

    void onClear() {
      controller.clear();
      ref.read(searchUsersProvider.notifier).clear();
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Search GitHub Users')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: ValueListenableBuilder(
              valueListenable: controller,
              builder: (context, value, _) {
                return TextField(
                  controller: controller,
                  decoration: InputDecoration(
                    hintText: 'Search users...',
                    border: const OutlineInputBorder(),
                    suffixIcon: value.text.isNotEmpty
                        ? IconButton(
                            icon: const Icon(Icons.clear),
                            onPressed: onClear,
                          )
                        : null,
                  ),
                  onChanged: onSearch,
                );
              },
            ),
          ),
          Expanded(child: UserList(scrollController: scrollController)),
        ],
      ),
    );
  }
}
