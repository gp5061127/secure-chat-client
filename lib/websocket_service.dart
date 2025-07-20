import 'dart:convert';
import 'package:web_socket_channel/io.dart';

class WebSocketService {
  late IOWebSocketChannel _channel;

  void connect(String url) {
    _channel = IOWebSocketChannel.connect(url);

    _channel.stream.listen((message) {
      print('Received: $message');
    }, onDone: () {
      print('WebSocket closed');
    }, onError: (error) {
      print('WebSocket error: $error');
    });
  }

  void sendMessage(String message) {
    _channel.sink.add(message);
  }

  void disconnect() {
    _channel.sink.close();
  }

  Stream get stream => _channel.stream;
}
