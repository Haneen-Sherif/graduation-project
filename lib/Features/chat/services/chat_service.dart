import 'package:cloud_firestore/cloud_firestore.dart';

class ChatService {
  static String generateChatRoomId(List<String> participantIds) {
    // Sort the list of participant IDs to ensure consistent chat room ID
    participantIds.sort();

    // Concatenate participant IDs to form the chat room ID
    String chatRoomId = participantIds.join('-');

    return chatRoomId;
  }

  static Future<List<String>> getChatRoomIdsForUser(String username) async {
    List<String> chatRoomIds = [];

    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('chatRooms')
          .where('participants', arrayContains: username)
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
