import 'package:flutter/material.dart';

class SystemBars{
  AppBar getAppBar({Widget? pageTitle, Color? colorAppBar}) {
    return AppBar(
      automaticallyImplyLeading: true,
      backgroundColor: colorAppBar ?? Colors.transparent,
      elevation: 0,
      bottomOpacity: 0,
      toolbarHeight: 100,
      title: pageTitle,
      centerTitle: true,
    );
  }

  AppBar getNormalAppBar({Widget? pageTitle, Color? colorAppBar}) {
    return AppBar(
      automaticallyImplyLeading: true,
      backgroundColor: colorAppBar ?? Colors.transparent,
      elevation: 0,
      bottomOpacity: 0,
      title: pageTitle,
      centerTitle: true,
    );
  }
}