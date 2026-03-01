import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class UserHeaderShimmer extends StatelessWidget {
  const UserHeaderShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        child: Column(
          children: [
            // avatar
            Container(
              width: 100,
              height: 100,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 16),

            // username
            Container(width: 140, height: 16, color: Colors.white),
            const SizedBox(height: 8),

            // fullname
            Container(width: 180, height: 14, color: Colors.white),
            const SizedBox(height: 20),

            // followers and following
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [_countBox(), const SizedBox(width: 40), _countBox()],
            ),
          ],
        ),
      ),
    );
  }

  Widget _countBox() {
    return Column(
      children: [
        Container(width: 40, height: 14, color: Colors.white),
        const SizedBox(height: 6),
        Container(width: 60, height: 12, color: Colors.white),
      ],
    );
  }
}
