import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paradise_view/Features/Rooms/Model/booking_model.dart';
import 'package:paradise_view/Features/Rooms/Services/booking_service.dart';

class BookingController extends GetxController {
  var isLoading = false.obs;
  final BookingService bookingService = BookingService();

  Future<void> processBooking({
    required String roomId,
    required String roomTitle,
    required DateTime checkIn,
    required DateTime checkOut,
    required int totalPrice,
    required int totalNights,
  }) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      Get.snackbar(
        "Error",
        "You must be logged in to book a room.",
        backgroundColor: Colors.red.shade100,
        colorText: Colors.red.shade900,
      );
      return;
    }

    try {
      isLoading.value = true;

      final bookingData = BookingModel(
        userId: user.uid,
        roomId: roomId,
        roomTitle: roomTitle,
        checkIn: checkIn,
        checkOut: checkOut,
        totalPrice: totalPrice,
        totalNights: totalNights,
        createdAt: DateTime.now(),
      );

      bool isSuccess = await bookingService.createBooking(bookingData);

      if (isSuccess) {
        Get.snackbar(
          "Success!",
          "Your room has been booked successfully.",
          backgroundColor: Colors.green.shade100,
          colorText: Colors.green.shade900,
          snackPosition: SnackPosition.TOP,
        );
        Get.offAllNamed('/home');
      } else {
        Get.snackbar(
          "Failed",
          "Something went wrong. Please try again.",
          backgroundColor: Colors.red.shade100,
          colorText: Colors.red.shade900,
        );
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false; 
    }
  }
}