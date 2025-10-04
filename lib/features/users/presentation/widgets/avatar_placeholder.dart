import 'package:flutter/material.dart';
import 'package:stackoverflow_users_app/gen/colors.gen.dart';

class AvatarPlaceholder extends StatelessWidget {
  final double size;

  const AvatarPlaceholder({super.key, required this.size});

  @override
  Widget build(BuildContext context) => Container(
        width: size,
        height: size,
        color: ColorName.sofBorder,
        alignment: Alignment.center,
        child: const Icon(Icons.person, color: ColorName.sofMuted),
      );
}
