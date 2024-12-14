import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:syncfusion_flutter_chat/assist_view.dart';

mixin AIAssistViewSampleMixin on State {
  Widget buildPlaceholder(BuildContext context) {
    return Center(
      child: Text(
        'Hello! How can I help you today?',
        style: Theme.of(context).textTheme.titleLarge!.copyWith(
              color: Theme.of(context).colorScheme.primary,
            ),
      ),
    );
  }

  Widget buildContent(BuildContext context, int index, AssistMessage message) {
    return MarkdownBody(data: message.data);
  }

  Future<AssistMessage?> generateResponse(String request,
      [bool addToolbarItems = false]) async {
    List<AssistMessageToolbarItem>? toolbarItems;
    if (addToolbarItems) {
      toolbarItems = [
        const AssistMessageToolbarItem(content: Icon(Icons.thumb_up_off_alt)),
        const AssistMessageToolbarItem(content: Icon(Icons.thumb_down_off_alt)),
        const AssistMessageToolbarItem(content: Icon(Icons.copy)),
        const AssistMessageToolbarItem(content: Icon(Icons.refresh)),
      ];
    }

    try {
      final String? response = await _connectToAI(request);
      return AssistMessage.response(
        data: response ?? 'No response from AI',
        author: const AssistMessageAuthor(
          id: 'AI',
          name: 'AI',
          avatar: AssetImage('assets/ai_assist_view.png'),
        ),
        toolbarItems: toolbarItems,
      );
    } catch (e) {
      return AssistMessage.response(
        data: e.toString(),
        toolbarItems: toolbarItems,
      );
    }
  }

  Future<String?> _connectToAI(String request) async {
    String response =
        'Please connect to your preferred AI server for the real-time queries.';
    // Connect to your preferred AI service here and get the response.
    return response;
  }

  void addMessageAndRebuild(
      List<AssistMessage> messages, AssistMessage message) {
    if (mounted) {
      setState(() {
        messages.add(message);
      });
    }
  }
}
