import 'package:expances_tracker/page/view/LogIN/login_mobile.dart';
import 'package:expances_tracker/page/view/LogIN/login_page_desktop.dart';
import 'package:expances_tracker/page/widget_model/responsive_layout.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  static const String routeName="/loginPage";
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(mobileLayout: LogInPageMobile(), desktopLayout:LoginPageDesktop());
  }
}
