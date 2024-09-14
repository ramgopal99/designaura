import 'package:designaura/core/constants/assets.dart';
import 'package:designaura/core/constants/colors.dart';
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
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: AppColors.primaryColor,
        elevation: 0,
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue.shade100, Colors.white],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: _conversations.isEmpty
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      AppAssets.assetsIconsEmpty,
                      width: 150,
                      height: 150,
                    ),
                    SizedBox(height: 20),
                    Text(
                      'No conversations yet',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.grey[700],
                        fontWeight: FontWeight.w500,
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
                          padding: EdgeInsets.symmetric(horizontal: 20.0),
                          child: Icon(Icons.delete, color: Colors.white, size: 30),
                        ),
                      ),
                    ),
                    secondaryBackground: Container(
                      color: Colors.red,
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.0),
                          child: Icon(Icons.delete, color: Colors.white, size: 30),
                        ),
                      ),
                    ),
                    direction: DismissDirection.endToStart,
                    onDismissed: (direction) {
                      _deleteConversation(index);
                    },
                    child: Card(
                      margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                      elevation: 5.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: ListTile(
                        contentPadding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0),
                        leading: Icon(Icons.chat, color: AppColors.primaryColor, size: 30),
                        title: Text(
                          _conversations[index],
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                        ),
                        onTap: () => _navigateToChatPage(_conversations[index]),
                      ),
                    ),
                  );
                },
              ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addNewConversation,
        child: Icon(Icons.add, size: 30),
        backgroundColor: AppColors.primaryColor,
        elevation: 6.0,
        tooltip: 'Add New Conversation',
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
