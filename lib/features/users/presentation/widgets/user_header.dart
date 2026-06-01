import 'package:flutter/material.dart';
import 'package:flutter_github_api/features/users/presentation/providers/user_details_notifier.dart';
import 'package:flutter_github_api/features/users/presentation/widgets/shimmers/user_header_shimmer.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class UserHeader extends ConsumerWidget {
  final String username;
  const UserHeader({super.key, required this.username});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(userDetailsProvider(username));

    return state.when(
      loading: () => const UserHeaderShimmer(),
      error: (e, _) => const Center(child: Text('Something went wrong')),
      data: (user) => Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(user.avatarUrl),
            ),
            const SizedBox(height: 12),
            Text(
              user.fullname,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 10,
              children: [
                Icon(
                  user.type == 'Organization' ? Icons.business : Icons.person,
                  size: 14,
                ),
                Flexible(
                  child: Text(
                    user.username,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(color: Colors.grey),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _FollowInfo(title: 'Followers', count: user.followers),
                const SizedBox(width: 24),
                _FollowInfo(title: 'Following', count: user.following),
              ],
            ),
          ],
        ),
      ),
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
