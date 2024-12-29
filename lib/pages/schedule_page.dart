import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pantau_belajar/components/my_custom_card.dart';
import 'package:pantau_belajar/pages/detail_schedule_page.dart';

class SchedulePage extends StatefulWidget {
  const SchedulePage({super.key});

  @override
  State<SchedulePage> createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {


  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (context) {
              return Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 5.0,
                  horizontal: 25.0,
                ),
                child: Column(
                  children: [
                    Container(
                      height: 200,
                      width: 300,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(
                              "https://images.pexels.com/photos/26600774/pexels-photo-26600774/free-photo-of-a-polar-bear-is-swimming-in-the-water.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1"),
                        ),
                      ),
                    ),
                    const Text(
                      "Polar Bear",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                      ),
                    ),
                    const Text(
                      "The polar bear is a large bear native to the Arctic and nearby areas. It is closely related to the brown bear, and the two species can interbreed. The polar bear is the largest extant species of bear and land carnivore, with adult males weighing 300–800 kg.",
                    ),
                    ListTile(
                      leading: const Icon(
                        Icons.share,
                      ),
                      title: const Text(
                        "Share",
                      ),
                      onTap: () {
                        Navigator.pop(
                          context,
                        );
                      },
                    )
                  ],
                ),
              );
            },
          );
        },
        child: const Icon(
          Icons.open_in_browser,
        ),
      ),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          title: Text(
            "Jadwal",
            style: GoogleFonts.poppins(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: const Color.fromARGB(255, 57, 42, 171),
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                ListView.builder(
                  itemCount: 6, // Misalnya, ada 6 data jadwal
                  shrinkWrap: true, // Agar tidak mengambil seluruh tinggi layar
                  physics:
                      const NeverScrollableScrollPhysics(), // Menghindari konflik scroll
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        const SizedBox(height: 10),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => DetailSchedulePage(),));
                          },
                          child: MyCustomCard(
                            title: 'Belajar Flutter',
                            heading: 'Due Date',
                            subheading: '2023-12-25', // Ganti dengan tanggal relevan
                            description: 'Hari ini tidak ada kuliah',
                            screenWidth: screenWidth,
                          ),
                        ),
                      ],
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
