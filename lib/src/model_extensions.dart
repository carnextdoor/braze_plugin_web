import 'package:braze_plugin_web/braze_plugin_web.dart';
import 'package:braze_plugin_web/src/braze_plugin_js.dart';

extension BrazeWebClassicCardExtension on BrazeWebClassicCard {
  ClassicCard createBrazeCard() {
    final extras = Extras(
      location: this.extras['location'],
      priority: this.extras['priority'],
    );
    return ClassicCard(
      this.id,
      this.viewed,
      this.title,
      this.imageUrl,
      this.description,
      this.created,
      this.updated,
      this.categories,
      this.expiresAt,
      this.url,
      this.linkText,
      this.aspectRatio,
      extras,
      this.pinned,
      this.dismissible,
      this.clicked,
    );
  }
}

extension BrazeWebImageOnlyCardExtension on BrazeWebImageOnly {
  BrazeCard createBrazeCard() {
    final extras = Extras(
      location: this.extras['location'],
      priority: this.extras['priority'],
    );
    return ImageOnly(
      this.id,
      this.viewed,
      this.imageUrl,
      this.created,
      this.updated,
      this.categories,
      this.expiresAt,
      this.linkText,
      this.aspectRatio,
      extras,
      this.url,
      this.pinned,
      this.dismissible,
      this.clicked,
    );
  }
}

extension ImageOnlyExtension on ImageOnly {
  BrazeWebCard createImageOnlyCard() {
    return BrazeWebImageOnly(
      id: id,
      viewed: viewed,
      imageUrl: imageUrl,
      aspectRatio: aspectRatio,
      url: url,
      extras: {
        'priority': extras.priority ?? '',
        'location': extras.location ?? '',
      },
      dismissible: dismissible,
      clicked: clicked,
      categories: categories,
      expiresAt: expiresAt,
      linkText: linkText,
      created: created,
      updated: updated,
    );
  }
}
