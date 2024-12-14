import 'dart:async';

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_chat/assist_view.dart';
import 'package:syncfusion_flutter_core/theme.dart';

import 'helper.dart';

class SuggestionsSample extends StatefulWidget {
  const SuggestionsSample({super.key});

  @override
  State createState() => _SuggestionsSampleState();
}

class _SuggestionsSampleState extends State with AIAssistViewSampleMixin {
  late List<AssistMessage> _messages;
  late List<AssistMessage> _responses;

  @override
  void initState() {
    _messages = <AssistMessage>[];
    _responses = <AssistMessage>[
      const AssistMessage.response(
        data:
            'Hi there! I\'m here to help you make a hotel reservation. When would you like to check in?',
        suggestions: [
          AssistMessageSuggestion(data: 'Today'),
          AssistMessageSuggestion(data: 'Tomorrow'),
          AssistMessageSuggestion(data: 'Next week'),
          AssistMessageSuggestion(data: 'Other (please specify)'),
        ],
      ),
      const AssistMessage.response(
        data: 'Perfect! How many nights will you be staying?',
        suggestions: [
          AssistMessageSuggestion(data: '1 night'),
          AssistMessageSuggestion(data: '2 nights'),
          AssistMessageSuggestion(data: '3 nights'),
          AssistMessageSuggestion(data: 'Other (please specify)'),
        ],
      ),
      const AssistMessage.response(
        data: 'Lastly, how many guests will be in your party?',
        suggestions: [
          AssistMessageSuggestion(data: '1 guest'),
          AssistMessageSuggestion(data: '2 guests'),
          AssistMessageSuggestion(data: '3 guests'),
          AssistMessageSuggestion(data: 'Other (please specify)'),
        ],
      ),
    ];
    _messages.add(_responses.removeAt(0));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: SfAIAssistViewTheme(
          data: const SfAIAssistViewThemeData(
            responseAvatarBackgroundColor: Colors.transparent,
          ),
          child: SfAIAssistView(
            messages: _messages,
            placeholderBehavior: AssistPlaceholderBehavior.hideOnMessage,
            placeholderBuilder: buildPlaceholder,
            bubbleContentBuilder: buildContent,
            actionButton: AssistActionButton(onPressed: (String request) {
              addMessageAndRebuild(
                _messages,
                AssistMessage.request(data: request),
              );
            }),
            onSuggestionItemSelected: (bool selected, int messageIndex,
                AssistMessageSuggestion suggestion, int suggestionIndex) {
              addMessageAndRebuild(
                _messages,
                AssistMessage.request(data: suggestion.data!),
              );
              Timer.periodic(const Duration(milliseconds: 500), (Timer timer) {
                if (_responses.isEmpty) {
                  timer.cancel();
                  return;
                }
                addMessageAndRebuild(_messages, _responses.removeAt(0));
                timer.cancel();
              });
            },
            requestBubbleSettings: const AssistBubbleSettings(
              showUserAvatar: true,
            ),
            responseBubbleSettings: const AssistBubbleSettings(
              widthFactor: 0.95,
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _messages.clear();
    super.dispose();
  }
}
