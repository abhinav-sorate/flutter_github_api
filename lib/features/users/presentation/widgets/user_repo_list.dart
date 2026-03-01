import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_github_api/core/constants/status.enum.dart';
import 'package:flutter_github_api/core/utils/language_color_util.dart';
import 'package:flutter_github_api/features/users/presentation/bloc/user_bloc.dart';
import 'package:flutter_github_api/features/users/presentation/widgets/shimmers/user_repo_shimmer.dart';
import 'package:url_launcher/url_launcher.dart';

class UserRepoList extends StatelessWidget {
  final ScrollController scrollController;
  const UserRepoList({super.key, required this.scrollController});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        if (state.getUserReposStatus.isLoading) {
          return const UserReposShimmer();
        }

        if (state.getUserReposStatus.isSuccess) {
          final repos = state.userRepoList;
          return ListView.separated(
            controller: scrollController,
            itemCount: repos.length + 1,
            separatorBuilder: (_, _) => const Divider(),
            itemBuilder: (context, index) {
              if (index == state.userRepoList.length) {
                return state.isRepoLoadMore
                    ? const Padding(
                        padding: EdgeInsets.all(16),
                        child: Center(child: CircularProgressIndicator()),
                      )
                    : const SizedBox();
              }

              final repo = repos[index];
              return ListTile(
                title: Text(
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  repo.name,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 4),
                    Text(
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      repo.description ?? 'No description provided',
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
                      const SnackBar(
                        content: Text('Could not open repository'),
                      ),
                    );
                  }
                },
              );
            },
          );
        }
        if (state.getUserReposStatus.isError) {
          return Center(child: Text('Something went wrong'));
        }

        return const Center(child: Text('User Repos'));
      },
    );
  }
}

Future<void> _openRepo(String url) async {
  final uri = Uri.parse(url);

  if (!await launchUrl(uri, mode: LaunchMode.inAppBrowserView)) {
    throw Exception('Could not launch $url');
  }
}
