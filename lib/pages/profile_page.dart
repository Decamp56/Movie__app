// import 'dart:io';
// import 'dart:typed_data';

// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:movieapp__s/auth/auth_service.dart';
// import 'package:movieapp__s/pages/login_page.dart'; // import your LoginPage
// import 'package:image_picker/image_picker.dart';

// class ProfilePage extends StatefulWidget {
//   const ProfilePage({super.key});

//   @override
//   State<ProfilePage> createState() => _ProfilePageState();
// }

// class _ProfilePageState extends State<ProfilePage> {
//   File? _mobileImage;
//   Uint8List? _webImage;

//   final ImagePicker _picker = ImagePicker();

//   Future<void> _pickImage() async {
//     final XFile? picture = await _picker.pickImage(source: ImageSource.gallery);
//     if (picture != null) {
//       if (kIsWeb) {
//         final bytes = await picture.readAsBytes();
//         setState(() {
//           _webImage = bytes;
//           _mobileImage = null;
//         });
//       } else {
//         setState(() {
//           _mobileImage = File(picture.path);
//           _webImage = null;
//         });
//       }
//     }
//   }

//   final authService = AuthService();

//   // logout button pressed
//   void logout() async {
//     await authService.signOut();

//     // After logout → go to LoginPage and clear navigation stack
//     if (mounted) {
//       Navigator.pushAndRemoveUntil(
//         context,
//         MaterialPageRoute(builder: (_) => const LoginPage()),
//         (route) => false, // removes all previous routes
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final currentEmail = authService.getCurrentUserEmail();

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Profile"),
//         actions: [
//           IconButton(onPressed: logout, icon: const Icon(Icons.logout)),
//         ],
//       ),
//       body: Column(
//         children: [
//           GestureDetector(
//             onTap: _pickImage,
//             child: Container(
//               height: 200,
//               width: 200,
//               decoration: BoxDecoration(
//                 shape: BoxShape.circle,
//                 color: Colors.greenAccent
//               ),
//               child: _webImage != null
//                   ? ClipOval(child: Image.memory(_webImage!, fit: BoxFit.cover,))
//                   : _mobileImage != null
//                   ? ClipOval(child: Image.file(_mobileImage!, fit: BoxFit.cover,))
//                   : Icon(Icons.person, size: 40),
//             ),
//           ),
//           const SizedBox(height: 16),
//           Text(
//             currentEmail ?? "No email",
//             style: Theme.of(context).textTheme.titleMedium,
//           ),
//         ],
//       ),
//     );
//   }
// }



import 'dart:typed_data';
import 'dart:io' show File;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Uint8List? _webImage;
  File? _mobileImage;

  final _fullNameController = TextEditingController();
  final _nicknameController = TextEditingController();
  final _dobController = TextEditingController();
  final _mobileController = TextEditingController();
  String _gender = "Male";

  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      if (kIsWeb) {
        final bytes = await pickedFile.readAsBytes();
        setState(() => _webImage = bytes);
      } else {
        setState(() => _mobileImage = File(pickedFile.path));
      }
    }
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _nicknameController.dispose();
    _dobController.dispose();
    _mobileController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Edit Profile")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0), // global page padding
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // 👤 Profile Image
            GestureDetector(
              onTap: _pickImage,
              child: Container(
                height: 160,
                width: 160,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.greenAccent,
                ),
                child: _webImage != null
                    ? ClipOval(
                        child: Image.memory(
                          _webImage!,
                          fit: BoxFit.cover,
                          width: 160,
                          height: 160,
                        ),
                      )
                    : _mobileImage != null
                        ? ClipOval(
                            child: Image.file(
                              _mobileImage!,
                              fit: BoxFit.cover,
                              width: 160,
                              height: 160,
                            ),
                          )
                        : const Icon(Icons.person, size: 80),
              ),
            ),

            const SizedBox(height: 24),

            // 📝 Full Name
            TextField(
              controller: _fullNameController,
              decoration: const InputDecoration(
                labelText: "Full Name",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),

            // 📝 Nickname
            TextField(
              controller: _nicknameController,
              decoration: const InputDecoration(
                labelText: "Nickname",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),

            // 📅 Date of Birth
            TextField(
              controller: _dobController,
              readOnly: true,
              decoration: InputDecoration(
                labelText: "Date of Birth",
                border: const OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.calendar_today),
                  onPressed: () async {
                    DateTime? picked = await showDatePicker(
                      context: context,
                      initialDate: DateTime(2000),
                      firstDate: DateTime(1900),
                      lastDate: DateTime.now(),
                    );
                    if (picked != null) {
                      setState(() {
                        _dobController.text =
                            "${picked.year}-${picked.month}-${picked.day}";
                      });
                    }
                  },
                ),
              ),
            ),
            const SizedBox(height: 16),

            // 📱 Mobile Number
            TextField(
              controller: _mobileController,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                labelText: "Mobile Number",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),

            // 🚻 Gender Dropdown
            DropdownButtonFormField<String>(
              value: _gender,
              items: ["Male", "Female", "Other"]
                  .map((g) => DropdownMenuItem(
                        value: g,
                        child: Text(g),
                      ))
                  .toList(),
              onChanged: (value) {
                setState(() => _gender = value!);
              },
              decoration: const InputDecoration(
                labelText: "Gender",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 24),

            // 💾 Save Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Profile saved (mock)")),
                  );
                },
                child: const Text("Save"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
