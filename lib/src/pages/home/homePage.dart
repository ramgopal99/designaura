import 'package:designaura/core/constants/assets.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'chat_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> _conversations = [];
  final String _conversationsKey = 'conversations';

  @override
  void initState() {
    super.initState();
    _loadConversations();
  }

  Future<void> _loadConversations() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _conversations = prefs.getStringList(_conversationsKey) ?? [];
    });
  }

  Future<void> _saveConversations() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(_conversationsKey, _conversations);
  }

  void _addNewConversation() {
    setState(() {
      _conversations.add("New Conversation ${_conversations.length + 1}");
    });
    _saveConversations();
  }

  void _deleteConversation(int index) {
    setState(() {
      _conversations.removeAt(index);
    });
    _saveConversations();
  }

  void _navigateToChatPage(String conversation) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ChatPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Conversations',
          style: TextStyle(
            fontSize: 21,
            fontWeight: FontWeight.bold,
          ),
        ),
        automaticallyImplyLeading: false,
      ),
      body: _conversations.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    AppAssets.assetsIconsEmpty, // Ensure this path is correct and the image is included in your assets
                    width: 200,
                    height: 200,
                  ),
                  SizedBox(height: 20),
                  Text(
                    'No conversations yet',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            )
          : ListView.builder(
              itemCount: _conversations.length,
              itemBuilder: (context, index) {
                return Dismissible(
                  key: Key(_conversations[index]),
                  background: Container(
                    color: Colors.red,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                        child: Icon(Icons.delete, color: Colors.white),
                      ),
                    ),
                  ),
                  secondaryBackground: Container(
                    color: Colors.red,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                        child: Icon(Icons.delete, color: Colors.white),
                      ),
                    ),
                  ),
                  direction: DismissDirection.endToStart,
                  onDismissed: (direction) {
                    _deleteConversation(index);
                  },
                  child: Card(
                    margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                    elevation: 4.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0), // Rounded corners
                    ),
                    child: ListTile(
                      contentPadding: EdgeInsets.all(16.0),
                      title: Text(_conversations[index]),
                      onTap: () => _navigateToChatPage(_conversations[index]),
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addNewConversation,
        child: Icon(Icons.add),
        tooltip: 'Add New Conversation',
      ),
    );
  }
}
