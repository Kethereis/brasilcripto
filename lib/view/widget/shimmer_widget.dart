import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../core/app_constants.dart';

class ShimmerWidget extends StatelessWidget {
  const ShimmerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: ColorsConstants.initShimmerColor,
      highlightColor: ColorsConstants.finishShimmerColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: Colors.grey,
              shape: BoxShape.circle,
            ),
          ),
          SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(width: 120, height: 16, color: Colors.grey),
              SizedBox(height: 8),
              Container(width: 80, height: 14, color: Colors.grey),
            ],
          ),
        ],
      ),
    );
  }
}
