import 'package:flutter/material.dart';

class ResponsiveLayout extends StatelessWidget {
  final Widget mobileLayout;
  final Widget desktopLayout;

  ResponsiveLayout({
    required this.mobileLayout,
    required this.desktopLayout,
  });
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context,constraints){
      if(constraints.maxWidth<=650){
        return mobileLayout;
      }
      else{
        return desktopLayout;
      }

    });
  }
}
