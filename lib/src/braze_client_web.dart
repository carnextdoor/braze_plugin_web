import 'package:braze_plugin_web/src/braze_client.dart';
import 'package:braze_plugin_web/src/braze_models.dart';
import 'package:braze_plugin_web/src/model_extensions.dart';
import 'package:flutter/foundation.dart';
import 'package:braze_plugin_web/src/braze_plugin_js.dart';
import 'package:js/js.dart';
import 'dart:developer';

class BrazeClientImpl implements BrazeClient{
  BrazeClientImpl._();

  static BrazeClient get instance => BrazeClientImpl._();

  /// Alternative to calling [initialize], allowing the provision of [InitializationOptions]
  @override
  void initializeWithOptions({
    required String apiKey,
    required BrazeInitializationOptions options,
    bool automaticallyShowInAppMessages = false,
  }) {
    InitializationOptions initializationOptions = InitializationOptions(
      allowCrawlerActivity: options.allowCrawlerActivity,
      allowUserSuppliedJavascript: options.allowUserSuppliedJavascript,
      appVersion: options.appVersion,
      baseUrl: options.baseUrl,
      contentSecurityNonce: options.contentSecurityNonce,
      disablePushTokenMaintenance: options.disablePushTokenMaintenance,
      doNotLoadFontAwesome: options.doNotLoadFontAwesome,
      enableLogging: options.enableLogging,
      devicePropertyAllowlist: options.devicePropertyAllowlist,
      enableSdkAuthentication: options.enableSdkAuthentication,
      inAppMessageZIndex: options.inAppMessageZIndex,
      localization: options.localization,
      manageServiceWorkerExternally: options.manageServiceWorkerExternally,
      minimumIntervalBetweenTriggerActionsInSeconds: options.minimumIntervalBetweenTriggerActionsInSeconds,
      noCookies: options.noCookies,
      openCardsInNewTab: options.openCardsInNewTab,
      openInAppMessagesInNewTab: options.openInAppMessagesInNewTab,
      requireExplicitInAppMessageDismissal: options.requireExplicitInAppMessageDismissal,
      safariWebsitePushId: options.safariWebsitePushId,
      serviceWorkerLocation: options.serviceWorkerLocation,
      sessionTimeoutInSeconds: options.sessionTimeoutInSeconds,
    );

    BrazePluginJS.initialize(apiKey, initializationOptions);

    if (automaticallyShowInAppMessages) {
      BrazePluginJS.automaticallyShowInAppMessages();
    }
  }

  /// An initializer for the [BrazeClient]. This or [initializeWithOptions]
  /// ***must*** be called for further operation with the [BrazeClient]
  @override
  void initialize({
    required String apiKey,
    required String baseUrl,
    bool automaticallyShowInAppMessages = false,
    bool manageServiceWorkerExternally = false,
    bool enableLogging = false,
  }) {
    final options = InitializationOptions(
      baseUrl: baseUrl,
      enableLogging: enableLogging,
      manageServiceWorkerExternally: manageServiceWorkerExternally,
    );

    BrazePluginJS.initialize(apiKey, options);

    if (automaticallyShowInAppMessages) {
      BrazePluginJS.automaticallyShowInAppMessages();
    }
  }

  /// Performs [BrazePluginJS.changeUser] and [BrazePluginJS.openSession] for
  /// the provided [userId], starting a new session for the provided credential.
  /// [BrazeClient.initialize] or [BrazeClient.initializeWithOptions]
  /// must be called before calling this
  @override
  void identify(String userId) {
    BrazePluginJS.changeUser(userId, null);
  }

  @override
  void openSession() {
    BrazePluginJS.openSession();
  }

  /// Sets [value] as a custom attribute for the given [ BrazePluginJS.getUser]
  ///
  /// [BrazeClient.initialize] or [BrazeClient.initializeWithOptions]
  /// must be called before calling this
  @override
  void setCustomAttribute(
      String key,
      dynamic value, {
        bool flush = false,
      }) {
    final user = BrazePluginJS.getUser();
    user.setCustomUserAttribute(key, value, false);

    if (flush) BrazePluginJS.requestImmediateDataFlush();
  }

