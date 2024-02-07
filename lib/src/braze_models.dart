class BrazeWebContentCards {
  /// Array of Card descendents (ClassicCard, CaptionedImage, Banner).
  final List<BrazeWebCard> cards;

  /// When this collection of cards was received from Braze servers.
  /// If null, it means the content cards are still being fetched for this user.
  final DateTime? lastUpdated;

  BrazeWebContentCards({
    this.cards = const [],
    this.lastUpdated,
  });
}

abstract class BrazeWebCard {
  /// When this card expires and should stop being shown to users.
  DateTime? expiresAt;

  /// Object of string/string key/value pairs. Default to empty object {}.
  Map<String, String> extras = {};

  /// Id of the card. This will be reported back to braze with events for analytics purposes.
  String? id;

  /// Whether to pin this card to the top of the view.
  bool pinned = false;

  /// When this card is last modified.
  DateTime? updated;

  /// Whether this card has been shown to the user.
  bool viewed = false;
}

class BrazeWebClassicCard implements BrazeWebCard {
  /// Id of the card. This will be reported back to braze with events for analytics purposes.
  String? id;

  /// Whether this card has been shown to the user.
  bool viewed;

  /// The title text for this card.
  String? title;

  /// The url for this card's image.
  String? imageUrl;

  /// The body text for this card
  String? description;

  /// Object of string/string key/value pairs. Default to empty object {}.
  @override
  Map<String, String> extras = {};

  /// The aspect ratio for this card's image. This field is meant to serve as a hint before image loading completes.
  /// Note that the field may not be supplied in certain circumstances.
  double? aspectRatio;

  /// A url to open when this card is clicked.
  String? url;

  /// Whether this card is pinned.
  @override
  bool pinned;

  /// Whether this card is dismissible.
  bool? dismissible;

  /// Whether this card has been clicked.
  bool? clicked;

  /// The categories for this card.
  List<String>? categories;

  /// The expiration date for this card.
  DateTime? expiresAt;

  /// The link text for this card.
  String? linkText;

  /// The created date for this card.
  DateTime? created;

  /// The updated date for this card.
  DateTime? updated;

  BrazeWebClassicCard({
    this.id,
    this.viewed = false,
    this.title,
    this.imageUrl,
    this.description,
    this.extras = const {},
    this.aspectRatio,
    this.url,
    this.pinned = false,
    this.dismissible,
    this.clicked,
    this.categories,
    this.expiresAt,
    this.linkText,
    this.created,
    this.updated,
  });
}

class BrazeWebControlCard implements BrazeWebCard {
  /// Id of the card. This will be reported back to braze with events for analytics purposes.
  String? id;

  /// Whether this card has been shown to the user.
  bool viewed;

  /// The updated date for this card.
  DateTime? updated;

  /// The expiration date for this card.
  DateTime? expiresAt;

  /// Object of string/string key/value pairs. Default to empty object {}.
  Map<String, String> extras;

  /// Whether this card is pinned.
  bool pinned;

  BrazeWebControlCard({
    this.id,
    this.viewed = false,
    this.updated,
    this.expiresAt,
    this.extras = const {},
    this.pinned = false,
  });
}

class BrazeWebCaptionedImage implements BrazeWebCard {
  /// Id of the card. This will be reported back to braze with events for analytics purposes.
  String? id;

  /// Whether this card has been shown to the user.
  bool viewed;

  /// The title text for this card.
  String? title;

  /// The url for this card's image.
  String? imageUrl;

  /// The body text for this card.
  String? description;

  /// Object of string/string key/value pairs. Default to empty object {}.
  Map<String, String> extras;

  /// The aspect ratio for this card's image. This field is meant to serve as a hint before image loading completes.
  /// Note that the field may not be supplied in certain circumstances.
  double? aspectRatio;

  /// A url to open when this card is clicked.
  String? url;

  /// Whether this card is pinned.
  bool pinned;

  /// Whether this card is dismissible.
  bool? dismissible;

  /// Whether this card has been clicked.
  bool? clicked;

  /// The categories for this card.
  List<String>? categories;

  /// The expiration date for this card.
  DateTime? expiresAt;

  /// The link text for this card.
  String? linkText;

  /// The created date for this card.
  DateTime? created;

  /// The updated date for this card.
  DateTime? updated;

  /// The caption for the image.
  String? caption;

  BrazeWebCaptionedImage({
    this.id,
    this.viewed = false,
    this.title,
    this.imageUrl,
    this.description,
    this.extras = const {},
    this.aspectRatio,
    this.url,
    this.pinned = false,
    this.dismissible,
    this.clicked,
    this.categories,
    this.expiresAt,
    this.linkText,
    this.created,
    this.updated,
    this.caption,
  });
}

class BrazeWebImageOnly extends BrazeWebCard {
  String? id;
  bool viewed;
  String? imageUrl;
  DateTime? created;
  DateTime? updated;
  List<String>? categories;
  DateTime? expiresAt;
  String? linkText;
  double? aspectRatio;
  String? url;
  bool pinned;
  bool? dismissible;
  bool? clicked;
  Map<String, String> extras;

  BrazeWebImageOnly({
    this.id,
    this.viewed = false,
    this.imageUrl,
    this.created,
    this.updated,
    this.extras = const {},
    this.categories,
    this.expiresAt,
    this.linkText,
    this.aspectRatio,
    this.url,
    this.pinned = false,
    this.dismissible,
    this.clicked,
  });
}

class BrazeInitializationOptions {
  bool? allowCrawlerActivity;
  bool? allowUserSuppliedJavascript;
  String? appVersion;
  String baseUrl;
  String? contentSecurityNonce;
  bool? disablePushTokenMaintenance;
  bool? doNotLoadFontAwesome;
  bool? enableLogging;
  List<String>? devicePropertyAllowlist;
  bool? enableSdkAuthentication;
  int? inAppMessageZIndex;
  String? localization;
  bool? manageServiceWorkerExternally;
  int? minimumIntervalBetweenTriggerActionsInSeconds;
  bool? noCookies;
  bool? openCardsInNewTab;
  bool? openInAppMessagesInNewTab;
  bool? requireExplicitInAppMessageDismissal;
  String? safariWebsitePushId;
  String? serviceWorkerLocation;
  int? sessionTimeoutInSeconds;

  BrazeInitializationOptions({
    this.allowCrawlerActivity,
    this.allowUserSuppliedJavascript,
    this.appVersion,
    required this.baseUrl,
    this.contentSecurityNonce,
    this.disablePushTokenMaintenance,
    this.doNotLoadFontAwesome,
    this.enableLogging,
    this.devicePropertyAllowlist,
    this.enableSdkAuthentication,
    this.inAppMessageZIndex,
    this.localization,
    this.manageServiceWorkerExternally,
    this.minimumIntervalBetweenTriggerActionsInSeconds,
    this.noCookies,
    this.openCardsInNewTab,
    this.openInAppMessagesInNewTab,
    this.requireExplicitInAppMessageDismissal,
    this.safariWebsitePushId,
    this.serviceWorkerLocation,
    this.sessionTimeoutInSeconds,
  });
}
