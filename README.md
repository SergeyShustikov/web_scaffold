# web_scaffold

A Flutter plugin that allows you to create webpages faster.

![image](https://img.shields.io/badge/STATUS-BETA-blueviolet?style=for-the-badge)

## Getting Started

### Parameters

```dart

  @override
  Widget build(BuildContext context) {
    return WebScaffold(
      // required
      bodyConfiguration: const BodyConfiguration(
        [
          FlexPart(1), // similar to Flexible with flex 1
          BodyPart(5), // similar to Flexible with body as child with flex 5
          FlexPart(1), // // similar to Flexible with flex 1
        ],
      ),
      header: _buildHeader(),
      headerSettings: HeaderSettings(
        headerHeight: kToolbarHeight,
        pinned: true,
      ),
      body: _buildBody(), // required
      footer: _buildFooter(),
      linkConfiguration: true, // Header and footer will take the same flexible space. default = true
    );
  }
```
