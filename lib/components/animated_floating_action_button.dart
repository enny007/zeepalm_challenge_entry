import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zeepalm_challenge_entry/providers/ui_providers.dart';
import 'package:zeepalm_challenge_entry/utils/colors.dart';

class AnimatedFloatingActionButton extends ConsumerStatefulWidget {
  const AnimatedFloatingActionButton({
    Key? key,
    required this.icon,
    required this.animationDuration,
    required this.animationCurve,
    required this.onPressed,
  }) : super(key: key);

  final IconData icon;
  final Duration animationDuration;
  final Curve animationCurve;
  final VoidCallback onPressed;

  @override
  ConsumerState<AnimatedFloatingActionButton> createState() =>
      _AnimatedFloatingActionButtonState();
}

class _AnimatedFloatingActionButtonState
    extends ConsumerState<AnimatedFloatingActionButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: widget.animationDuration,
    )..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _animationController.reverse();
        } else if (status == AnimationStatus.dismissed) {
          _animationController.forward();
        }
      });
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final fabKey = ref.watch(fabKeyProvider);
    return RotationTransition(
      turns: Tween(begin: 0.0, end: 0.05).animate(_animationController),
      child: FloatingActionButton(
        backgroundColor: AppColors.primaryColor,
        key: fabKey,
        onPressed: () {
          widget.onPressed();
        },
        child: Icon(
          widget.icon,
          color: Colors.white,
        ),
      ),
    );
  }
}
