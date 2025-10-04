import 'package:flutter/material.dart';

class SliverGroup extends StatelessWidget {
  const SliverGroup({super.key, required this.children});
  final List<Widget> children;

  @override
  Widget build(BuildContext context) => CustomScrollView(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        slivers: children,
      );
}
