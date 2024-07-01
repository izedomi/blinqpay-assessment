import 'package:blinqpay/presentations/shared/utils/space.dart';
import 'package:flutter/material.dart';

class EngagementSummaryComponent extends StatelessWidget {
  final String engagement;
  final String summary;
  const EngagementSummaryComponent(
      {super.key, required this.engagement, required this.summary});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          engagement,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: fs(18),
          ),
        ),
        yspace(12),
        Text(
          summary,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: fs(20),
          ),
        ),
      ],
    );
  }
}
