import 'package:flutter/material.dart';
import 'package:flutter_github_api/core/utils/language_color_util.dart';
import 'package:flutter_github_api/features/users/presentation/providers/user_repos_notifier.dart';
import 'package:flutter_github_api/features/users/presentation/widgets/shimmers/user_repo_shimmer.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

class UserRepoList extends ConsumerWidget {
  final String username;
  final ScrollController scrollController;
  const UserRepoList({
    super.key,
    required this.username,
    required this.scrollController,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(userReposProvider(username));

    return state.when(
      loading: () => const UserReposShimmer(),
      error: (e, _) => const Center(child: Text('Something went wrong')),
      data: (repos) => ListView.separated(
        controller: scrollController,
        itemCount: repos.length + 1,
        separatorBuilder: (_, _) => const Divider(),
        itemBuilder: (context, index) {
          // Pagination loader at bottom
          if (index == repos.length) {
            final notifier = ref.read(userReposProvider(username).notifier);
            return notifier.hasMore
                ? const Padding(
                    padding: EdgeInsets.all(16),
                    child: Center(child: CircularProgressIndicator()),
                  )
                : const SizedBox();
          }

          final repo = repos[index];
          return ListTile(
            title: Text(
              repo.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 4),
                Text(
                  repo.description ?? 'No description provided',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontStyle: repo.description != null
                        ? FontStyle.normal
                        : FontStyle.italic,
                    color: repo.description != null
                        ? Colors.black87
                        : Colors.grey,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Container(
                      width: 10,
                      height: 10,
                      decoration: BoxDecoration(
                        color: LanguageColorUtil.getColor(repo.language),
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Text(repo.language ?? '-'),
                    const SizedBox(width: 12),
                    const Icon(Icons.star, size: 14, color: Colors.amber),
                    const SizedBox(width: 4),
                    Text(repo.stars.toString()),
                  ],
                ),
              ],
            ),
            trailing: const Icon(Icons.open_in_new_outlined),
            onTap: () async {
              final messenger = ScaffoldMessenger.of(context);
              try {
                await _openRepo(repo.url);
              } catch (_) {
                messenger.showSnackBar(
                  const SnackBar(content: Text('Could not open repository')),
                );
              }
            },
          );
        },
      ),
    );
  }
}

Future<void> _openRepo(String url) async {
  final uri = Uri.parse(url);
  if (!await launchUrl(uri, mode: LaunchMode.inAppBrowserView)) {
    throw Exception('Could not launch $url');
  }
}
