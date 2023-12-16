import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/status.dart' as status;

connection() async {
  final socket = Uri.parse('ws://your-backend-url');
  var channel = WebSocketChannel.connect(socket);

  channel.stream.listen((message) {
    channel.sink.add('received!');
    channel.sink.close(status.goingAway);
  });
}