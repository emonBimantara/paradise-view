import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paradise_view/Components/custom_category_room.dart';
import 'package:paradise_view/Components/custom_room_card.dart';
import 'package:paradise_view/Features/Home/Model/room_model.dart';
import 'package:paradise_view/Features/Home/Service/room_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController searchController = TextEditingController();

  late Future<List<String>> categoryList;
  String selectedCategory = '';

  late Future<List<RoomModel>> roomList;

  @override
  void initState() {
    categoryList = RoomService().getRoomCategories();
    selectedCategory = "Standard";
    roomList = RoomService().getRooms(selectedCategory);
    super.initState();
  }

  String getGreeting() {
    final hour = DateTime.now().hour;

    if (hour >= 5 && hour < 12) {
      return "Good Morning";
    } else if (hour >= 12 && hour < 15) {
      return "Good Afternoon";
    } else if (hour >= 15 && hour < 18) {
      return "Good Evening";
    } else {
      return "Good Night";
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset('assets/hamburger.png', height: 20),
                    Text(getGreeting(), style: TextStyle(fontSize: 15)),
                    GestureDetector(
                      onTap: () => Get.toNamed('/history'),
                      child: Image.asset('assets/book.png', height: 25)),
                  ],
                ),
                SizedBox(height: 35),

                Container(
                  decoration: BoxDecoration(
                    color: Color(0xfffafafa),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextField(
                    onChanged: (value) {
                      setState(() {});
                    },
                    controller: searchController,
                    decoration: InputDecoration(
                      hintText: "Search your favorite room",
                      hintStyle: TextStyle(
                        color: Color(0x66000000),
                        fontSize: 14,
                      ),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(vertical: 14),
                      prefixIcon: Image.asset('assets/search.png', height: 10),
                    ),
                  ),
                ),

                SizedBox(height: 25),

                Container(
                  height: 190,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/containImg.png'),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 250,
                          child: Text(
                            'Stay where every moment feels special.',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Colors.white,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        SizedBox(height: 20),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 10,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            'Book now',
                            style: TextStyle(
                              color: Color(0xff7C6A46),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: 25),

                Center(
                  child: Text(
                    'Choose a room',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Color(0xff7C6A46),
                      fontSize: 20,
                    ),
                  ),
                ),

                SizedBox(height: 15),

                SizedBox(
                  height: 40,
                  child: FutureBuilder<List<String>>(
                    future: categoryList,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              color: Color(0xff7C6A46),
                              strokeWidth: 2,
                            ),
                          ),
                        );
                      }

                      if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return Center(child: Text("No categories found"));
                      }
                      List<String> category = snapshot.data!;

                      return CustomCategoryRoom(
                        categories: category,
                        selectedCategory: selectedCategory,
                        onCategorySelected: (name) {
                          setState(() {
                            selectedCategory = name;
                            roomList = RoomService().getRooms(selectedCategory);
                          });
                        },
                      );
                    },
                  ),
                ),

                SizedBox(height: 10),

                FutureBuilder(
                  future: roomList,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(
                          color: Color(0xff7C6A46),
                        ),
                      );
                    }

                    final rooms = snapshot.data ?? [];
                    if (rooms.isEmpty) {
                      return Center(child: Text("No Rooms Available"));
                    }

                    final searchQuery = searchController.text.toLowerCase();
                    final filteredRooms = rooms.where((room) {
                      return room.title.toLowerCase().contains(searchQuery);
                    }).toList();

                    if (filteredRooms.isEmpty) {
                      return const Padding(
                        padding: EdgeInsets.only(top: 20),
                        child: Center(child: Text("No Data")),
                      );
                    }

                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: filteredRooms.length,
                      itemBuilder: (context, index) {
                        final room = filteredRooms[index];
                        return GestureDetector(
                          onTap: () =>
                              Get.toNamed('/room', arguments: room),
                          child: CustomRoomCard(
                            title: room.title,
                            imageUrl: room.roomImg.isNotEmpty
                                ? room.roomImg[0]
                                : 'https://placeholder.com/150',
                            rating: room.rating,
                            price: room.price,
                            guest: room.guest,
                          ),
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
