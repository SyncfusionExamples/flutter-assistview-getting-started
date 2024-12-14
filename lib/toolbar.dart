import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_chat/assist_view.dart';
import 'package:syncfusion_flutter_core/theme.dart';

import 'helper.dart';

class ToolbarSample extends StatefulWidget {
  const ToolbarSample({super.key});

  @override
  State createState() => _ToolbarSampleState();
}

class _ToolbarSampleState extends State with AIAssistViewSampleMixin {
  late List<AssistMessage> _messages;

  void _submit(String request) async {
    addMessageAndRebuild(_messages, AssistMessage.request(data: request));
    final AssistMessage? response = await generateResponse(request, true);
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
            placeholderBehavior: AssistPlaceholderBehavior.hideOnMessage,
            placeholderBuilder: buildPlaceholder,
            bubbleContentBuilder: buildContent,
            actionButton: AssistActionButton(
              onPressed: (String request) => _submit(request),
            ),
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
