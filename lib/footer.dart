import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_chat/assist_view.dart';
import 'package:syncfusion_flutter_core/theme.dart';

import 'helper.dart';

class FooterSample extends StatefulWidget {
  const FooterSample({super.key});

  @override
  State createState() => _FooterSampleState();
}

class _FooterSampleState extends State with AIAssistViewSampleMixin {
  late List<AssistMessage> _messages;

  Widget _buildFooter(BuildContext context, int index, AssistMessage message) {
    if (message.isRequested) {
      return const SizedBox.shrink();
    } else {
      final ThemeData themeData = Theme.of(context);
      return DropdownButtonHideUnderline(
        child: DropdownButton(
          isDense: true,
          items: const <DropdownMenuItem>[
            DropdownMenuItem(child: Text('GPT 4')),
          ],
          style: themeData.textTheme.titleSmall?.copyWith(
            color: themeData.colorScheme.primary,
          ),
          onChanged: (value) {
            //
          },
        ),
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
            bubbleContentBuilder: buildContent,
            bubbleFooterBuilder: _buildFooter,
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
