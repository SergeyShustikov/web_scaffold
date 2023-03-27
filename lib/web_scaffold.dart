import 'package:flutter/material.dart';

part 'body_configuration.dart';

class WebScaffold extends StatelessWidget {
  final Widget? header;
  final Widget? footer;
  final Widget body;
  final BodyConfiguration bodyConfiguration;
  final Widget? drawer;
  final bool linkConfiguration;
  final bool pinnedHeader;

  const WebScaffold({
    super.key,
    this.header,
    this.footer,
    required this.body,
    this.drawer,
    required this.bodyConfiguration,
    this.linkConfiguration = true,
    this.pinnedHeader = true,
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
          SliverAppBar(
            flexibleSpace: headerComposedWidget ?? header,
            pinned: pinnedHeader,
          ),
          SliverToBoxAdapter(
            child: bodyRow,
          ),
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
