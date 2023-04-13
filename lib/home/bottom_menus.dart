import 'package:app_body/config.dart';
import 'package:app_body/home/animations.dart';
import 'package:flutter/material.dart';

class BottomMenus extends StatelessWidget {
  final ReverseAnimation animation;
  final int screenIndex;
  final void Function(int) handleSelectScreen;
  const BottomMenus({
    super.key,
    required this.animation,
    required this.screenIndex,
    required this.handleSelectScreen,
  });

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return BottomMenuAnimation(
      animation: animation,
      backgroundColor: colorScheme.surface,
      child: BottomMenuBars(
        onSelectItem: handleSelectScreen,
        screenIndex: screenIndex,
      ),
    );
  }
}

class BottomMenuBars extends StatefulWidget {
  final void Function(int) onSelectItem;
  final int screenIndex;
  const BottomMenuBars({
    super.key,
    required this.onSelectItem,
    required this.screenIndex,
  });

  @override
  State<BottomMenuBars> createState() => _BottomMenuBarsState();
}

class _BottomMenuBarsState extends State<BottomMenuBars> {
  late int screenIndex;

  @override
  void initState() {
    super.initState();
    screenIndex = widget.screenIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Focus(
      autofocus: true,
      child: NavigationBar(
        selectedIndex: screenIndex,
        onDestinationSelected: (index) {
          setState(() => screenIndex = index);
          widget.onSelectItem(index);
        },
        destinations: pageMenuListInBottom,
      ),
    );
  }
}

