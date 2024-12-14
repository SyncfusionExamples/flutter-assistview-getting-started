import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_chat/assist_view.dart';
import 'package:syncfusion_flutter_core/theme.dart';

import 'helper.dart';

class HeaderSample extends StatefulWidget {
  const HeaderSample({super.key});

  @override
  State createState() => _HeaderSampleState();
}

class _HeaderSampleState extends State with AIAssistViewSampleMixin {
  late List<AssistMessage> _messages;

  Widget _buildHeader(BuildContext context, int index, AssistMessage message) {
    if (message.isRequested) {
      return const SizedBox.shrink();
    } else {
      return ActionChip.elevated(
        labelPadding: EdgeInsets.zero,
        label: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('References'),
            SizedBox(width: 5),
            Icon(Icons.arrow_drop_down),
          ],
        ),
        onPressed: () {
          // Handle the action here.
        },
      );
    }
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
            placeholderBehavior: AssistPlaceholderBehavior.hideOnMessage,
            placeholderBuilder: buildPlaceholder,
            bubbleHeaderBuilder: _buildHeader,
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
