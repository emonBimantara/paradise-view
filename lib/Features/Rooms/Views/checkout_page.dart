import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:paradise_view/Components/custom_button.dart';
import 'package:paradise_view/Features/Home/Model/room_model.dart';
import 'package:paradise_view/Features/Rooms/Controller/booking_controller.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({super.key});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  final RoomModel room = Get.arguments;
  final formatter = NumberFormat('#,###', 'id_ID');

  final bookingController = Get.put(BookingController());

  DateTimeRange? selectedDateRange;

  Future<void> _pickDateRange() async {
    final DateTimeRange? picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: Color(0xff7C6A46),
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
            datePickerTheme: DatePickerThemeData(
              rangeSelectionBackgroundColor: Color(
                0xff7C6A46,
              ).withValues(alpha: 0.15),
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null && picked != selectedDateRange) {
      setState(() {
        selectedDateRange = picked;
      });
    }
  }

  int get totalNights {
    if (selectedDateRange == null) return 0;
    final days = selectedDateRange!.duration.inDays;
    return days == 0 ? 1 : days;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Get.back(),
        ),
        title: Text(
          "Checkout",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Color(0xfffafafa),
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      room.roomImg.isNotEmpty
                          ? room.roomImg[0]
                          : 'https://placehold.co/100',
                      width: 80,
                      height: 80,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(width: 15),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          room.title,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          room.category,
                          style: TextStyle(color: Colors.grey),
                        ),
                        SizedBox(height: 5),
                        Text(
                          "Rp ${formatter.format(room.price)} / night",
                          style: TextStyle(
                            color: Color(0xff7C6A46),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 30),

            Text(
              "Select Dates",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 15),
            GestureDetector(
              onTap: _pickDateRange,
              child: Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Color(0xff7C6A46)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.calendar_month, color: Color(0xff7C6A46)),
                        SizedBox(width: 10),
                        Text(
                          selectedDateRange == null
                              ? "Choose Check-in & Check-out"
                              : "${DateFormat('dd MMM').format(selectedDateRange!.start)}  -  ${DateFormat('dd MMM yyyy').format(selectedDateRange!.end)}",
                          style: TextStyle(
                            color: selectedDateRange == null
                                ? Colors.grey
                                : Colors.black,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    if (selectedDateRange != null)
                      Text(
                        "($totalNights Nights)",
                        style: TextStyle(
                          color: Color(0xff7C6A46),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                  ],
                ),
              ),
            ),

            Spacer(),

            if (selectedDateRange != null)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Total Payment",
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                  Text(
                    "Rp ${formatter.format(room.price * totalNights)}",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff7C6A46),
                    ),
                  ),
                ],
              ),

            SizedBox(height: 20),

            Obx(
              () => GestureDetector(
                onTap: () {
                  if (bookingController.isLoading.value) return;

                  if (selectedDateRange == null) {
                    Get.snackbar(
                      "Oops!",
                      "Please select your dates first",
                      backgroundColor: Colors.red.shade100,
                      colorText: Colors.red.shade900,
                    );
                    return;
                  }

                  bookingController.processBooking(
                    roomId: room.id,
                    roomTitle: room.title,
                    checkIn: selectedDateRange!.start,
                    checkOut: selectedDateRange!.end,
                    totalPrice: room.price * totalNights,
                    totalNights: totalNights,
                  );
                },
                child: bookingController.isLoading.value
                    ? const Center(
                        child: CircularProgressIndicator(
                          color: Color(0xff7C6A46),
                        ),
                      )
                    : const CustomButton(text: "Confirm Booking"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
