import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_github_api/app/router/route_names.dart';
import 'package:flutter_github_api/features/users/presentation/providers/search_users_notifier.dart';
import 'package:flutter_github_api/features/users/presentation/widgets/shimmers/user_list_shimmer.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class UserList extends ConsumerWidget {
  final ScrollController scrollController;
  const UserList({super.key, required this.scrollController});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(searchUsersProvider);

    return state.when(
      loading: () => const UserListShimmer(),
      error: (e, _) => const Center(child: Text('Something went wrong')),
      data: (users) {
        if (users.isEmpty) {
          return const Center(child: Text('Search GitHub users'));
        }

        final notifier = ref.read(searchUsersProvider.notifier);

        return ListView.builder(
          controller: scrollController,
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          itemCount: users.length + 1,
          itemBuilder: (_, index) {
            // Pagination loader at bottom
            if (index == users.length) {
              return notifier.hasMore
                  ? const Padding(
                      padding: EdgeInsets.all(16),
                      child: Center(child: CircularProgressIndicator()),
                    )
                  : const SizedBox();
            }

            final user = users[index];
            return ListTile(
              leading: CachedNetworkImage(
                imageUrl: user.avatarUrl,
                width: 40,
                height: 40,
              ),
              title: Text(
                user.username,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
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
              onTap: () => context.push(Routes.userDetailsPath(user.username)),
            );
          },
        );
      },
    );
  }
}
