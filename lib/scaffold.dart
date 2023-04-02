import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:web_scaffold/web_scaffold.dart';

class WebScaffold extends StatelessWidget {
  final Widget? header;
  final HeaderSettings? headerSettings;
  final FooterSettings? footerSettings;
  final Widget? footer;
  final Widget body;
  final BodyConfiguration bodyConfiguration;
  final Widget? drawer;
  final bool linkConfiguration;
  final Key? bodyKey;
  final ScrollController _bodyScrollController = ScrollController();
  WebScaffold({
    super.key,
    this.bodyKey,
    this.header,
    this.headerSettings,
    this.footer,
    this.footerSettings,
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

    var screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      drawer: drawer,
      body: CustomScrollView(
        controller: _bodyScrollController,
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
          if (_bodyScrollController.position.maxScrollExtent < screenHeight)
            SliverLayoutBuilder(
              builder: (BuildContext context, SliverConstraints constraints) {
                var remainingSpaceCandidateHeight =
                    constraints.remainingPaintExtent - (footerSettings?.footerHeight ?? 0);
                return SliverToBoxAdapter(child: Container(height: remainingSpaceCandidateHeight));
              },
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
