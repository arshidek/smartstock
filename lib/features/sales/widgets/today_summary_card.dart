import 'package:flutter/material.dart';

class TodaySummaryCard extends StatelessWidget {
  final String title;
  final String value;
  final Color valueColor;

  const TodaySummaryCard({
    required this.title,
    required this.value,
    required this.valueColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Colors.grey,
            fontWeight: FontWeight.w600,
            fontSize: 13,
          ),
        ),

        const SizedBox(height: 6),

        FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            value,
            style: TextStyle(
              color: valueColor,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ),
      ],
    );
  }
}
