import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class UserListShimmer extends StatelessWidget {
  const UserListShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: 10,
      separatorBuilder: (_, _) => const Divider(height: 1),
      itemBuilder: (context, index) => const _UserTileShimmer(),
    );
  }
}

class _UserTileShimmer extends StatelessWidget {
  const _UserTileShimmer();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        child: Row(
          children: [
            // avatar
            Container(height: 40, width: 40, color: Colors.white),
            const SizedBox(width: 12),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // username
                  Container(
                    height: 14,
                    width: double.infinity,
                    color: Colors.white,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      // language
                      Container(height: 10, width: 60, color: Colors.white),
                      const SizedBox(width: 8),
                      // star
                      Container(height: 10, width: 40, color: Colors.white),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),

            // chevron
            Container(height: 16, width: 16, color: Colors.white),
          ],
        ),
      ),
    );
  }
}
