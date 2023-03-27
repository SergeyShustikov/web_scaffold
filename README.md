# web_scaffold

A Flutter plugin that allows you to create webpages faster.

## Getting Started

### Parameters

```dart

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
      body: _buildBody(),
      footer: _buildFooter(),
      linkConfiguration: true, // Header and footer will take the same flexible space. default = true
      pinnedHeader: true, // Does the header is the part of body or not. default = true
    );
  }
```

### Usage

```dart

class ExampleUsage extends StatelessWidget {
  const ExampleUsage({super.key});

  @override
  Widget build(BuildContext context) {
    return WebScaffold(
      bodyConfiguration: const BodyConfiguration([
        FlexPart(1),
        BodyPart(5),
        FlexPart(1),
      ]),
      header: _buildHeader(),
      body: _buildBody(),
      footer: _buildFooter(),
      linkConfiguration: true,
      pinnedHeader: true,
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


```
