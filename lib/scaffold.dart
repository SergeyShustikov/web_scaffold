import 'package:flutter/material.dart';
import 'package:web_scaffold/web_scaffold.dart';

class WebScaffold extends StatelessWidget {
  final Widget? header;
  final HeaderSettings? headerSettings;
  final Widget? footer;
  final Widget body;
  final BodyConfiguration bodyConfiguration;
  final Widget? drawer;
  final bool linkConfiguration;
  final Key? bodyKey;
  const WebScaffold({
    super.key,
    this.bodyKey,
    this.header,
    this.headerSettings,
    this.footer,
    required this.body,
    this.drawer,
    required this.bodyConfiguration,
    this.linkConfiguration = true,
  });

  @override
  Widget build(BuildContext context) {
    late Row bodyRow;
    Widget? headerComposedWidget, footerComposedWidet;
    if (linkConfiguration) {
      headerComposedWidget = Row(
        children: _buildChild(header),
      );
      footerComposedWidet = Row(
        children: _buildChild(footer),
      );
    }
    bodyRow = Row(
      children: _buildChild(body),
    );

    return Scaffold(
      drawer: drawer,
      body: CustomScrollView(
        slivers: [
          if (header != null)
            SliverAppBar(
              flexibleSpace: headerComposedWidget ?? header,
              toolbarHeight: headerSettings?.headerHeight ?? kToolbarHeight,
              pinned: headerSettings?.pinned ?? true,
            ),
          SliverToBoxAdapter(
            key: bodyKey,
            child: bodyRow,
          ),
          if (footer != null)
            SliverToBoxAdapter(
              child: footerComposedWidet ?? footer,
            )
        ],
      ),
    );
  }

  List<Widget> _buildChild(Widget? child) {
    if (child == null) {
      return [];
    }

    return bodyConfiguration.items.map<Widget>((e) {
      if (e is BodyPart) {
        return Flexible(flex: e.flex, child: child);
      } else if (e is FlexPart) {
        return Flexible(
          flex: e.flex,
          child: Container(),
        );
      }
      {
        return const SizedBox.shrink();
      }
    }).toList();
  }
}
