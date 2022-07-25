import 'package:expances_tracker/page/view/Home/home_layout_desktop.dart';
import 'package:expances_tracker/page/view/Home/home_layout_mobile.dart';
import 'package:expances_tracker/page/widget_model/responsive_layout.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  static const String routeName="/home";
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(mobileLayout: HomeMobile(),desktopLayout: HomeDesktop());
  }
}
