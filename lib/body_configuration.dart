part of 'web_scaffold.dart';

class LayoutPart {
  const LayoutPart();
}

class FlexPart extends LayoutPart {
  final int flex;
  const FlexPart(this.flex);
}

class BodyPart extends FlexPart {
  const BodyPart(super.flex);
}

class BodyConfiguration {
  final List<LayoutPart> items;

  const BodyConfiguration(this.items);
}
