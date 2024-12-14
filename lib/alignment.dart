import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_chat/assist_view.dart';
import 'package:syncfusion_flutter_core/theme.dart';

import 'helper.dart';

class AlignmentSample extends StatefulWidget {
  const AlignmentSample({super.key});

  @override
  State createState() => _AlignmentSampleState();
}

class _AlignmentSampleState extends State with AIAssistViewSampleMixin {
  late List<AssistMessage> _messages;
  late List<String> _alignmentOptions;

  int _selectedAlignmentIndex = 0;
  AssistBubbleAlignment _alignment = AssistBubbleAlignment.auto;

  Widget _buildAlignmentSettings() {
    return Wrap(
      children: List.generate(_alignmentOptions.length, (int index) {
        return Padding(
          padding: const EdgeInsets.only(right: 10),
          child: ChoiceChip(
            label: Text(_alignmentOptions[index]),
            selected: _selectedAlignmentIndex == index,
            onSelected: (bool selected) {
              setState(() {
                _alignment = index == 0
                    ? AssistBubbleAlignment.auto
                    : index == 1
                        ? AssistBubbleAlignment.start
                        : AssistBubbleAlignment.end;
                _selectedAlignmentIndex = index;
              });
            },
          ),
        );
      }),
    );
  }

  void _submit(String request) async {
    addMessageAndRebuild(
      _messages,
      AssistMessage.request(
        data: request,
        author: const AssistMessageAuthor(
          id: 'Emile Kraven',
          name: 'Emile Kraven',
        ),
      ),
    );
    final AssistMessage? response = await generateResponse(request);
    if (mounted && response != null) {
      addMessageAndRebuild(_messages, response);
    }
  }

  @override
  void initState() {
    _messages = <AssistMessage>[];
    _alignmentOptions = <String>['Auto', 'Start', 'End'];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          children: [
            _buildAlignmentSettings(),
            Expanded(
              child: SfAIAssistViewTheme(
                data: const SfAIAssistViewThemeData(
                  responseAvatarBackgroundColor: Colors.transparent,
                ),
                child: SfAIAssistView(
                  messages: _messages,
                  bubbleAlignment: _alignment,
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
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _messages.clear();
    _alignmentOptions.clear();
    super.dispose();
  }
}
