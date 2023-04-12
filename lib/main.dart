import 'package:app_body/config.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const FlutterApp());
}

class FlutterApp extends StatefulWidget {
  const FlutterApp({Key? key}) : super(key: key);

  @override
  State<FlutterApp> createState() => _FlutterAppState();
}

class _FlutterAppState extends State<FlutterApp> {
  bool useMaterial3 = AppCfg.useMaterial3;
  bool useLightMode = AppCfg.useLightMode;
  ColorSeed colorSeed = ColorSeed.baseColor;

  /// 아래 3개의 handle을 이용해 전체 앱의 state를 변경함
  /// 여기서 지접 사용하는것이 아니고 하위 위젯에게 전달해 하위 위젯이 전체 앱을 변경하도록 함
  void handleMaterialVersionToggle() {
    setState(() => useMaterial3 = !useMaterial3);
  }
  void handleLightModeToggle() {
    setState(() => useLightMode = !useLightMode);
  }
  void handleSelectColorSeed(int colorIndex) {
    setState(() => colorSeed = ColorSeed.values[colorIndex]);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter App',
      themeMode: useLightMode ? ThemeMode.light : ThemeMode.dark,
      theme: ThemeData(
        colorSchemeSeed: colorSeed.color,
        useMaterial3: useMaterial3,
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
        colorSchemeSeed: colorSeed.color,
        useMaterial3: useMaterial3,
        brightness: Brightness.dark
      ),
      /// Todo: Continue...
    );
  }
}
