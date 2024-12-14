import 'package:flutter/material.dart';

import 'action_button.dart';
import 'alignment.dart';
import 'composer.dart';
import 'footer.dart';
import 'header.dart';
import 'placeholder.dart';
import 'suggestions.dart';
import 'toolbar.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainApp(),
    ),
  );
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  late Map<String, Widget> _routes;

  @override
  void initState() {
    _routes = {
      'Placeholder': const PlaceholderSample(),
      'Header': const HeaderSample(),
      'Footer': const FooterSample(),
      'Composer': const ComposerSample(),
      'Acton Button': const ActionButtonSample(),
      'Alignment': const AlignmentSample(),
      'Suggestions': const SuggestionsSample(),
      'Toolbar': const ToolbarSample(),
    };
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: List.generate(_routes.length, (int index) {
          return ListTile(
            title: Text(_routes.keys.elementAt(index)),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) {
                  return _routes.values.elementAt(index);
                },
              ),
            ),
          );
        }),
      ),
    );
  }
}
