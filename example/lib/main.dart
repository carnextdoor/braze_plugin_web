import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:braze_plugin_web/braze_plugin_web.dart';

void main() => runApp(MyApp());

const String _brazeApiKey = '';
const String _brazeBaseUrl = '';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Braze Plugin for Web',
      home: BrazeWebExamplePage(),
    );
  }
}

class BrazeWebExamplePage extends StatefulWidget {
  const BrazeWebExamplePage({super.key});

  @override
  BrazeWebExamplePageState createState() => new BrazeWebExamplePageState();
}

class BrazeWebExamplePageState extends State<BrazeWebExamplePage> {
  List<BrazeWebClassicCard> _contentCards = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Braze Web Example'),
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                child: const Text('Initialize'),
                onPressed: _initialiseBraze,
              ),
              SizedBox(height: 10),
              ElevatedButton(
                child: const Text('Identify'),
                onPressed: () => _identify('test-user'),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                child: const Text('Set Custom Attribute'),
                onPressed: _setCustomAttribute,
              ),
              SizedBox(height: 10),
              ElevatedButton(
                child: const Text('Set Custom Attributes'),
                onPressed: _setCustomAttributes,
              ),
              SizedBox(height: 10),
              ElevatedButton(
                child: const Text('Log Custom Event'),
                onPressed: _logCustomEvent,
              ),
              SizedBox(height: 10),
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black,
                  ),
                ),
                child: Column(
                  children: [
                    ElevatedButton(
                      child: const Text('Subscribe To Content Cards'),
                      onPressed: _subScribeToContentCards,
                    ),
                    SizedBox(height: 10),
                    if (_contentCards.isNotEmpty)
                      ..._contentCards.map((e) {
                        return Image.network(
                          e.imageUrl ?? '',
                        );
                      }),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context) //
        .showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(milliseconds: 800),
      ),
    );
  }

  void _subScribeToContentCards() {
    try {
      BrazeClientImpl.instance.requestContentCardRefresh();
      BrazeClientImpl.instance.subscribeToContentCardsUpdates(
        (BrazeWebContentCards cards) {
          print(cards.cards.length);
          for (var card in cards.cards) {
            if (card is BrazeWebClassicCard) {
              _contentCards.add(card);
              print(card.extras['location']);
              print(card.imageUrl);
            }
          }
          setState(() {});
        },
      );
    } catch (e) {
      _showMessage(e.toString());
    }
  }

  void _setCustomAttributes() {
    BrazeClientImpl.instance.setCustomAttributes({
      'test_web_plugin_1': 'Hi!',
      'test_web_plugin_2': 27,
    });
  }

  void _logCustomEvent() {
    BrazeClientImpl.instance.logCustomEvent(
      'test_web_plugin_event',
      jsonEncode({'prop1': false}),
    );
  }

  void _setCustomAttribute() => //
      BrazeClientImpl.instance.setCustomAttribute('test_web_plugin', true);

  void _identify(String user) {
    BrazeClientImpl.instance.identify('7436');
  }

  void _initialiseBraze() {
    try {
      BrazeClientImpl.instance.initialize(
        apiKey: _brazeApiKey,
        baseUrl: _brazeBaseUrl,
        automaticallyShowInAppMessages: true,
        enableLogging: true,
      );
      _showMessage('Initialized');
    } catch (e) {
      _showMessage(e.toString());
    }
  }
}
