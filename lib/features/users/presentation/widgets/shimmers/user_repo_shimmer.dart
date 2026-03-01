import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class UserReposShimmer extends StatelessWidget {
  const UserReposShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: 6,
        separatorBuilder: (_, _) => const Divider(),
        itemBuilder: (_, _) => const _RepoTileShimmer(),
      ),
    );
  }
}

class _RepoTileShimmer extends StatelessWidget {
  const _RepoTileShimmer();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Repo name
          Container(width: 160, height: 14, color: Colors.white),
          const SizedBox(height: 8),

          // Description
          Container(width: double.infinity, height: 12, color: Colors.white),
          const SizedBox(height: 6),
          Container(width: 220, height: 12, color: Colors.white),
          const SizedBox(height: 8),

          // Language + stars row
          Row(
            children: [
              Container(
                width: 10,
                height: 10,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 8),
              Container(width: 60, height: 12, color: Colors.white),
              const SizedBox(width: 16),
              Container(width: 40, height: 12, color: Colors.white),
            ],
          ),
        ],
      ),
    );
  }
}
