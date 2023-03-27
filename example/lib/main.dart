import 'package:flutter/material.dart';
import 'package:web_scaffold/web_scaffold.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter Demo',
      home: ExampleUsage(),
    );
  }
}

class ExampleUsage extends StatelessWidget {
  const ExampleUsage({super.key});

  @override
  Widget build(BuildContext context) {
    return WebScaffold(
      bodyConfiguration: const BodyConfiguration(
        [
          FlexPart(1),
          BodyPart(5),
          FlexPart(1),
        ],
      ),
      header: _buildHeader(),
      headerSettings: HeaderSettings(
        headerHeight: kToolbarHeight,
        pinned: true,
      ),
      body: _buildBody(),
      footer: _buildFooter(),
      linkConfiguration: true,
    );
  }

  Container _buildFooter() {
    return Container(
      height: kToolbarHeight,
      color: Colors.yellow,
      child: const Center(
        child: Text(
          'Footer',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  Container _buildBody() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 16),
      height: 4000,
      color: Colors.blue,
      child: const Center(
        child: Text(
          'Body',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  Container _buildHeader() {
    return Container(
      color: Colors.red,
      child: const Center(
        child: Text(
          'Header',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
