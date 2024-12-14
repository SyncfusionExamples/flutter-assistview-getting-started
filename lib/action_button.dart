import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_chat/assist_view.dart';
import 'package:syncfusion_flutter_core/theme.dart';

import 'helper.dart';

class ActionButtonSample extends StatefulWidget {
  const ActionButtonSample({super.key});

  @override
  State createState() => _ActionButtonSampleState();
}

class _ActionButtonSampleState extends State with AIAssistViewSampleMixin {
  late List<AssistMessage> _messages;
  late TextEditingController _textController;

  AssistComposer _buildCustomComposer() {
    return AssistComposer.builder(
      builder: (BuildContext context) {
        return TextField(
          controller: _textController,
          style: Theme.of(context).textTheme.bodyMedium,
          decoration: InputDecoration(
            hintText: 'Ask here!',
            hintStyle: Theme.of(context).textTheme.bodyMedium,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 10,
            ),
          ),
          onSubmitted: (String text) {
            _submit();
          },
        );
      },
    );
  }

  void _textChanged() {
    if (mounted && _textController.text.isNotEmpty) {
      setState(() {});
    }
  }

  void _submit() async {
    final AssistMessage? response =
        await generateResponse(_textController.text);
    _textController.clear();
    if (mounted && response != null) {
      addMessageAndRebuild(_messages, response);
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
            composer: _buildCustomComposer(),
            actionButton: AssistActionButton(
              hoverColor: Colors.transparent,
              backgroundColor: Colors.transparent,
              size: const Size(150, 40),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  IconButton.filled(
                    icon: const Icon(Icons.camera_alt),
                    onPressed: () {},
                  ),
                  const SizedBox(width: 10),
                  IconButton.filled(
                    icon: const Icon(Icons.attach_file),
                    onPressed: () {},
                  ),
                  const SizedBox(width: 10),
                  IconButton.filled(
                    icon: const Icon(Icons.arrow_upward_rounded),
                    onPressed: _textController.text.isEmpty ? null : _submit,
                  ),
                ],
              ),
              onPressed: _textController.text.isEmpty
                  ? null
                  : (String request) => _submit(),
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
