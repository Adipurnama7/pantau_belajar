import 'package:flutter/material.dart';
import 'package:pantau_belajar/services/user_service.dart';
import 'package:pantau_belajar/models/app_user.dart';

class UserDetailPage extends StatelessWidget {
  final UserService userService = UserService();

  UserDetailPage({super.key});

  Future<AppUser?> _getUserData() async {
    return await userService.getCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(),
          ),
          FutureBuilder<AppUser?>(
            future: _getUserData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasError) {
                return const Center(
                  child: Text('Terjadi kesalahan saat memuat data pengguna'),
                );
              } else if (!snapshot.hasData || snapshot.data == null) {
                return const Center(
                  child: Text('Pengguna tidak ditemukan'),
                );
              }

              // Data pengguna berhasil diambil
              AppUser user = snapshot.data!;
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    AppBar(
                      backgroundColor: const Color.fromARGB(255, 57, 42, 171),
                      elevation: 0,
                      leading: IconButton(
                        icon: const Icon(Icons.arrow_back, color: Colors.white),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      title: const Text("Profile",
                          style: TextStyle(color: Colors.white)),
                      centerTitle: true,
                    ),
                    Container(
                      padding: const EdgeInsets.only(top: 24, bottom: 36),
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20),
                        ),
                        color: Color.fromARGB(255, 57, 42, 171),
                      ),
                      child: const Column(
                        children: [
                          CircleAvatar(
                            radius: 50,
                            backgroundImage: AssetImage('images/profile.png'),
                          ),
                          SizedBox(height: 16),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Informasi Pribadi",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 16),
                          _buildTextField(
                              label: "Email", initialValue: user.email),
                          _buildTextField(
                              label: "Username", initialValue: user.username),
                          const SizedBox(height: 32),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color.fromARGB(255, 57, 42, 171),
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: const Center(
                              child: Text(
                                "Kembali",
                                style: TextStyle(
                                    fontSize: 16, color: Colors.white),
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

Widget _buildTextField({required String label, required String initialValue}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0),
    child: TextField(
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(
            fontSize: 12, color: Color.fromARGB(255, 57, 42, 171)),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Color.fromARGB(255, 57, 42, 171)),
        ),
        filled: true,
        fillColor: Colors.grey.shade100.withOpacity(0.8),
      ),
      controller: TextEditingController(text: initialValue),
      readOnly: true,
    ),
  );
}
