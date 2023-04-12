import 'package:app_body/config.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  final bool useMaterial3;
  final bool useLightMode;
  final ColorSeed colorSeed;
  final void Function() handleMaterialVersionToggle;
  final void Function() handleLightModeToggle;
  final void Function(int) handleSelectColorSeed;
  const Home({
    super.key,
    required this.useMaterial3,
    required this.useLightMode,
    required this.colorSeed,
    required this.handleMaterialVersionToggle,
    required this.handleLightModeToggle,
    required this.handleSelectColorSeed,
  });

  @override
  State<Home> createState() => _HomeState();
}

/// App 전체적인 애니메이션 처리를 위해 SingleTickerProviderStateMixin 추가
class _HomeState extends State<Home>
    with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  late final AnimationController controller;
  late final CurvedAnimation railAnimation;

  /// 이 위젯이 실행후 최초로 실행되나 확인
  /// 처음 실행되는 경우 화면 크기를 확인해 애니메이션을 강제 실행해줌.
  bool isInitialized = false;

  /// 화면모드
  bool isSmallMode = false;
  bool isMediumMode = false;
  bool isLargeMode = false;

  /// 화면 번호(초기값: 첫번째 화면 번호)
  int screenIndex = AppScreens.values[0].screenNo;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this, value: 0,
      duration: Duration(milliseconds: AppCfg.appAnimationDurations.toInt()),
    );
    railAnimation = CurvedAnimation(
        parent: controller, curve: const Interval(0, 1)
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  /// 위젯에 영향을 주는 의존성의 변화를 감지
  /// 여기서는 화면의 크기 변화를 감지해 적절한 화면 모드를 취하고,
  /// 해당 화면모드에 맞게 애니메이션이 적용됨을 구현함.
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final double screenWidth = MediaQuery.of(context).size.width;
    final AnimationStatus status = controller.status;

    if (screenWidth > AppCfg.mediumScreenWidth) {
      if (screenWidth > AppCfg.largeScreenWidth) {
        isSmallMode = false;
        isMediumMode = false;
        isLargeMode = true;
      } else {
        isSmallMode = false;
        isMediumMode = true;
        isLargeMode = false;
      }
      /// 중간이상의 화면크기에서 좌측 메뉴의 애니메이션이
      /// 펼쳐지고 있지 않거나 펼쳐져 있지 않으면 좌측 메뉴를 펼침
      if (status != AnimationStatus.forward &&
          status != AnimationStatus.completed) {
        controller.forward();
      }
    } else {
      /// 작은 화면크기
      isSmallMode = true;
      isMediumMode = false;
      isLargeMode = false;
      /// 닫히고 있지 않거나 닫혀 있지 않으면 좌측 메뉴를 닫음.
      if (status != AnimationStatus.reverse &&
          status != AnimationStatus.dismissed) {
        controller.reverse();
      }
    }

    /// 최초 한번 수행되며, 컨트롤러가 초기화 되지 않는 상태에서 위젯일 화면에 호출될 때,
    /// 화면이 중간크기 이상의 사이즈면, 좌측 메뉴를 보이게 함.
    if (!isInitialized) {
      isInitialized = true;
      controller.value = screenWidth > AppCfg.mediumScreenWidth ? 1: 0;
    }
  }

  PreferredSizeWidget createAppBar() {
    return AppBar(
      title: Text('Material ${widget.useMaterial3 ? 3: 2}'),
      /// 작은화면일 때만 액션바에 설정버튼이 표시됨(중간 이상에서는 좌측 메뉴에 표시)
      // actions: [],
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
