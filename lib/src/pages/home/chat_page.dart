import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final List<Map<String, String>> _messages = [];
  final TextEditingController _controller = TextEditingController();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadMessages();
  }

  Future<void> _loadMessages() async {
    final prefs = await SharedPreferences.getInstance();
    final messagesJson = prefs.getStringList('messages') ?? [];
    setState(() {
      _messages.addAll(
        messagesJson
            .map((message) => jsonDecode(message) as Map<String, String>),
      );
    });
  }

  Future<void> _saveMessages() async {
    final prefs = await SharedPreferences.getInstance();
    final messagesJson =
        _messages.map((message) => jsonEncode(message)).toList();
    await prefs.setStringList('messages', messagesJson);
  }

  Future<void> sendMessage(String message) async {
    if (!_isInteriorDesignQuery(message)) {
      _showNotInteriorDesignDialog();
      return;
    }

    setState(() {
      _messages.add({
        'text': message,
        'type': 'user',
        'timestamp': DateTime.now().toIso8601String()
      });
      _isLoading = true;
    });

    final response = await createChatSessionAndSubmitQuery(message);

    setState(() {
      _messages.add({
        'text': response,
        'type': 'bot',
        'timestamp': DateTime.now().toIso8601String()
      });
      _isLoading = false;
    });

    _saveMessages();
  }

  bool _isInteriorDesignQuery(String query) {
    final keywords = [
      'interior',
      'design',
      'decor',
      'furniture',
      'space',
      'color',
      'lighting',
      'texture',
      'pattern',
      'style',
      'layout',
      'accessory',
      'wallpaper',
      'flooring',
      'curtains',
      'cushion',
      'rug',
      'artwork',
      'modern',
      'classic',
      'contemporary',
      'minimalist',
      'vintage',
      'bohemian',
      'rustic',
      'industrial',
      'elegant',
      'chic',
      'sustainable',
      'eco-friendly',
      'comfort',
      'functionality',
      'organization',
      'storage',
      'shelving',
      'partition',
      'room',
      'kitchen',
      'bathroom',
      'living room',
      'bedroom',
      'dining room',
      'home office',
      'studio',
      'focal point',
      'accent',
      'theme',
      'finish',
      'material',
      'color palette',
      'wall art',
      'ceiling',
      'window treatment',
      'cabinetry',
      'countertop',
      'sink',
      'hi',
      'hello',
      'by',
      'room'
    ];

    return keywords.any((keyword) => query.toLowerCase().contains(keyword));
  }

  Future<String> createChatSessionAndSubmitQuery(String query) async {
    const apiKey = 'vjICsA9OIJSBdf9to4r2pK49baTL9j6m';
    const externalUserId = 'qwer';

    final createSessionUrl =
        Uri.parse('https://api.on-demand.io/chat/v1/sessions');
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

    final submitQueryUrl =
        Uri.parse('https://api.on-demand.io/chat/v1/sessions/$sessionId/query');
    final submitQueryResponse = await http.post(
      submitQueryUrl,
      headers: {
        'Content-Type': 'application/json',
        'apikey': apiKey,
      },
      body: jsonEncode({
        'endpointId': 'predefined-openai-gpt4o',
        'query': query,
        'pluginIds': ['plugin-1712327325', 'plugin-1713962163'],
        'responseMode': 'sync',
      }),
    );

    final responseData = jsonDecode(submitQueryResponse.body);
    return responseData['data']['answer'] ?? 'No answer received';
  }

  void _showNotInteriorDesignDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Not Related to Interior Design'),
          content: Text('Please ask a question related to interior design.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Interior Design Chat'),
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
                final isUserMessage = message['type'] == 'user';
                final timestamp = DateTime.parse(message['timestamp']!)
                    .toLocal()
                    .toString()
                    .split(' ')[1]
                    .substring(0, 5);

                return Padding(
                  padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
                  child: Align(
                    alignment: isUserMessage
                        ? Alignment.centerRight
                        : Alignment.centerLeft,
                    child: Column(
                      crossAxisAlignment: isUserMessage
                          ? CrossAxisAlignment.end
                          : CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.all(12),
                          constraints: BoxConstraints(
                              maxWidth: MediaQuery.of(context).size.width * 0.7),
                          decoration: BoxDecoration(
                            color: isUserMessage
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
                          child: Text(
                            message['text']!,
                            style: TextStyle(
                              color: isUserMessage ? Colors.white : Colors.black87,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          timestamp,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                      ],
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
                        hintText: 'Ask about interior design...',
                        border: InputBorder.none,
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 12),
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
}
