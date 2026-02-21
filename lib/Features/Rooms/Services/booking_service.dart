import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:paradise_view/Features/Rooms/Model/booking_model.dart';

class BookingService {
  final FirebaseFirestore db = FirebaseFirestore.instance;

  Future<bool> createBooking(BookingModel booking) async {
    try {
      await db.collection('bookings').add(booking.toMap());
      return true;
    } catch (e) {
      print("ERROR CREATE BOOKING: $e");
      return false;
    }
  }

  Future<List<BookingModel>> getUserBookings(String userId) async {
    try {
      final snapshot = await db
          .collection('bookings')
          .where('userId', isEqualTo: userId)
          .orderBy('createdAt', descending: true)
          .get();

      return snapshot.docs.map((doc) {
        final data = doc.data();
        return BookingModel(
          userId: data['userId'],
          roomId: data['roomId'],
          roomTitle: data['roomTitle'],
          checkIn: (data['checkIn'] as Timestamp).toDate(),
          checkOut: (data['checkOut'] as Timestamp).toDate(),
          totalPrice: data['totalPrice'],
          totalNights: data['totalNights'],
          createdAt: (data['createdAt'] as Timestamp).toDate(),
        );
      }).toList();
    } catch (e) {
      print("ERROR GET BOOKINGS: $e");
      return [];
    }
  }
}
