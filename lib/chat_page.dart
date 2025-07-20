import 'dart:convert';

import 'package:flutter/material.dart';

import 'crypto_helper.dart';
import 'websocket_service.dart';

class ChatPage extends StatefulWidget {
  final String username;
  const ChatPage({required this.username, super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final List<String> _messages = [];
  final TextEditingController _controller = TextEditingController();

  late CryptoHelper cryptoHelper;
  late WebSocketService wsService;

  @override
  void initState() {
    super.initState();
    cryptoHelper = CryptoHelper();
    wsService = WebSocketService();

    wsService.connect('ws://129.153.113.104:9949/ws');

    wsService.stream.listen((encryptedMsg) {
      try {
        final decrypted =
            cryptoHelper.decrypt(base64Decode(encryptedMsg.toString()));
        setState(() {
          _messages.add(decrypted);
        });
      } catch (e) {
        print('Decrypt error: $e');
      }
    });
  }

  void _send() {
    final text = _controller.text.trim();
    if (text.isEmpty) return;

    final encrypted = cryptoHelper.encrypt(text);
    final encryptedBase64 = base64Encode(encrypted);

    wsService.sendMessage(encryptedBase64);

    setState(() {
      _messages.add('Me: $text');
      _controller.clear();
    });
  }

  @override
  void dispose() {
    wsService.disconnect();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Chat - ${widget.username}')),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length,
              itemBuilder: (_, i) => ListTile(title: Text(_messages[i])),
            ),
          ),
          Row(
            children: [
              Expanded(
                  child: TextField(
                controller: _controller,
                decoration: const InputDecoration(hintText: 'Enter message'),
              )),
              IconButton(icon: const Icon(Icons.send), onPressed: _send)
            ],
          ),
        ],
      ),
    );
  }
}
