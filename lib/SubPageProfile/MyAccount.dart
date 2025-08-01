import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class MyAccountPage extends StatefulWidget {
  const MyAccountPage({super.key});

  @override
  State<MyAccountPage> createState() => _MyAccountPageState();
}

class _MyAccountPageState extends State<MyAccountPage> {
  File? _image;

  Future<void> pickImage() async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile == null) {
      return;
    }

    setState(() {
      _image = File(pickedFile.path);
    });
  }

  Future<void> pickImageFromGallery() async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  Future<void> pickImageFromCamera() async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.camera,
    );
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromARGB(255, 87, 167, 177),
                  const Color.fromARGB(255, 12, 105, 122),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          title: const Text('ຂໍ້ມູນສ່ວນຕົວ'),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.white,
          elevation: 0,
          leading: Container(
            margin: const EdgeInsets.all(8),
            child: IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              color: Colors.white,
              onPressed: () => Navigator.pop(context),
              splashRadius: 24,
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  Column(
                    children: [
                      Stack(
                        children: [
                          CircleAvatar(
                            radius: 60,
                            backgroundColor: const Color.fromARGB(
                              255,
                              225,
                              225,
                              225,
                            ),
                            backgroundImage: _image != null
                                ? FileImage(_image!) as ImageProvider
                                : const AssetImage('assets/images/house.jpg'),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: IconButton(
                              onPressed: () {
                                showModalBottomSheet(
                                  context: context,
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(20),
                                    ),
                                  ),
                                  builder: (BuildContext context) {
                                    return Wrap(
                                      children: [
                                        ListTile(
                                          leading: const Icon(
                                            Icons.photo_library,
                                            color: Color(0xFF006B8B),
                                          ),
                                          title: const Text('ເລືອກຮູບຈາກຄັງ'),
                                          onTap: () async {
                                            Navigator.pop(context);
                                            await pickImageFromGallery();
                                          },
                                        ),
                                        ListTile(
                                          leading: const Icon(
                                            Icons.camera_alt,
                                            color: Color(0xFF006B8B),
                                          ),
                                          title: const Text('ຖ່າຍຮູບ'),
                                          onTap: () async {
                                            Navigator.pop(context);
                                            await pickImageFromCamera();
                                          },
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },

                              icon: const Icon(
                                Icons.add_a_photo,
                                color: Color(0xFF006B8B),
                                size: 20,
                              ),
                              style: IconButton.styleFrom(
                                padding: const EdgeInsets.all(6),
                                shape: const CircleBorder(),
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 15),
                      const Text(
                        'ສາຍສະຫັວນ ແກ້ວມະນີ',
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 40),

                  const ProfileInfoTile(
                    icon: Icons.person,
                    text: 'ສາຍສະຫັວນ ແກ້ວມະນີ',
                  ),
                  const ProfileInfoTile(icon: Icons.phone, text: '209747xxxx'),
                  const ProfileInfoTile(
                    icon: Icons.email,
                    text: 'xxx@gmail.com',
                  ),

                  const SizedBox(height: 40),

                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color.fromARGB(255, 87, 167, 177),
                          Color.fromARGB(255, 12, 105, 122),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: ElevatedButton(
                      onPressed: () {
                        showEditProfileForm(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: const Text(
                        'ແກ້ໄຂຂໍ້ມູນ',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void showEditProfileForm(BuildContext context) {
    String name = 'ສາຍສະຫັວນ ແກ້ວມະນີ';
    String phone = '209747xxxx';
    String email = 'xxx@gmail.com';

    showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
      ),
      context: context,
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            top: 30,
            left: 20,
            right: 20,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'ແກ້ໄຂຂໍ້ມູນສ່ວນຕົວ',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              TextFormField(
                initialValue: name,
                decoration: const InputDecoration(labelText: 'ຊື່'),
                onChanged: (value) => name = value,
              ),
              TextFormField(
                initialValue: phone,
                decoration: const InputDecoration(labelText: 'ເບີໂທ'),
                keyboardType: TextInputType.phone,
                onChanged: (value) => phone = value,
              ),
              TextFormField(
                initialValue: email,
                decoration: const InputDecoration(labelText: 'ອີເມວ'),
                keyboardType: TextInputType.emailAddress,
                onChanged: (value) => email = value,
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 12, 105, 122),
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    // TODO: Save changes here
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('ບັນທຶກຂໍ້ມູນສຳເລັດ')),
                    );
                  },
                  child: const Text(
                    'ບັນທຶກ',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),
              const SizedBox(height: 30),
            ],
          ),
        );
      },
    );
  }
}

class ProfileInfoTile extends StatelessWidget {
  final IconData icon;
  final String text;

  const ProfileInfoTile({super.key, required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
        child: Row(
          children: [
            Icon(icon, color: Colors.grey[600]),
            const SizedBox(width: 20),
            Text(
              text,
              style: const TextStyle(fontSize: 16, color: Colors.black87),
            ),
          ],
        ),
      ),
    );
  }
}
