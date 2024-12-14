import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_chat/assist_view.dart';
import 'package:syncfusion_flutter_core/theme.dart';

import 'helper.dart';

class PlaceholderSample extends StatefulWidget {
  const PlaceholderSample({super.key});

  @override
  State createState() => _PlaceholderSampleState();
}

class _PlaceholderSampleState extends State with AIAssistViewSampleMixin {
  late List<AssistMessage> _messages;

  @override
  Widget buildPlaceholder(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    final List<String> chips = <String>[
      'Tell me a joke',
      'Make a budget trip plan',
      'How to make a sandwich',
      '5 minutes workout',
    ];
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'What can I help you with today?',
          style: themeData.textTheme.titleLarge,
        ),
        const SizedBox(height: 25),
        Wrap(
          alignment: WrapAlignment.center,
          children: List.generate(chips.length, (int index) {
            final String request = chips[index];
            return Padding(
              padding: const EdgeInsets.all(5.0),
              child: ActionChip(
                label: Text(request),
                onPressed: () => _submit(request),
              ),
            );
          }),
        ),
      ],
    );
  }

  void _submit(String request) async {
    addMessageAndRebuild(_messages, AssistMessage.request(data: request));
    final AssistMessage? response = await generateResponse(request);
    if (mounted && response != null) {
      addMessageAndRebuild(_messages, response);
    }
  }

  @override
  void initState() {
    _messages = <AssistMessage>[];
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
            placeholderBehavior: AssistPlaceholderBehavior.scrollWithMessage,
            placeholderBuilder: buildPlaceholder,
            bubbleContentBuilder: buildContent,
            actionButton: AssistActionButton(
              onPressed: (String request) => _submit(request),
            ),
            requestBubbleSettings: const AssistBubbleSettings(
              showUserAvatar: false,
            ),
            responseBubbleSettings: const AssistBubbleSettings(
              widthFactor: 0.9,
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
