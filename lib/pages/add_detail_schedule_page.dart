import 'package:flutter/material.dart';
import 'package:pantau_belajar/components/my_button.dart';
import 'package:pantau_belajar/components/my_dropdown.dart';
import 'package:pantau_belajar/components/my_text_field.dart';
import 'package:pantau_belajar/models/detail_schedule.dart';
import 'package:pantau_belajar/models/schedule.dart';
import 'package:pantau_belajar/services/detail_schedule_service.dart';
import 'package:simple_time_range_picker/simple_time_range_picker.dart';

class AddDetailSchedulePage extends StatefulWidget {
  final Schedule? schedule;
  final DetailSchedule? detailSchedule;
  const AddDetailSchedulePage(
      {super.key, required this.schedule, this.detailSchedule});

  @override
  State<AddDetailSchedulePage> createState() => _AddDetailSchedulePageState();
}

class _AddDetailSchedulePageState extends State<AddDetailSchedulePage> {
  TextEditingController titleController = TextEditingController();
  TimeOfDay? startTime = TimeOfDay.now();
  TimeOfDay? endTime = TimeOfDay.now();
  String? selectedValue;
  DetailSchedule? detailSchedule;
  DetailScheduleService detailScheduleService = DetailScheduleService();

  @override
  void initState() {
    super.initState();
    if (widget.detailSchedule != null) {
      detailSchedule = widget.detailSchedule;
      titleController.text = detailSchedule!.title;
      startTime = detailSchedule!.startTime;
      endTime = detailSchedule!.endTime;
      selectedValue = detailSchedule!.day;
    }
  }

  @override
  Widget build(BuildContext context) {
    List<String> days = [
      'senin',
      'selasa',
      'rabu',
      'kamis',
      'jumat',
      'sabtu',
      'minggu'
    ];
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambah Jadwal'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 30),
              Center(child: Icon(Icons.task, size: 80)),
              const SizedBox(height: 30),
              MyTextField(
                hintText: 'Judul',
                icon: const Icon(Icons.title),
                textEditingController: titleController,
              ),
              const SizedBox(height: 13),
              Padding(
                padding: const EdgeInsets.only(left: 40),
                child: MyDropdown(
                  items: days,
                  selectedValue: selectedValue,
                  onChanged: (value) {
                    setState(() {
                      selectedValue = value;
                    });
                  },
                ),
              ),
              const SizedBox(height: 13),
              Padding(
                padding: const EdgeInsets.only(left: 40),
                child: Row(
                  children: [
                    _buildTimeDisplay(startTime),
                    const Text(' - ', style: TextStyle(fontSize: 25)),
                    _buildTimeDisplay(endTime),
                    const SizedBox(width: 4),
                    GestureDetector(
                      onTap: () => _showTimeRangePicker(),
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 57, 42, 171),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(Icons.edit, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              MyButton(
                color: const Color.fromARGB(255, 57, 42, 171),
                child:
                    const Text('Simpan', style: TextStyle(color: Colors.white)),
                onTap: _onSave,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTimeDisplay(TimeOfDay? time) {
    return Container(
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(width: 0.5),
      ),
      child: Text(
        '${time?.hour.toString().padLeft(2, '0')} : ${time?.minute.toString().padLeft(2, '0')}',
        style: const TextStyle(fontSize: 25),
      ),
    );
  }

  void _showTimeRangePicker() {
    TimeRangePicker.show(
      context: context,
      unSelectedEmpty: true,
      startTime: TimeOfDay(hour: startTime!.hour, minute: startTime!.minute),
      endTime: TimeOfDay(hour: endTime!.hour, minute: endTime!.minute),
      onSubmitted: (TimeRangeValue value) {
        setState(() {
          startTime = value.startTime;
          endTime = value.endTime;
        });
      },
    );
  }

  void _onSave() async {
    // Validate inputs
    if (titleController.text.isEmpty || selectedValue == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Judul dan hari wajib diisi')),
      );
      return;
    }

    if (startTime == null || endTime == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Waktu mulai dan selesai wajib diisi')),
      );
      return;
    }

    final newDetailSchedule = DetailSchedule(
      id: detailSchedule?.id ?? '', // Create new id or use the existing one
      uid: widget.schedule!.uid,
      scheduleId: widget.schedule!.id,
      title: titleController.text,
      day: selectedValue!,
      startTime: startTime!,
      endTime: endTime!,
    );

    try {
      if (detailSchedule != null) {
        // Update existing schedule
        await detailScheduleService.updateDetailSchedule(newDetailSchedule);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Jadwal berhasil diupdate')),
        );
      } else {
        // Add new schedule
        await detailScheduleService.addDetailSchedule(newDetailSchedule);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Jadwal berhasil disimpan')),
        );
      }
      Navigator.pop(context); // Close the page after saving
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Terjadi kesalahan: $e')),
      );
    }
  }
}
