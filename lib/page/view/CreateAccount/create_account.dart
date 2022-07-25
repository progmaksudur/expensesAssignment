import 'package:expances_tracker/page/view/CreateAccount/create_account_desktop.dart';
import 'package:expances_tracker/page/view/CreateAccount/create_account_mobile.dart';
import 'package:expances_tracker/page/widget_model/responsive_layout.dart';
import 'package:flutter/material.dart';

class CreateAccount extends StatefulWidget {
  static const String routeName="/createaccount";
  const CreateAccount({Key? key}) : super(key: key);

  @override
  State<CreateAccount> createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(mobileLayout: CreateAccountMobile(), desktopLayout: CreateAccountDesktop());
  }
}
