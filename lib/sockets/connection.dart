import 'package:chatheeps/util/constants.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/status.dart' as status;

connection() async {
  final socket = Uri.parse(SOCKET_URL);
  var channel = WebSocketChannel.connect(socket);

  channel.stream.listen((message) {
    channel.sink.add('received!');
    channel.sink.close(status.goingAway);
  });
}