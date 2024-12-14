import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_chat/assist_view.dart';

class AssistViewSample extends StatefulWidget {
  const AssistViewSample({super.key});

  @override
  State<StatefulWidget> createState() => AssistViewSampleState();
}

class AssistViewSampleState extends State<AssistViewSample> {
  late List<AssistMessage> _messages;

  void _generateResponse(String data) async {
    final String response = await _getAIResponse(data);
    setState(() {
      _messages.add(AssistMessage.response(data: response));
    });
  }

  Future<String> _getAIResponse(String data) async {
    String response = '';
    // Connect with your preferred AI to generate a response to the prompt.
    return response;
  }

  @override
  void initState() {
    _messages = <AssistMessage>[];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SfAIAssistView(
      messages: _messages,
      composer: const AssistComposer(
        decoration: InputDecoration(
          hintText: 'Type a message',
        ),
      ),
      actionButton: AssistActionButton(
        onPressed: (String data) {
          setState(() {
            _messages.add(AssistMessage.request(data: data));
          });
          _generateResponse(data);
        },
      ),
    );
  }

  @override
  void dispose() {
    _messages.clear();
    super.dispose();
  }
}
