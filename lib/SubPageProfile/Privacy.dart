import 'package:flutter/material.dart';

class PrivacyPages extends StatefulWidget {
  const PrivacyPages({super.key});

  @override
  State<PrivacyPages> createState() => _PrivacyPagesState();
}

class _PrivacyPagesState extends State<PrivacyPages> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
          title: const Text('ຂໍ້ກໍານົດ ແລະ ນະໂຍບາຍ'),
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                '1. ການເກັບຮັກຂໍ້ມູນ',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              SizedBox(height: 8),
              Text(
                'ແອັບພລິເຄຊັນຈະເກັບຂໍ້ມູນສ່ວນຕົວເທົ່າທີ່ຈໍາເປັນ ເພື່ອປະສົງການໃຊ້ງານແລະການບໍລິການ.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 16),
              Text(
                '2. ການນໍາໃຊ້ຂໍ້ມູນ',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              SizedBox(height: 8),
              Text(
                'ຂໍ້ມູນທີ່ໄດ້ຖືກເກັບຈະຖືກນໍາໃຊ້ໃນການພັດທະນາແລະປັບປຸງບໍລິການ.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 16),
              Text(
                '3. ການແບ່ງປັນຂໍ້ມູນ',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              SizedBox(height: 8),
              Text(
                'ຂໍ້ມູນຂອງທ່ານຈະບໍ່ຖືກແບ່ງປັນໃຫ້ຜູ້ອື່ນ ນອກຈາກໃນກໍລະນີທີ່ມີກົດໝາຍກໍານົດ.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 16),
              Text(
                '4. ການປ້ອງກັນຂໍ້ມູນ',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              SizedBox(height: 8),
              Text(
                'ແອັບພລິເຄຊັນໄດ້ດໍາເນີນມາດຕະການຄວາມປອດໄພເພື່ອປົກປ້ອງຂໍ້ມູນສ່ວນຕົວຂອງທ່ານ.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 16),
              Text(
                '5. ການປັບປຸງຂໍ້ກໍານົດ',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              SizedBox(height: 8),
              Text(
                'ເຮົາອາດປັບປຸງນະໂຍບາຍນີ້ໃນອະນາຄົດ ກະລຸນາກວດເບິ່ງໃຫ້ທັນສະໄໝ.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
