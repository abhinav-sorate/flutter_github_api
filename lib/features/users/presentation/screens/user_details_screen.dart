import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_github_api/core/constants/status.enum.dart';
import 'package:flutter_github_api/core/utils/laguage_color_util.dart';
import 'package:flutter_github_api/features/users/presentation/bloc/user_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

class UserDetailsScreen extends StatefulWidget {
  final String username;
  const UserDetailsScreen({super.key, required this.username});

  @override
  State<UserDetailsScreen> createState() => _UserDetailsScreenState();
}

class _UserDetailsScreenState extends State<UserDetailsScreen> {
  @override
  void initState() {
    context.read<UserBloc>().add(GetUserDetails(username: widget.username));
    context.read<UserBloc>().add(GetUserRepos(username: widget.username));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("User Details")),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            _buildUserHeader(),
            const Divider(),
            _buildRepositoryList(),
          ],
        ),
      ),
    );
  }
}

Widget _buildUserHeader() {
  return BlocBuilder<UserBloc, UserState>(
    builder: (context, state) {
      if (state.getUserDetailsStatus.isLoading) {
        return const Center(child: CircularProgressIndicator());
      }

      if (state.getUserDetailsStatus.isSuccess) {
        final user = state.userDetails!;

        return Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(user.avatarUrl),
              ),
              const SizedBox(height: 12),
              Text(
                user.username,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              Text(user.fullname, style: TextStyle(color: Colors.grey)),
              const SizedBox(height: 16),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _FollowInfo(title: "Followers", count: user.followers),
                  SizedBox(width: 24),
                  _FollowInfo(title: "Following", count: user.following),
                ],
              ),
            ],
          ),
        );
      }

      if (state.getUserDetailsStatus.isError) {
        return Center(child: Text('Something went wrong'));
      }

      return const Center(child: Text('User Details'));
    },
  );
}

Widget _buildRepositoryList() {
  return BlocBuilder<UserBloc, UserState>(
    builder: (context, state) {
      if (state.getUserReposStatus.isLoading) {
        return const Center(child: CircularProgressIndicator());
      }

      if (state.getUserReposStatus.isSuccess) {
        final repos = state.userRepoList;
        return ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: repos.length,
          separatorBuilder: (_, _) => const Divider(),
          itemBuilder: (context, index) {
            final repo = repos[index];

            return ListTile(
              title: Text(
                repo.name,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 4),
                  Text(
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
              onTap: () async {
                try {
                  await _openRepo(repo.url);
                } catch (_) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Could not open repository')),
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

Future<void> _openRepo(String url) async {
  final uri = Uri.parse(url);

  if (!await launchUrl(uri, mode: LaunchMode.inAppBrowserView)) {
    throw Exception('Could not launch $url');
  }
}
