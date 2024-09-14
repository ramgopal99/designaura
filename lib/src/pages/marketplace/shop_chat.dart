import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/gestures.dart';

class ShopChatPage extends StatefulWidget {
  final String initialMessage;

  ShopChatPage({required this.initialMessage});

  @override
  _ShopChatPageState createState() => _ShopChatPageState();
}

class _ShopChatPageState extends State<ShopChatPage> {
  final List<Map<String, String>> _messages = [];
  final TextEditingController _controller = TextEditingController();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadMessages();
    _sendInitialMessage();
  }

  Future<void> _loadMessages() async {
    final prefs = await SharedPreferences.getInstance();
    final messagesJson = prefs.getStringList('messages') ?? [];
    setState(() {
      _messages.addAll(
        messagesJson.map((message) => jsonDecode(message) as Map<String, String>),
      );
    });
  }

  Future<void> _saveMessages() async {
    final prefs = await SharedPreferences.getInstance();
    final messagesJson = _messages.map((message) => jsonEncode(message)).toList();
    await prefs.setStringList('messages', messagesJson);
  }

  Future<void> _sendInitialMessage() async {
    if (widget.initialMessage.isNotEmpty) {
      await sendMessage(widget.initialMessage);
    }
  }

  Future<void> sendMessage(String message) async {
    setState(() {
      _messages.add({'text': message, 'type': 'user'});
      _isLoading = true;
    });

    final response = await createChatSessionAndSubmitQuery(message);

    setState(() {
      _messages.add({'text': response, 'type': 'bot'});
      _isLoading = false;
    });

    _saveMessages();
  }

  Future<String> createChatSessionAndSubmitQuery(String query) async {
    const apiKey = 'vjICsA9OIJSBdf9to4r2pK49baTL9j6m';
    const externalUserId = 'qwer';

    // Create Chat Session
    final createSessionUrl = Uri.parse('https://api.on-demand.io/chat/v1/sessions');
    final createSessionResponse = await http.post(
      createSessionUrl,
      headers: {
        'Content-Type': 'application/json',
        'apikey': apiKey,
      },
      body: jsonEncode({
        'pluginIds': [],
        'externalUserId': externalUserId,
      }),
    );

    final sessionData = jsonDecode(createSessionResponse.body);
    final sessionId = sessionData['data']['id'];

    // Submit Query
    final submitQueryUrl = Uri.parse('https://api.on-demand.io/chat/v1/sessions/$sessionId/query');
    final submitQueryResponse = await http.post(
      submitQueryUrl,
      headers: {
        'Content-Type': 'application/json',
        'apikey': apiKey,
      },
      body: jsonEncode({
        'endpointId': 'predefined-openai-gpt4o',
        'query': query,
        'pluginIds': ['plugin-1716119225', 'plugin-1716334779'],
        'responseMode': 'sync',
      }),
    );

    final responseData = jsonDecode(submitQueryResponse.body);
    return responseData['data']['answer'] ?? 'No answer received';
  }

  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat With Bot About Your Product'),
        backgroundColor: Colors.teal,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              reverse: true,
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
                  child: Align(
                    alignment: message['type'] == 'user'
                        ? Alignment.centerRight
                        : Alignment.centerLeft,
                    child: Container(
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: message['type'] == 'user'
                            ? Colors.teal
                            : Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 4,
                            offset: Offset(2, 2),
                          ),
                        ],
                      ),
                      child: RichText(
                        text: TextSpan(
                          children: _parseText(message['text']!),
                          style: TextStyle(
                            color: message['type'] == 'user'
                                ? Colors.white
                                : Colors.black87,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          if (_isLoading)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 4,
                          offset: Offset(2, 2),
                        ),
                      ],
                    ),
                    child: TextField(
                      controller: _controller,
                      decoration: InputDecoration(
                        hintText: 'Type your message here...',
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 8),
                FloatingActionButton(
                  onPressed: () {
                    if (_controller.text.isNotEmpty) {
                      sendMessage(_controller.text);
                      _controller.clear();
                    }
                  },
                  child: Icon(Icons.send),
                  backgroundColor: Colors.teal,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<TextSpan> _parseText(String text) {
    final regex = RegExp(r'(https?://[^\s]+)');
    final matches = regex.allMatches(text);
    final List<TextSpan> spans = [];

    int start = 0;
    for (final match in matches) {
      if (match.start > start) {
        spans.add(TextSpan(text: text.substring(start, match.start)));
      }
      final url = match.group(0)!;
      spans.add(TextSpan(
        text: url,
        style: TextStyle(
          color: Colors.blue,
          decoration: TextDecoration.underline,
        ),
        recognizer: TapGestureRecognizer()
          ..onTap = () => _launchURL(url),
      ));
      start = match.end;
    }

    if (start < text.length) {
      spans.add(TextSpan(text: text.substring(start)));
    }

    return spans;
  }
}
