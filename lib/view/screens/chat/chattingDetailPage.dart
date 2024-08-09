import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:uuid/uuid.dart';

class ChattingDetailPage extends StatefulWidget {
  final String user;

  ChattingDetailPage({required this.user});

  @override
  _ChattingDetailPageState createState() => _ChattingDetailPageState();
}

class _ChattingDetailPageState extends State<ChattingDetailPage> {
  List<types.Message> _messages = [];
  final _user = const types.User(id: 'ss');
  final TextEditingController _textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadMessages();
  }

  void _addMessage(types.Message message) {
    setState(() {
      _messages.insert(0, message);
    });
  }

  void _handlePreviewDataFetched(
      types.TextMessage message,
      types.PreviewData previewData,
      ) {
    final index = _messages.indexWhere((element) => element.id == message.id);
    final currentMessage = _messages[index] as types.TextMessage;
    final updatedMessage = currentMessage.copyWith(previewData: previewData);

    WidgetsBinding.instance?.addPostFrameCallback((_) {
      setState(() {
        _messages[index] = updatedMessage;
      });
    });
  }

  void _handleSendPressed(types.PartialText message) {
    final textMessage = types.TextMessage(
      author: _user,
      id: const Uuid().v4(),
      text: message.text,
      createdAt: DateTime.now().millisecondsSinceEpoch,
    );

    _addMessage(textMessage);
    _textController.clear();
  }

  void _loadMessages() async {
    final response = await rootBundle.loadString('assets/messages.json');
    final messages = (jsonDecode(response) as List)
        .map((e) => types.Message.fromJson(e as Map<String, dynamic>))
        .toList();

    setState(() {
      _messages = messages;
    });
  }

  Widget _buildCustomInputWidget() {
    return Container(
      height: 60,
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      color: Color.fromRGBO(211, 211, 211, 40),
      child: Row(
        children: <Widget>[
          SizedBox(width: 20),
          Expanded(
            child: TextField(
              controller: _textController,
              decoration: InputDecoration.collapsed(
                hintText: '메시지 입력...',
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.send),
            onPressed: () {
              if (_textController.text.isNotEmpty) {
                _handleSendPressed(types.PartialText(text: _textController.text));
              }
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    const customTheme = DefaultChatTheme(
      primaryColor: Color.fromRGBO(92, 67, 239, 20),
      secondaryColor: Color.fromRGBO(211, 211, 211, 40),
      receivedMessageBodyTextStyle: TextStyle(color: Colors.black),
      sentMessageBodyTextStyle: TextStyle(color: Colors.white),
      backgroundColor: Colors.white,
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: BackButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Chat(
        messages: _messages,
        onPreviewDataFetched: _handlePreviewDataFetched,
        onSendPressed: _handleSendPressed,
        user: _user,
        showUserAvatars: true,
        showUserNames: true,
        theme: customTheme,
        customBottomWidget: _buildCustomInputWidget(),
      ),
    );
  }
}
