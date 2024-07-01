import 'package:blinqpay/presentations/shared/utils/space.dart';
import 'package:blinqpay/presentations/theme/app_color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class PostTextComponent extends StatefulWidget {
  final String description;
  const PostTextComponent({super.key, required this.description});

  @override
  State<PostTextComponent> createState() => _PostTextComponentState();
}

class _PostTextComponentState extends State<PostTextComponent> {
  int cutOffLength = 100;
  bool showMiniContent = true;
  bool overThresholdLength = false;

  @override
  void initState() {
    super.initState();
    overThresholdLength = widget.description.length > cutOffLength;
  }

  @override
  Widget build(BuildContext context) {
    if (!overThresholdLength) {
      return Text(
        widget.description,
        textAlign: TextAlign.justify,
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          showMiniContent
              ? "${widget.description.substring(0, cutOffLength)} ..."
              : widget.description,
          textAlign: TextAlign.justify,
        ),
        yspace(6),
        GestureDetector(
          onTap: () => setState(() {
            showMiniContent = !showMiniContent;
          }),
          child: Container(
            alignment: Alignment.centerLeft,
            width: w(100),
            height: h(25),
            child: Text(
              showMiniContent ? "See More" : "See Less",
              textAlign: TextAlign.justify,
              style: TextStyle(fontSize: fs(12), color: AppColors.primaryColor),
            ),
          ),
        ),
      ],
    );
  }
}
