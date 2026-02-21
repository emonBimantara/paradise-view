import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paradise_view/Components/custom_button.dart';
import 'package:paradise_view/Features/Home/Model/room_model.dart';

class RoomPage extends StatefulWidget {
  const RoomPage({super.key});

  @override
  State<RoomPage> createState() => _RoomPageState();
}

class _RoomPageState extends State<RoomPage> {
  final RoomModel room = Get.arguments;

  int selectedImageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  SizedBox(
                    height: 300,
                    width: double.infinity,
                    child: Image.network(
                      room.roomImg[selectedImageIndex],
                      fit: BoxFit.cover,
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(left: 15, top: 15),
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      child: IconButton(
                        icon: Icon(Icons.arrow_back, color: Colors.black),
                        onPressed: () => Get.back(),
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 20),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  "Room Specification",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
              ),

              SizedBox(height: 20),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(room.spesification, style: TextStyle(fontSize: 14)),
              ),

              SizedBox(height: 20),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  "Facilities",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),

              SizedBox(height: 10),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: room.facilities.map((facility) {
                    return Chip(
                      label: Text(
                        facility,
                        style: TextStyle(color: Color(0xff7C6A46)),
                      ),
                      backgroundColor: Colors.white
                    );
                  }).toList(),
                ),
              ),

              SizedBox(height: 20),

              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: SizedBox(
                  height: 80,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: room.roomImg.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedImageIndex = index;
                          });
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 3),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: selectedImageIndex == index
                                  ? Color(0xff7C6A46)
                                  : Colors.transparent,
                              width: 2,
                            ),
                          ),
                          child: Image.network(
                            room.roomImg[index],
                            width: 90,
                            height: 90,
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),

              SizedBox(height: 30),

              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 10,
                ),
                child: CustomButton(text: "Book Room"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
