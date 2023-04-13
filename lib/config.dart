import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

/// 앱에서 사용하는 화면 정의(탭에 의해 표시될 화면 정의)
enum AppScreens {
  screen1('Screen 1', 1, '',
      Icon(Icons.widgets_outlined), Icon(Icons.widgets)),
  screen2('Screen 2', 2, '',
      Icon(Icons.format_paint_outlined), Icon(Icons.format_paint)),
  screen3('Screen 3', 3, '',
      Icon(Icons.text_snippet_outlined), Icon(Icons.text_snippet)),
  screen4('Screen 4', 4, '',
      Icon(Icons.invert_colors_on_outlined), Icon(Icons.opacity));

  final String label;
  final String tooltip;
  final Icon icon;
  final Icon selectedIcon;
  final int screenNo;
  const AppScreens(
      this.label,
      this.screenNo,
      this.tooltip,
      this.icon,
      this.selectedIcon,
      );
}

/// 이 아래는 가급적 수정할 필요가 없음.
/// 이 아래는 가급적 수정할 필요가 없음.
/// 이 아래는 가급적 수정할 필요가 없음.

class AppCfg {
  /// Material3 Design 사용여부(false면 Material2 Design을 사용함)
  static const bool useMaterial3 = true;
  /// 밝은화면 사용여부(flase면 어두운화면모드)
  static bool useLightMode = Brightness.light ==
      SchedulerBinding.instance.window.platformBrightness;

  /// 화면크기 조정: 작은(모바일), 중간(테블릿), 큰(스크린) 화면
  static const double smallScreenWidth = 400;     // 400 ~ 799
  static const double mediumScreenWidth = 800;    // 800 ~ 1199
  static const double largeScreenWidth = 1200;    // 1200 ~

  /// 앱 전체에서 사용하는 애니메이션 수행시간(1000ms = 1s)
  static const double appAnimationDurations = 1000;
}

/// 기본색상을 선택하는 옵션에 사용되는 색상표(추가/삭제 가능)
enum ColorSeed {
  baseColor('M3 Baseline', Color(0xff6750a4)),
  indigo('Indigo', Colors.indigo),
  blue('Blue', Colors.blue),
  teal('Teal', Colors.teal),
  green('Green', Colors.green),
  yellow('Yellow', Colors.yellow),
  orange('Orange', Colors.orange),
  deepOrange('Deep Orange', Colors.deepOrange),
  pink('Pink', Colors.pink);

  final String label;
  final Color color;
  const ColorSeed(this.label, this.color);
}

final List<NavigationRailDestination> pageMenuList = AppScreens.values.toList()
  .map((screen) => NavigationRailDestination(
    icon: Tooltip(
      message: screen.label,
      child: screen.icon,
    ),
    selectedIcon: Tooltip(
      message: screen.label,
      child: screen.selectedIcon,
    ),
    label: Text(screen.label),
  )).toList();