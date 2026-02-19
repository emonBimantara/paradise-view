import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:paradise_view/Features/Home/Model/room_model.dart';

class RoomService {
  final FirebaseFirestore db = FirebaseFirestore.instance;

  Future<List<String>> getRoomCategories() async {
    try {
      final snapshot = await db.collection('categories').orderBy('order').get();

      return snapshot.docs.map((doc) {
        return doc['Name'] as String;
      }).toList();
    } catch (e) {
      print("ERROR GET CATEGORIES: $e");
      return [];
    }
  }

  Future<List<RoomModel>> getRooms(String selectedCategory) async {
    try {
      final snapshot = await db
          .collection('rooms')
          .where('category', isEqualTo: selectedCategory)
          .get();

      return snapshot.docs.map((doc) {
        return RoomModel.fromFireStore(doc.id, doc.data());
      }).toList();
    } catch (e) {
      return [];
    }
  }
}