  /// Sets [attributes] for the given [BrazePluginJS.getUser]
  ///
  /// [BrazeClient.initialize] or [BrazeClient.initializeWithOptions]
  /// must be called before calling this
  @override
  void setCustomAttributes(
      Map<String, dynamic> attributes, {
        bool flush = false,
      }) {
    var user = BrazePluginJS.getUser();
    attributes.forEach((key, value) {
      user.setCustomUserAttribute(key, value, false);
    });

    if (flush) BrazePluginJS.requestImmediateDataFlush();
  }

  /// Logs a custom event [key] to braze with [properties]
  /// that are [jsonEncode]'d.
  ///
  /// [BrazeClient.initialize] or [BrazeClient.initializeWithOptions]
  /// must be called before calling this
  @override
  void logCustomEvent(
      String key,
      String? properties, {
        bool flush = false,
      }) {
    final brazeProperties = properties == null || properties.isEmpty ? properties : jsonParse(properties);
    BrazePluginJS.logCustomEvent(key, brazeProperties);
    if (flush) BrazePluginJS.requestImmediateDataFlush();
  }

  /// Requests an immediate refresh of content cards from Braze servers. By default, content cards are refreshed when a
  /// new session opens (see 'openSession` for more details), and when the user refreshes content cards
  /// manually via the refresh button. If you want to refresh content cards from the server at another time you must call this function.
  @override
  void requestContentCardRefresh({
    Function? successCallBack,
    Function? errorCallBack,
  }) {
    final successCallBackSubscriber =
    allowInterop(successCallBack ?? () => debugPrint('$BrazeClient: content cards refreshed.'));

    final errorCallBackSubscriber =
    allowInterop(errorCallBack ?? () => debugPrint('$BrazeClient: content cards refresh failed.'));

    BrazePluginJS.requestContentCardsRefresh(
      successCallBackSubscriber,
      errorCallBackSubscriber,
    );
  }

  /// Subscribe to content cards updates. The callback will be called whenever content cards are updated.
  /// This method should be called before calling openSession.
  ///
  /// [BrazeClient.initialize] or [BrazeClient.initializeWithOptions]
  /// must be called before calling this
  ///
  /// Returns string | undefined
  /// The identifier of the subscription created. This can be passed to removeSubscription to cancel the subscription. Returns undefined if the SDK has not been initialized.
  @override
  String subscribeToContentCardsUpdates(
      Function(BrazeWebContentCards cards) callBack,
      ) {
    final subscriber = (ContentCards cardsData) {
      List<BrazeCard> brazeCards = cardsData.cards;
      List<BrazeWebCard> contentCards = [];
      for (BrazeCard card in brazeCards) {
        final bool isCardAlreadyAdded = contentCards.indexWhere((c) => c.id == card.id) > -1;
        // The SDK gives same content card multiples times.
        // To solve this we add content card if it is not already added to the list
        if (!isCardAlreadyAdded) {
          final imageOnly = card as ImageOnly;
          contentCards.add(imageOnly.createImageOnlyCard());
        }
      }
      callBack(BrazeWebContentCards(cards: contentCards, lastUpdated: cardsData.lastUpdated));
    };

    final result = BrazePluginJS.subscribeToContentCardsUpdates(allowInterop(subscriber));
    return result ?? '';
  }

  /// A convenient method to log when user clicks on a Content Card.
  /// This method is equivalent to calling [logCardClick method with forContentCards param set to true.
  /// This is done automatically when you use Braze's display module and should only be called if you're
  /// bypassing that and manually building the DOM for displaying content cards in your own code.
  @override
  bool logContentCardClick(BrazeWebCard card) {
    BrazeCard? brazeCard;
    if (card is BrazeWebImageOnly) {
      brazeCard = card.createBrazeCard();
    }
    if (brazeCard == null) return false;
    return BrazePluginJS.logContentCardClick(brazeCard);
  }

