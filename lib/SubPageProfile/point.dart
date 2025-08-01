import 'package:flutter/material.dart';

class PointPages extends StatefulWidget {
  const PointPages({super.key});

  @override
  State<PointPages> createState() => _PointPagesState();
}

class _PointPagesState extends State<PointPages> {
  int totalPoints = 1200;
  List<Map<String, dynamic>> pointHistory = [
    {"date": "2025-07-30", "description": "ໄດ້ຈາກການເຊົາ ...", "points": 100},
    {"date": "2025-07-29", "description": "ແນະນຳເພື່ອນ", "points": 200},
    {"date": "2025-07-28", "description": "ໄດ້ຈາກການເຊົາ ...", "points": 300},
    {"date": "2025-07-27", "description": "ໄດ້ຈາກການເຊົາ ...", "points": 600},
  ];

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
          title: const Text('ຄະແນນ'),
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
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(
              vertical: 20,
              horizontal: 16,
            ), // เพิ่ม horizontal margin 16
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromARGB(255, 87, 167, 177),
                  const Color.fromARGB(255, 12, 105, 122),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                Center(
                  // ใช้ Center widget เพื่อจัดกึ่งกลาง
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Text(
                      '$totalPoints ຄະແນນ',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // History title
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            child: Row(
              children: [
                const Icon(Icons.history, color: Color(0xFF006B8B)),
                const SizedBox(width: 8),
                const Text(
                  'ປະຫວັດຄະແນນ',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF006B8B),
                  ),
                ),
                const Spacer(),
                TextButton(
                  onPressed: () {},
                  child: const Text(
                    'ທັງໝົດ',
                    style: TextStyle(color: Color(0xFF00CEB0)),
                  ),
                ),
              ],
            ),
          ),

          // Points history list
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              itemCount: pointHistory.length,
              separatorBuilder: (context, index) =>
                  Divider(height: 1, color: Colors.grey[200], indent: 60),
              itemBuilder: (context, index) {
                final item = pointHistory[index];
                return ListTile(
                  contentPadding: const EdgeInsets.symmetric(vertical: 8),
                  leading: Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: const Color(0xFF006B8B).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: Text(
                        '+${item['points']}',
                        style: const TextStyle(
                          color: Color(0xFF006B8B),
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  title: Text(
                    item['description'],
                    style: const TextStyle(fontWeight: FontWeight.w500),
                  ),
                  subtitle: Text(
                    item['date'],
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                  trailing: const Icon(Icons.chevron_right, color: Colors.grey),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
