import 'package:braze_plugin_web/src/braze_client.dart';
import 'package:braze_plugin_web/src/braze_models.dart';
import 'package:flutter/foundation.dart';

class BrazeClientImpl implements BrazeClient {
  BrazeClientImpl._();

  static BrazeClient get instance => BrazeClientImpl._();

  @override
  void initializeWithOptions({
    required String apiKey,
    required BrazeInitializationOptions options,
    bool automaticallyShowInAppMessages = false,
  }) {
    throw UnimplementedError();
  }

  @override
  void initialize({
    required String apiKey,
    required String baseUrl,
    bool automaticallyShowInAppMessages = false,
    bool manageServiceWorkerExternally = false,
    bool enableLogging = false,
  }) {
    throw UnimplementedError();
  }

  @override
  void identify(String userId) {
    throw UnimplementedError();
  }

  @override
  void openSession() {
    throw UnimplementedError();
  }

  @override
  void setCustomAttribute(
    String key,
    dynamic value, {
    bool flush = false,
  }) {
    throw UnimplementedError();
  }

  @override
  void setCustomAttributes(
    Map<String, dynamic> attributes, {
    bool flush = false,
  }) {
    throw UnimplementedError();
  }

  @override
  void logCustomEvent(
    String key,
    String? properties, {
    bool flush = false,
  }) {
    throw UnimplementedError();
  }

  @override
  void requestContentCardRefresh({
    VoidCallback? successCallBack,
    VoidCallback? errorCallBack,
  }) {
    throw UnimplementedError();
  }

  @override
  String subscribeToContentCardsUpdates(
    Function(BrazeWebContentCards cards) callBack,
  ) {
    throw UnimplementedError();
  }

  @override
  bool logContentCardClick(BrazeWebCard card) {
    throw UnimplementedError();
  }

  @override
  bool logCardDismissal(BrazeWebCard card) {
    throw UnimplementedError();
  }

  @override
  bool logContentCardImpressions(List<BrazeWebCard> cards) {
    throw UnimplementedError();
  }

  @override
  void requestPushPermission({
    Function(String endpoint, String, String userAuth)? successCallback,
    Function(bool temporaryDenial)? deniedCallback,
  }) {
    throw UnimplementedError();
  }

  @override
  bool removeSubscription(String subscriptionGuid) {
    throw UnimplementedError();
  }

  @override
  void unregisterPush({Function()? successCallback, Function()? errorCallback}) {
    throw UnimplementedError();
  }

  @override
  BrazeWebContentCards getCachedContentCards() {
    throw UnimplementedError();
  }
}