  /// Logs that the user dismissed the given card.
  /// This is done automatically when you use Braze's display module and
  /// should only be called if you're bypassing that and manually building the DOM for displaying the cards in your own code.
  @override
  bool logCardDismissal(BrazeWebCard card) {
    BrazeCard? brazeCard;
    if (card is BrazeWebImageOnly) {
      brazeCard = card.createBrazeCard();
    }
    if (brazeCard == null) return false;
    return BrazePluginJS.logCardDismissal(brazeCard);
  }

  /// A convenient method to log that the user saw the given Content Cards.
  /// This method is equivalent to calling [logCardImpressions method with forContentCards param set to true.
  /// This is done automatically when you use Braze's display module and should only be called if you're bypassing
  /// that and manually building the DOM for displaying content cards in your own code.
  @override
  bool logContentCardImpressions(List<BrazeWebCard> cards) {
    List<BrazeCard> brazeCards = [];
    for (var card in cards) {
      if (card is BrazeWebImageOnly) {
        brazeCards.add(card.createBrazeCard());
      }
    }
    return BrazePluginJS.logContentCardImpressions(brazeCards);
  }

  /// Register this browser environment to receive web push for this user.
  /// Supports browsers which implement the W3C Push API (browsers in which isPushSupported returns true).
  /// If push is supported and the user is not already subscribed, this method will cause
  /// the browser to immediately request push permission from the user.
  ///
  ///
  /// Parameters:
  /// - Optional successCallback: ((endpoint: string, publicKey: string, userAuth: string) => void)
  /// When the user subscribes to push successfully this callback will be invoked with the user's endpoint,
  /// public key, and user auth key (endpoint, publicKey, userAuth).
  ///
  /// - Optional deniedCallback: ((temporaryDenial: boolean) => void)
  /// If push permission is denied or an error is encountered while registering, this
  /// callback will be invoked. If the denial is temporary, it will be
  /// invoked with a parameter of true - otherwise it will be invoked with a parameter of false.
  @override
  void requestPushPermission({
    Function(String endpoint, String, String userAuth)? successCallback,
    Function(bool temporaryDenial)? deniedCallback,
  }) {
    final sCallBack = successCallback ??
            (endpoint, publicKey, userAuth) {
          if (kDebugMode) {
            log('subscribed to push successfully', name: '$BrazeClient');
            log(endpoint, name: '$BrazeClient');
            log(publicKey, name: '$BrazeClient');
            log(userAuth, name: '$BrazeClient');
          }
        };

    final dCallBack = deniedCallback ??
            (temporaryDenial) {
          log('Failed to subscribe: $temporaryDenial', name: '$BrazeClient');
        };

    BrazePluginJS.requestPushPermission(
      allowInterop(sCallBack),
      allowInterop(dCallBack),
    );
  }

  /// Remove an event subscription that you previously subscribed to.
  @override
  bool removeSubscription(String subscriptionGuid) {
    try {
      BrazePluginJS.removeSubscription(subscriptionGuid);
      return true;
    } catch (_) {
      return false;
    }
  }

  /// Unregisters push notifications on this browser.
  /// Note that for Safari, Apple does not offer any unsubscribe mechanism,
  /// so on Safari this method leaves the user with push permission granted and simply
  /// sets their subscription status to unsubscribed.
  @override
  void unregisterPush({Function()? successCallback, Function()? errorCallback}) {
    final sCallBack = successCallback ??
            () {
          if (kDebugMode) {
            log('unregistered push subscription successfully', name: '$BrazeClient');
          }
        };

    final eCallBack = errorCallback ??
            () {
          if (kDebugMode) {
            log('Failed to unregistered', name: '$BrazeClient');
          }
        };
    BrazePluginJS.unregisterPush(
      allowInterop(sCallBack),
      allowInterop(eCallBack),
    );
  }

  @override
  BrazeWebContentCards getCachedContentCards() {
    ContentCards contentCard = BrazePluginJS.getCachedContentCards();
    List<BrazeWebCard> contentCards = [];
    for (var card in contentCard.cards) {
      final imageOnly = card as ImageOnly;
      contentCards.add(imageOnly.createImageOnlyCard());
    }
    return BrazeWebContentCards(cards: contentCards, lastUpdated: contentCard.lastUpdated);
  }
}
