import 'package:brasilcripto/core/app_constants.dart';
import 'package:brasilcripto/core/utils.dart';
import 'package:flutter/material.dart';

class PopularCoinWidget extends StatelessWidget {
  final String name;
  final String amountBRL;
  final String symbol;
  final String iconPath;

  const PopularCoinWidget({
    super.key,
    required this.name,
    required this.amountBRL,
    required this.symbol,
    required this.iconPath,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
        children: [
          CircleAvatar(
            backgroundColor: Colors.transparent,
            radius: 15,
            backgroundImage: NetworkImage(iconPath),
          ),
          SizedBox(width: 12),
              Text(
                name.truncateWithEllipsis(TextConstants.countTruncateText),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16
                ),
              ),
          Spacer(),
      Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
            Text(
              amountBRL,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
        Text(
          symbol,
          style: TextStyle(
            color: Colors.grey[500],
            fontSize: 14,
          ),
        ),
      ])
        ],
    );
  }
}
