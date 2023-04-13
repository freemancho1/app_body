import 'package:flutter/material.dart';

class SizeAnimation extends CurvedAnimation {
  SizeAnimation(Animation<double> parent) : super(
    parent: parent,
    curve: const Interval(0.2, 0.8, curve: Curves.easeInOutCubicEmphasized),
    reverseCurve: Interval(0,0.2,curve: Curves.easeInOutCubicEmphasized.flipped),
  );
}

class OffsetAnimation extends CurvedAnimation {
  OffsetAnimation(Animation<double> parent) : super(
      parent: parent,
      curve: const Interval(0.4,1,curve: Curves.easeInOutCubicEmphasized),
      reverseCurve: Interval(0,0.2,curve: Curves.easeInOutCubicEmphasized.flipped)
  );
}

class LeftMenuAnimation extends StatefulWidget {
  final Animation<double> animation;
  final Widget child;
  final Color backgroundColor;
  const LeftMenuAnimation({
    super.key,
    required this.animation,
    required this.child,
    required this.backgroundColor,
  });

  @override
  State<LeftMenuAnimation> createState() => _LeftMenuAnimationState();
}

class _LeftMenuAnimationState extends State<LeftMenuAnimation> {
  late Animation<Offset> offsetAnimation;
  late Animation<double> widthAnimation;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final bool ltr = Directionality.of(context) == TextDirection.ltr;

    offsetAnimation = Tween<Offset>(
      begin: Offset(ltr ? -1: 1, 0), end: Offset.zero,
    ).animate(OffsetAnimation(widget.animation));
    widthAnimation = Tween<double>(begin: 0, end: 1)
      .animate(SizeAnimation(widget.animation));
  }

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: DecoratedBox(
        decoration: BoxDecoration(color: widget.backgroundColor),
        child: Align(
          alignment: Alignment.topLeft,
          widthFactor: widthAnimation.value,
          child: FractionalTranslation(
            translation: offsetAnimation.value,
            child: widget.child,
          ),
        ),
      ),
    );
  }
}

class BottomMenuAnimation extends StatefulWidget {
  final Animation<double> animation;
  final Color backgroundColor;
  final Widget child;
  const BottomMenuAnimation({
    super.key,
    required this.animation,
    required this.backgroundColor,
    required this.child,
  });

  @override
  State<BottomMenuAnimation> createState() => _BottomMenuAnimationState();
}

class _BottomMenuAnimationState extends State<BottomMenuAnimation> {
  late final Animation<Offset> offsetAnimation;
  late final Animation<double> heightAnimation;

  @override
  void initState() {
    super.initState();

    offsetAnimation = Tween<Offset>(begin: const Offset(0,1), end: Offset.zero)
      .animate(OffsetAnimation(widget.animation));
    heightAnimation = Tween<double>(begin: 0, end: 1)
      .animate(SizeAnimation(widget.animation));
  }

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: DecoratedBox(
        decoration: BoxDecoration(color: widget.backgroundColor),
        child: Align(
          alignment: Alignment.topLeft,
          heightFactor: heightAnimation.value,
          child: FractionalTranslation(
            translation: offsetAnimation.value,
            child: widget.child,
          ),
        ),
      ),
    );
  }
}

