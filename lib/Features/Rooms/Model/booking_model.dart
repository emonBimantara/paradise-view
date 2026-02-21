import 'package:cloud_firestore/cloud_firestore.dart';

class BookingModel {
  final String userId;
  final String roomId;
  final String roomTitle;
  final DateTime checkIn;
  final DateTime checkOut;
  final int totalPrice;
  final int totalNights;
  final DateTime createdAt;

  BookingModel({
    required this.userId,
    required this.roomId,
    required this.roomTitle,
    required this.checkIn,
    required this.checkOut,
    required this.totalPrice,
    required this.totalNights,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'roomId': roomId,
      'roomTitle': roomTitle,
      'checkIn': Timestamp.fromDate(checkIn),
      'checkOut': Timestamp.fromDate(checkOut),
      'totalPrice': totalPrice,
      'totalNights': totalNights,
      'createdAt': Timestamp.fromDate(createdAt),
    };
  }
}
