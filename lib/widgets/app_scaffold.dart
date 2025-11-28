import 'package:flutter/material.dart';

class AppScaffold extends StatelessWidget {
  const AppScaffold({
    super.key,
    required this.body,
    this.title,
    this.titleWidget,
    this.actions,
    this.centerTitle = true,
    this.floatingActionButton,
    this.floatingActionButtonLocation,
    this.backgroundColor,
    this.appBar,
    this.bottomNavigationBar,
  }) : assert(title == null || titleWidget == null);

  final Widget body;
  final String? title;
  final Widget? titleWidget;
  final List<Widget>? actions;
  final bool centerTitle;
  final Widget? floatingActionButton;
  final FloatingActionButtonLocation? floatingActionButtonLocation;
  final Color? backgroundColor;
  final PreferredSizeWidget? appBar;
  final Widget? bottomNavigationBar;

  @override
  Widget build(BuildContext context) {
    final PreferredSizeWidget? resolvedAppBar =
        appBar ??
        ((title != null || titleWidget != null)
            ? AppBar(
              title: titleWidget ?? Text(title!),
              centerTitle: centerTitle,
              actions: actions,
            )
            : null);

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: resolvedAppBar,
      body: body,
      floatingActionButton: floatingActionButton,
      floatingActionButtonLocation: floatingActionButtonLocation,
      bottomNavigationBar: bottomNavigationBar,
    );
  }
}
