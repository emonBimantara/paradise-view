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
}

