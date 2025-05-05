import 'package:flutter/material.dart';

class PercentageItemWidget extends StatelessWidget {
  final String title;
  final double percentage;

  const PercentageItemWidget({
    super.key,
    required this.title,
    required this.percentage,
  });

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Text("$title:",
          style: TextStyle(
              fontSize: 12
          )),
      SizedBox(width: 5),
      Text("$percentage%",
        style: TextStyle(
            color: percentage < 0 ? Colors.red: Colors.green,
          fontSize: 12
      ),),
    ],);
  }
}
