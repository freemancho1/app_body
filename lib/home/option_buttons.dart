import 'package:app_body/config.dart';
import 'package:flutter/material.dart';

class ButtonLightModeToggle extends StatelessWidget {
  final void Function() actionFunction;
  final bool showTooltipBelow;
  const ButtonLightModeToggle({
    super.key,
    required this.actionFunction,
    this.showTooltipBelow = false,
  });

  @override
  Widget build(BuildContext context) {
    final useLightMode = Theme.of(context).brightness == Brightness.light;
    return Tooltip(
      preferBelow: showTooltipBelow,
      message: '${useLightMode ? "어두운": "밝은"} 테마',
      child: IconButton(
        icon: useLightMode
          ? const Icon(Icons.dark_mode_outlined)
          : const Icon(Icons.light_mode_outlined),
        onPressed: actionFunction,
      ),
    );
  }
}

class ButtonMaterialVersionToggle extends StatelessWidget {
  final void Function() actionFunction;
  final bool showTooltipBelow;
  const ButtonMaterialVersionToggle({
    super.key,
    required this.actionFunction,
    this.showTooltipBelow = false,
  });

  @override
  Widget build(BuildContext context) {
    final useMaterial3 = Theme.of(context).useMaterial3;
    return Tooltip(
      preferBelow: showTooltipBelow,
      message: 'Material ${useMaterial3 ? 2: 3}',
      child: IconButton(
        icon: useMaterial3
          ? const Icon(Icons.filter_2)
          : const Icon(Icons.filter_3),
        onPressed: actionFunction,
      ),
    );
  }
}

class ButtonSelectColorSeed extends StatelessWidget {
  final void Function(int) actionFunction;
  final ColorSeed colorSeed;
  final bool showTooltipBelow;
  const ButtonSelectColorSeed({
    super.key,
    required this.actionFunction,
    required this.colorSeed,
    this.showTooltipBelow = false
  });

  @override
  Widget build(BuildContext context) {
    final useMaterial3 = Theme.of(context).useMaterial3;
    final useLightMode = Theme.of(context).brightness == Brightness.light;
    final isSmallMode =
      MediaQuery.of(context).size.width < AppCfg.mediumScreenWidth;

    return PopupMenuButton(
      /// 팝업버튼의 아이콘(색상은 현재 테마의 onSurfaceVariant 이용)
      icon: Icon(
        Icons.palette_outlined,
        color: !useMaterial3 && useLightMode && isSmallMode
          ? Colors.white
          : Theme.of(context).colorScheme.onSurfaceVariant,
      ),
      tooltip: showTooltipBelow ? '테마 색상 선택': '',
      /// shape에 올 수 있는 유형
      /// - ContinuousRectangleBorder - 일반적인 직사각형
      /// - RoundedRectangleBorder - 모서리 곡선 직사각형
      /// - CircleBorder - 원형
      /// - StadiumBorder - 반원(위 모서리만 곡선 직사각형)
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      itemBuilder: (context) {
        return List.generate(
          ColorSeed.values.length,
          (index) {
            ColorSeed currentSeed = ColorSeed.values[index];
            return PopupMenuItem(
              /// 해당 팝업메뉴 클릭시 인식될 값으로 ColorSeed의 일련번호임.
              value: index,
              /// 현재 Seed가 ColorSeed와 동일할 때, disable
              enabled: currentSeed != colorSeed,
              child: Wrap(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Icon(
                      currentSeed == colorSeed
                        ? Icons.color_lens
                        : Icons.color_lens_outlined,
                      color: currentSeed.color,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Text(currentSeed.label),
                  ),
                ],
              ),
            );
          }
        );
      },
      /// 이렇게 하면 PopupMenuItem에서 선택한 value값을 인수로 아래 함수가 수행됨
      onSelected: actionFunction,
    );
  }
}

