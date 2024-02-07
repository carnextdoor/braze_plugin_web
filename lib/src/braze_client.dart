import 'package:braze_plugin_web/src/braze_models.dart';
import 'package:flutter/foundation.dart';

abstract class BrazeClient {
  void initializeWithOptions({
    required String apiKey,
    required BrazeInitializationOptions options,
    bool automaticallyShowInAppMessages = false,
  });

  void initialize({
    required String apiKey,
    required String baseUrl,
    bool automaticallyShowInAppMessages = false,
    bool manageServiceWorkerExternally = false,
    bool enableLogging = false,
  });

  void identify(String userId);

  void openSession();

  void setCustomAttribute(
    String key,
    dynamic value, {
    bool flush = false,
  });

  void setCustomAttributes(
    Map<String, dynamic> attributes, {
    bool flush = false,
  });

  void logCustomEvent(
    String key,
    String? properties, {
    bool flush = false,
  });

  void requestContentCardRefresh({
    VoidCallback? successCallBack,
    VoidCallback? errorCallBack,
  });

  String subscribeToContentCardsUpdates(
    Function(BrazeWebContentCards cards) callBack,
  );

  bool logContentCardClick(BrazeWebCard card);

  bool logCardDismissal(BrazeWebCard card);

  bool logContentCardImpressions(List<BrazeWebCard> cards);

  void requestPushPermission({
    Function(String endpoint, String, String userAuth)? successCallback,
    Function(bool temporaryDenial)? deniedCallback,
  });

  bool removeSubscription(String subscriptionGuid);

  void unregisterPush({Function()? successCallback, Function()? errorCallback});

  BrazeWebContentCards getCachedContentCards();
}
