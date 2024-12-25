import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerCard extends StatelessWidget {
  const ShimmerCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: GridView(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3, // Empat item dalam satu baris
          mainAxisSpacing: 15, // Jarak antar baris
          crossAxisSpacing: 1, // Jarak antar kolom
          childAspectRatio: 4 / 5, // Lebar dan tinggi item sama
        ),
        padding: const EdgeInsets.all(8.0),
        children: List.generate(
          12,
          (index) => const Card(),
        ),
      ),
    );
  }
}
