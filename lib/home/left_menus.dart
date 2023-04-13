import 'package:app_body/config.dart';
import 'package:app_body/home/animations.dart';
import 'package:flutter/material.dart';

import 'option_buttons.dart';

class LeftMenus extends StatelessWidget {
  final CurvedAnimation animation;
  final int screenIndex;
  final bool useMaterial3;
  final bool useLightMode;
  final ColorSeed colorSeed;
  final void Function() handleMaterialVersionToggle;
  final void Function() handleLightModeToggle;
  final void Function(int) handleSelectColorSeed;
  final void Function(int) handleSelectScreen;
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
    required this.handleSelectScreen,
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
        destinations: pageMenuListInLeft,
        selectedIndex: screenIndex,
        onDestinationSelected: handleSelectScreen,
        /// 좌측 하단 메뉴
        trailing: Expanded(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: isLargeMode
              ? _largeModeTrailingAction()
              : _mediumModeTrailingAction(),
          ),
        ),
      ),
    );
  }

  /// 큰 화면에서 사용하는 좌측하단 메뉴
  Widget _largeModeTrailingAction() => Container(
    constraints: const BoxConstraints.tightFor(width: 250),
    padding: const EdgeInsets.symmetric(horizontal: 30),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            const Text('밝기 테마'),
            Expanded(child: Container()),
            Switch(
              value: useLightMode,
              onChanged: (_) => handleLightModeToggle(),
            ),
          ],
        ),
        Row(
          children: [
            Text('Material ${useMaterial3 ? 3: 2}'),
            Expanded(child: Container()),
            Switch(
              value: useMaterial3,
              onChanged: (_) => handleMaterialVersionToggle(),
            )
          ],
        ),
        const Divider(height: 50,),
        ConstrainedBox(
          constraints: const BoxConstraints(maxHeight: 200),
          child: GridView.count(
            crossAxisCount: 3,
            children: List.generate(
              ColorSeed.values.length,
              (index) => IconButton(
                icon: const Icon(Icons.radio_button_unchecked),
                color: ColorSeed.values[index].color,
                isSelected: colorSeed == ColorSeed.values[index],
                selectedIcon: const Icon(Icons.circle),
                onPressed: () => handleSelectColorSeed(index),
              )
            ),
          ),
        )
      ],
    ),
  );

  /// 중간 화면에서 사용하는 좌측하단 메뉴
  Widget _mediumModeTrailingAction() => Column(
    mainAxisAlignment: MainAxisAlignment.end,
    children: [
      /// 자식 위젯의 크기를 적절히 조정해, 컬럼 내에서 적절한 공간을 확보함.
      Flexible(child: ButtonLightModeToggle(
        actionFunction: handleLightModeToggle,
        showTooltipBelow: false,
      ),),
      Flexible(child: ButtonMaterialVersionToggle(
        actionFunction: handleMaterialVersionToggle,
        showTooltipBelow: false,
      ),),
      Flexible(child: ButtonSelectColorSeed(
        actionFunction: handleSelectColorSeed,
        colorSeed: colorSeed,
      ),),
    ],
  );
}
