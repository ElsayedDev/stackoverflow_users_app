import 'dart:async';

import 'package:flutter/material.dart';

enum Scaling { scaleDown, scaleUp }

/// AnimatedScalingButton
///
/// Is a button that scales down when pressed and scales up when released.
///
/// It not full button, it's just a `wrapper` for the child widget.
///
/// Recommended scale value around 0.9. i.e 0.98 / 0.85.
///
/// Recommended for Selection Behaviors/Targets.
///
/// Not Recommended to use onPressed / Pressing Action above it.
///
/// use `onPressed` to handle the action.
///
/// use `scaling` to handle the scaling direction. [Scaling] enum. will help.
///
/// use `scale` to handle the scale value. default is 0.9.
///
class AnimatedScalingButton extends StatefulWidget {
  /// recommended scale value around 0.9
  final double scale;
  final Scaling scalingDirection;
  final VoidCallback? onPressed;
  final Widget child;
  final bool isEnabled;

  const AnimatedScalingButton({
    super.key,
    this.scale = 0.9,
    this.onPressed,
    this.scalingDirection = Scaling.scaleDown,
    this.isEnabled = true,
    required this.child,
  });

  @override
  State<AnimatedScalingButton> createState() => _AnimatedScalingButtonState();
}

class _AnimatedScalingButtonState extends State<AnimatedScalingButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 100),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Animation<double> get scaling => switch (widget.scalingDirection) {
        Scaling.scaleDown => Tween<double>(
            begin: 1.0,
            end: widget.scale,
          ).animate(_controller),
        Scaling.scaleUp => Tween<double>(
            begin: widget.scale,
            end: 1.0,
          ).animate(_controller),
      };

  @override
  Widget build(BuildContext context) => switch (widget.isEnabled) {
        true => GestureDetector(
            onTapDown: (_) => _handleActionStart(),
            onTapCancel: _handleActionEnd,
            onTap: _handlePressing,
            child: ScaleTransition(
              scale: scaling,
              child: widget.child,
            ),
          ),
        false => widget.child,
      };

  void _handlePressing() {
    _handleActionStart();

    Timer(const Duration(milliseconds: 100), () {
      if (mounted) _handleActionEnd();
    });

    widget.onPressed?.call();
  }

  void _handleActionStart() {
    _controller.forward();
  }

  void _handleActionEnd() {
    if (mounted) _controller.reverse();
  }
}
