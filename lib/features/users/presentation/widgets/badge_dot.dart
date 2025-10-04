import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BadgeDot extends StatelessWidget {
  const BadgeDot({super.key, required this.color, required this.count});
  final Color color;
  final int count;

  @override
  Widget build(BuildContext context) => Row(
        spacing: 4.w,
        children: [
          Container(
              width: 8.r,
              height: 8.r,
              decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
          Text('$count', style: Theme.of(context).textTheme.bodySmall),
        ],
      );
}
