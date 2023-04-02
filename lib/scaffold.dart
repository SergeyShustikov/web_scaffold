import 'package:flutter/material.dart';
import 'package:web_scaffold/measure_size.dart';
import 'package:web_scaffold/web_scaffold.dart';

class WebScaffold extends StatefulWidget {
  final Widget? header;
  final HeaderSettings? headerSettings;
  final FooterSettings? footerSettings;
  final Widget? footer;
  final Widget body;
  final BodyConfiguration bodyConfiguration;
  final Widget? drawer;
  final bool linkConfiguration;
  final bool expandBody;
  final Key? bodyKey;

  const WebScaffold({
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
    this.expandBody = false,
  });

  @override
  State<WebScaffold> createState() => _WebScaffoldState();
}

class _WebScaffoldState extends State<WebScaffold> {
  final ScrollController _bodyScrollController = ScrollController();
  Size? _contentSize;

  double get contentHeight => _contentSize?.height ?? 0;
  double get headerHeight => widget.headerSettings?.headerHeight ?? 0;
  double get footerHeight => widget.footerSettings?.footerHeight ?? 0;

  @override
  void initState() {
    super.initState();
    _bodyScrollController.addListener(() {
      var screenHeight = MediaQuery.of(context).size.height;

      var isConentTallerThanScreen = _bodyScrollController.position.maxScrollExtent < screenHeight;
      debugPrint('isConentTallerThanScreen = $isConentTallerThanScreen');
    });
  }

  @override
  Widget build(BuildContext context) {
    late Row bodyRow;
    Widget? headerComposedWidget, footerComposedWidet;
    if (widget.linkConfiguration) {
      headerComposedWidget = Row(
        children: _buildChild(widget.header),
      );
      footerComposedWidet = Row(
        children: _buildChild(widget.footer),
      );
    }
    bodyRow = Row(
      children: _buildChild(widget.body),
    );

    var screenHeight = MediaQuery.of(context).size.height;
    var remainingSpace = screenHeight - (headerHeight + footerHeight);
    debugPrint('remaining space = $remainingSpace');
    return Scaffold(
      drawer: widget.drawer,
      body: CustomScrollView(
        controller: _bodyScrollController,
        slivers: [
          if (widget.header != null)
            SliverAppBar(
              flexibleSpace: headerComposedWidget ?? widget.header,
              toolbarHeight: widget.headerSettings?.headerHeight ?? kToolbarHeight,
              pinned: widget.headerSettings?.pinned ?? true,
            ),
          if (!widget.expandBody || _contentSize == null)
            SliverToBoxAdapter(
              key: widget.bodyKey,
              child: MeasureSize(
                onChange: (Size size) {
                  debugPrint('ContentSize = $size');
                  setState(() {
                    _contentSize = size;
                  });
                },
                child: bodyRow,
              ),
            ),
          if (contentHeight + headerHeight + footerHeight < screenHeight)
            SliverToBoxAdapter(
              child: SizedBox(
                height: remainingSpace,
                child: widget.expandBody ? SizedBox.expand(child: bodyRow) : null,
              ),
            ),
          if (widget.footer != null)
            SliverToBoxAdapter(
              child: footerComposedWidet ?? widget.footer,
            )
        ],
      ),
    );
  }

  List<Widget> _buildChild(Widget? child) {
    if (child == null) {
      return [];
    }

    return widget.bodyConfiguration.items.map<Widget>((e) {
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
