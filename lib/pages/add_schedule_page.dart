import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pantau_belajar/components/my_button.dart';
import 'package:pantau_belajar/components/my_custom_card.dart';
import 'package:pantau_belajar/components/my_text_field.dart';
import 'package:pantau_belajar/models/app_user.dart';
import 'package:pantau_belajar/models/schedule.dart';
import 'package:pantau_belajar/pages/main_page.dart';
import 'package:pantau_belajar/services/schedule_service.dart';
import 'package:pantau_belajar/services/user_service.dart';

class AddSchedulePage extends StatefulWidget {
  Schedule? schedule;
  AddSchedulePage({super.key, this.schedule});

  @override
  _saveSchedule_AddSchedulePageState createState() =>
      _saveSchedule_AddSchedulePageState();
}

class _saveSchedule_AddSchedulePageState extends State<AddSchedulePage> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController headingController = TextEditingController();
  final TextEditingController subheadingController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  final ScheduleService _scheduleService = ScheduleService();
  final UserService userService = UserService();
  Future<AppUser?>? userData;
  Schedule? schedule;

  @override
  void initState() {
    super.initState();
    userData = userService.getCurrentUser();
    if (widget.schedule != null) {
      schedule = widget.schedule;
      titleController.text = widget.schedule!.title;
      headingController.text = widget.schedule!.heading;
      subheadingController.text = widget.schedule!.subheading;
      descriptionController.text = widget.schedule!.description;
    }
  }

  // Fungsi untuk menambahkan jadwal baru
  void _saveSchedule(AppUser user) async {
    String title = titleController.text.trim();
    String heading = headingController.text.trim();
    String subheading = subheadingController.text.trim();
    String description = descriptionController.text.trim();

    if (title.isEmpty ||
        heading.isEmpty ||
        subheading.isEmpty ||
        description.isEmpty) {
      // Tampilkan snackbar jika ada field yang kosong
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Semua area harus diisi')));
      return;
    }

    Schedule newSchedule = Schedule(
      id: schedule?.id ?? '', // Firestore akan mengenerate ID secara otomatis
      uid: user.uid,
      title: title,
      heading: heading,
      subheading: subheading,
      description: description,
      timestamp: Timestamp.now(),
    );

    try {
      if (schedule != null) {
        await _scheduleService.updateSchedule(newSchedule);
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Jadwal berhasil di update')));
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MainPage(
                bottomNavIdx: 1,
              ),
            ));
        // Reset semua field setelah berhasil menambah jadwal
        titleController.clear();
        headingController.clear();
        subheadingController.clear();
        descriptionController.clear();
      } else {
        await _scheduleService.addSchedule(newSchedule);
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Jadwal berhasil ditambahkan')));
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MainPage(
                bottomNavIdx: 1,
              ),
            ));
        // Reset semua field setelah berhasil menambah jadwal
        titleController.clear();
        headingController.clear();
        subheadingController.clear();
        descriptionController.clear();
      }
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Gagal menambahkan jadwal')));
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text('Tambah Jadwal'),
      ),
      body: FutureBuilder<AppUser?>(
        future: userData, // Tunggu data pengguna dari Firebase
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Terjadi kesalahan, coba lagi.'));
          } else if (!snapshot.hasData) {
            return Center(child: Text('Pengguna tidak ditemukan'));
          } else {
            AppUser user =
                snapshot.data!; // Mendapatkan data pengguna yang valid
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 6),
                    child: Text(
                      'Preview:',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  SizedBox(height: 6),
                  Padding(
                    padding: const EdgeInsets.only(
                        bottom: 20.0, left: 20, right: 20),
                    child: ValueListenableBuilder(
                      valueListenable: titleController,
                      builder: (context, title, _) {
                        return ValueListenableBuilder(
                          valueListenable: headingController,
                          builder: (context, heading, _) {
                            return ValueListenableBuilder(
                              valueListenable: subheadingController,
                              builder: (context, subheading, _) {
                                return ValueListenableBuilder(
                                  valueListenable: descriptionController,
                                  builder: (context, description, _) {
                                    return MyCustomCard(
                                      title: titleController.text.isNotEmpty
                                          ? titleController.text
                                          : 'Judul Default',
                                      heading: headingController.text.isNotEmpty
                                          ? headingController.text
                                          : 'Heading Default',
                                      subheading:
                                          subheadingController.text.isNotEmpty
                                              ? subheadingController.text
                                              : 'Subheading Default',
                                      description:
                                          descriptionController.text.isNotEmpty
                                              ? descriptionController.text
                                              : 'Deskripsi Default',
                                      screenWidth: screenWidth,
                                    );
                                  },
                                );
                              },
                            );
                          },
                        );
                      },
                    ),
                  ),
                  Expanded(
                    child: ListView(
                      children: [
                        Text(
                          'Catat jadwal anda: ',
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                          ),
                        ),
                        MyTextField(
                          hintText: 'Judul',
                          maxlength: 15,
                          icon: Icon(Icons.title),
                          textEditingController: titleController,
                        ),
                        MyTextField(
                          maxlength: 20,
                          hintText: 'Heading',
                          icon: Icon(Icons.text_fields),
                          textEditingController: headingController,
                        ),
                        MyTextField(
                          maxlength: 20,
                          hintText: 'Subheading',
                          icon: Icon(Icons.calendar_today),
                          textEditingController: subheadingController,
                        ),
                        MyTextField(
                          maxlength: 20,
                          hintText: 'Deskripsi',
                          icon: Icon(Icons.description),
                          textEditingController: descriptionController,
                        ),
                        const SizedBox(height: 16),
                        MyButton(
                          child: Text(
                            'Tambah Jadwal',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          onTap: () => _saveSchedule(user),
                          color: Color.fromARGB(255, 57, 42, 171),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
