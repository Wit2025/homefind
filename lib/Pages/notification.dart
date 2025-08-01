import 'package:flutter/material.dart';

class NotificationsBody extends StatefulWidget {
  const NotificationsBody({super.key});

  @override
  State<NotificationsBody> createState() => _NotificationsBodyState();
}

class _NotificationsBodyState extends State<NotificationsBody> {
  String _selectedTab = 'ອ່ານແລ້ວ'; // State to manage the active tab

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
          title: const Text('ການແຈ້ງເຕືອນ'),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.white,
          elevation: 0,
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 20),
            // Header Container
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 5.0),
              padding: const EdgeInsets.all(
                2.0,
              ), // This will be the border thickness
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
                gradient: LinearGradient(
                  colors: [
                    Color.fromARGB(255, 87, 167, 177),
                    const Color.fromARGB(255, 12, 105, 122),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    blurRadius: 50,
                    blurStyle: BlurStyle.inner,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 10.0,
                  horizontal: 20.0,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(
                    13.0,
                  ), // Slightly smaller than outer radius
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildTabButton('ອ່ານແລ້ວ'),
                    const SizedBox(width: 10),
                    Container(
                      width: 5,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      margin: const EdgeInsets.symmetric(horizontal: 8.0),
                    ),
                    const SizedBox(width: 10),
                    _buildTabButton('ຍັງບໍ່ອ່ານ'),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                children: [
                  _buildNotificationItem(
                    'ທອງດີ ສີສະຫວັດ',
                    'ໄດ້ເອີ่ຍເຖິງທ່ານໃນເນື້ອຫາຫຼັກ',
                    '4 ມື້ຜ່ານໄປ',
                  ),
                  _buildNotificationItem(
                    'ແສງຈັນ ສອນງາມ',
                    'ໄດ້ຄອມເມນ: "ສົນໃຈ"',
                    '5 ມື້ຜ່ານໄປ',
                  ),
                  _buildNotificationItem(
                    'ທ່ານມີຄໍາຮ້ອງຂໍຮ່ວມມືທີ່ໃຫ້ຕອບກັບ!',
                    '',
                    '5 ມື້ຜ່ານໄປ',
                  ),
                  _buildNotificationItem(
                    'ບຸນມີ ອຸໄລພອນ',
                    'ສະແດງຄວາມສົນໃຈໃນໂພສຂອງທ່ານ',
                    '6 ມື້ຜ່ານໄປ',
                  ),
                  _buildNotificationItem(
                    'ແກ້ວມະນີ ສີສຸກ',
                    'ໄດ້ຕິດຕາມທ່ານ',
                    '7 ມື້ຜ່ານໄປ',
                  ),
                  _buildNotificationItem(
                    'ທອງດີ ສີສະຫວັດ',
                    'ໄດ້ເອີ่ຍເຖິງທ່ານໃນເນື້ອຫາຫຼັກ',
                    '4 ມື້ຜ່ານໄປ',
                  ),
                  _buildNotificationItem(
                    'ແສງຈັນ ສອນງາມ',
                    'ໄດ້ຄອມເມນ: "ສົນໃຈ"',
                    '5 ມື້ຜ່ານໄປ',
                  ),
                  _buildNotificationItem(
                    'ທ່ານມີຄໍາຮ້ອງຂໍຮ່ວມມືທີ່ໃຫ້ຕອບກັບ!',
                    '',
                    '5 ມື້ຜ່ານໄປ',
                  ),
                  _buildNotificationItem(
                    'ບຸນມີ ອຸໄລພອນ',
                    'ສະແດງຄວາມສົນໃຈໃນໂພສຂອງທ່ານ',
                    '6 ມື້ຜ່ານໄປ',
                  ),
                  _buildNotificationItem(
                    'ແກ້ວມະນີ ສີສຸກ',
                    'ໄດ້ຕິດຕາມທ່ານ',
                    '7 ມື້ຜ່ານໄປ',
                  ),
                  _buildNotificationItem(
                    'ທອງດີ ສີສະຫວັດ',
                    'ໄດ້ເອີ่ຍເຖິງທ່ານໃນເນື້ອຫາຫຼັກ',
                    '4 ມື້ຜ່ານໄປ',
                  ),
                  _buildNotificationItem(
                    'ແສງຈັນ ສອນງາມ',
                    'ໄດ້ຄອມເມນ: "ສົນໃຈ"',
                    '5 ມື້ຜ່ານໄປ',
                  ),
                  _buildNotificationItem(
                    'ທ່ານມີຄໍາຮ້ອງຂໍຮ່ວມມືທີ່ໃຫ້ຕອບກັບ!',
                    '',
                    '5 ມື້ຜ່ານໄປ',
                  ),
                  _buildNotificationItem(
                    'ບຸນມີ ອຸໄລພອນ',
                    'ສະແດງຄວາມສົນໃຈໃນໂພສຂອງທ່ານ',
                    '6 ມື້ຜ່ານໄປ',
                  ),
                  _buildNotificationItem(
                    'ແກ້ວມະນີ ສີສຸກ',
                    'ໄດ້ຕິດຕາມທ່ານ',
                    '7 ມື້ຜ່ານໄປ',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabButton(String tabName) {
    bool isSelected = _selectedTab == tabName;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedTab = tabName;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected
              ? const Color(0xFFE0BBE4)
              : const Color.fromARGB(63, 221, 221, 221),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          tabName,
          style: TextStyle(
            color: isSelected
                ? const Color(0xFF6A0DAD)
                : Colors.grey[700], // Darker purple for selected text
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }

  Widget _buildNotificationItem(String title, String subtitle, String timeAgo) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.15),
            blurRadius: 2,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Avatar/Icon
          CircleAvatar(
            radius: 24,
            backgroundColor: const Color.fromARGB(255, 241, 241, 241),
            child: const Icon(Icons.notifications_on, color: Colors.teal),
          ),
          const SizedBox(width: 12),
          // Text content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                    color: Colors.black87,
                  ),
                ),
                if (subtitle.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(
                      subtitle,
                      style: const TextStyle(
                        color: Colors.black54,
                        fontSize: 13,
                      ),
                    ),
                  ),
                Padding(
                  padding: const EdgeInsets.only(top: 6),
                  child: Text(
                    timeAgo,
                    style: const TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
