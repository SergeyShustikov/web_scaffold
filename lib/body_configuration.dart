part of 'web_scaffold.dart';

class LayoutPart {
  const LayoutPart();
}

class FlexPart extends LayoutPart {
  final int flex;
  const FlexPart({this.flex = 1});
}

class BodyPart extends FlexPart {
  const BodyPart({super.flex = 1});
}

class BodyConfiguration {
  final List<LayoutPart> items;

  const BodyConfiguration(this.items);
}
