import 'package:cloud_firestore/cloud_firestore.dart';

class ChatService {
  static String generateChatRoomId(List<String> participantIds) {
    participantIds.sort();

    String chatRoomId = participantIds.join('-');

    return chatRoomId;
  }

  static Future<List<String>> getChatRoomIdsForUser(String username) async {
    List<String> chatRoomIds = [];

    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('chatroon')
          .where('chatroon', arrayContains: username)
          .get();

      querySnapshot.docs.forEach((doc) {
        chatRoomIds.add(doc.id);
      });
    } catch (e) {
      print('Error retrieving chat room IDs: $e');
    }

    return chatRoomIds;
  }
}
