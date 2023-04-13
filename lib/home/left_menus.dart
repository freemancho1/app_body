import 'package:app_body/config.dart';
import 'package:app_body/home/animations.dart';
import 'package:flutter/material.dart';

class LeftMenus extends StatelessWidget {
  final CurvedAnimation animation;
  final int screenIndex;
  final bool useMaterial3;
  final bool useLightMode;
  final ColorSeed colorSeed;
  final void Function() handleMaterialVersionToggle;
  final void Function() handleLightModeToggle;
  final void Function(int) handleSelectColorSeed;
  const LeftMenus({
    super.key,
    required this.animation,
    required this.screenIndex,
    required this.useMaterial3,
    required this.useLightMode,
    required this.colorSeed,
    required this.handleMaterialVersionToggle,
    required this.handleLightModeToggle,
    required this.handleSelectColorSeed,
  });

  @override
  Widget build(BuildContext context) {
    final bool isLargeMode =
        MediaQuery.of(context).size.width > AppCfg.largeScreenWidth;
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return LeftMenuAnimation(
      animation: animation,
      backgroundColor: colorScheme.surface,
      child: NavigationRail(
        extended: isLargeMode,
        destinations: pageMenuList,
        selectedIndex: screenIndex,
        onDestinationSelected: (index) {
          setState(() {

          });
        },
      ),
    );
  }
}
