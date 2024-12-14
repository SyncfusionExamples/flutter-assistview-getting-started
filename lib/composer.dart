import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_chat/assist_view.dart';
import 'package:syncfusion_flutter_core/theme.dart';

import 'helper.dart';

class ComposerSample extends StatefulWidget {
  const ComposerSample({super.key});

  @override
  State createState() => _ComposerSampleState();
}

class _ComposerSampleState extends State with AIAssistViewSampleMixin {
  late List<AssistMessage> _messages;
  late TextEditingController _textController;

  Widget _buildComposer(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return DecoratedBox(
      decoration: BoxDecoration(
        border: Border.all(
          color: themeData.colorScheme.primary,
          width: 1.0,
        ),
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          TextField(
            maxLines: 5,
            minLines: 1,
            controller: _textController,
            style: Theme.of(context).textTheme.bodyMedium,
            decoration: InputDecoration(
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(32.0),
                borderSide: BorderSide.none,
              ),
              hoverColor: themeData.colorScheme.surface,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(32.0),
                borderSide: BorderSide.none,
              ),
              hintText: 'Ask here..',
              hintStyle: Theme.of(context).textTheme.bodyMedium,
              contentPadding:
                  const EdgeInsets.only(left: 20.0, top: 16, right: 20),
            ),
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.attach_file),
                      tooltip: 'Attach files is not supported now',
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: IconButton.filled(
                      onPressed: _textController.text.isEmpty ? null : _submit,
                      icon: const Icon(Icons.arrow_upward_rounded),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _submit() async {
    String request = _textController.text;
    addMessageAndRebuild(_messages, AssistMessage.request(data: request));
    final AssistMessage? response = await generateResponse(request);
    _textController.clear();
    if (mounted && response != null) {
      addMessageAndRebuild(_messages, response);
    }
  }

  void _textChanged() {
    if (_textController.text.isNotEmpty) {
      setState(() {});
    }
  }

  @override
  void initState() {
    _textController = TextEditingController();
    _textController.addListener(_textChanged);
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
            composer: AssistComposer.builder(
              builder: _buildComposer,
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
    _textController.removeListener(_textChanged);
    _textController.dispose();
    _messages.clear();
    super.dispose();
  }
}
