import 'package:align_flutter_app/shared/constants/socket_constant.dart';
import 'package:get/get.dart';

import 'package:socket_io_client/socket_io_client.dart';

class SocketService {
  static final Socket socket = io(SocketConstants.socketUrl,
      OptionBuilder().setTransports(['websocket']).build());
  static String? roomId;
  static var name = "".obs;
  static var finalName = "".obs;
  static var messageList = [].obs;
  static var senderId = 1.obs;
  static var recieverId = 2.obs;
  static var messageType = 0.obs;
  static String? recId;
  static var isOnline = 0.obs;
  static var isTyping = false.obs;
  static RxString imagePath = ''.obs;

  static connectSocket() {
    if (!socket.connected) {
      socket.onConnect((data) => updateUserStatus());
    } else {
      updateUserStatus();
    }

    socket.onConnectError((data) => print("Connect Error: $data"));
    socket.onDisconnect((data) => print("Socket Disconnected"));

    getOtherUserOnlineStatus();
    createRoom();
    roomConnectedResponse();
    receivedMessage();
    senderTyping();
    displayTyping();
    removeTypingMessage();
  }

  static updateUserStatus() {
    print('Socket Connected');
    var req = {
      'senderId': senderId.value,
      'receiverId': recieverId.value,
    };
    socket.emit(
      SocketConstants.updateStatusToOnline,
      req,
    );
  }

  static createRoom() {
    try {
      socket.emit(SocketConstants.createRoom, {
        'senderId': senderId.value,
        'receiverId': recieverId.value,
      });
    } catch (e) {
      print("socketChat Exception=======$e");
    }
  }

  static sendMessage(int type, String message, bool hasImage) {
    try {
      socket.emit(SocketConstants.sendMessage, {
        'message': message,
        'type': type,
        'senderId': senderId.value,
        'receiverId': recieverId.value,
        'roomId': roomId
      });
      messageList
          .insert(0, {'msg': message, 'isSender': true, 'isImage': hasImage});
      isTyping.value = false;
      removeTyping();
      //  printInfo(info: 'messageList : ${messageList.map((element) => element)}');

      messageType.value = type;
      // printInfo(info: "messageList.length${messageList.length}");
    } catch (e) {
      //  printInfo(info: "send message exception=======$e");
    }
  }

  static receivedMessage() {
    try {
      socket.on(SocketConstants.newMessageListener, (data) {
        // printInfo(info: "${SocketConstants.newMessageListener} : $data}");
        Map<String, dynamic> receivedMessageData = {
          'roomId': data['roomId'],
          'senderId': senderId.value,
          'receiverId': recieverId.value,
          'chatId': 0
        };
        socket.emit(SocketConstants.readMessage, receivedMessageData);
        String msg = data['message'];
        messageList.insert(0, {
          'msg': msg,
          'isSender': false,
        });

        //ssenderId.value = data['senderId'];
        //printInfo(info: "senderId: $senderId");
      });
    } catch (e) {
      //printInfo(info: "newMessage exception: $e");
    }
  }

  static getOtherUserOnlineStatus() {
    socket.on(SocketConstants.statusOnlineListener, (data) {
      // isOnline.value = data['isOnline'];
      print(data);
    });
  }

  static roomConnectedResponse() {
    try {
      socket.on(SocketConstants.roomConnectedListener, (data) {
        // printInfo(info: '${SocketConstants.createRoom} : $data');
        if (data != null) {
          roomId = data;
        }
      });
    } catch (e) {
      //  printInfo(info: '$e');
    }
  }

  static void senderTyping() {
    try {
      var mapData = {
        'senderId': senderId.value,
        'receiverId': recieverId.value,
      };
      socket.emit(SocketConstants.typing, mapData);
    } catch (e) {
      print(e);
    }
  }

  static void displayTyping() {
    try {
      socket.on(SocketConstants.displayTyping, (data) {
        print(
            '${SocketConstants.displayTyping} ${data['receiverId'].runtimeType}');

        if (data['receiverId'] == "1") {
          isTyping.value = true;
        } else {
          isTyping.value = false;
        }
      });
    } catch (e) {
      print(e);
    }
  }

  static void removeTyping() {
    try {
      var mapData = {
        'senderId': senderId.value,
        'receiverId': recieverId.value,
      };
      socket.emit(SocketConstants.removeTyping, mapData);
    } catch (e) {
      print(e);
    }
  }

  static void removeTypingMessage() {
    try {
      socket.on(
        SocketConstants.removeTypingMessage,
        (data) {
          print('${SocketConstants.removeTypingMessage} $data');
          isTyping.value = false;
        },
      );
    } catch (e) {
      print(e);
    }
  }
}
