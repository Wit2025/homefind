import 'package:flutter/material.dart';

class HistoryBookingPages extends StatefulWidget {
  const HistoryBookingPages({super.key});

  @override
  State<HistoryBookingPages> createState() => _HistoryBookingPagesState();
}

class _HistoryBookingPagesState extends State<HistoryBookingPages> {
  final List<Map<String, String>> allBookings = [
    {
      'title': 'ອະພາດເມັນ',
      'date': '10 ກໍລະກົດ 2025',
      'location': 'ນະຄອນຫຼວງ ເວຽງຈັນ',
      'image': 'images/house.jpg',
      'price': '50,000 ກີບ',
      'status': 'ສຳເລັດ',
    },
    {
      'title': 'ຫ້ອງແຖວແຊຫ້ອງ',
      'date': '25 ມິຖຸນາ 2025',
      'location': 'ໄຊຍະບູລີ',
      'image': 'images/house.jpg',
      'price': '50,000 ກີບ',
      'status': 'ລໍຖ້າຢືນຢັນ',
    },
    {
      'title': 'ເຮືອນ 2 ຊັ້ນ',
      'date': '15 ພຶດສະພາ 2025',
      'location': 'ເຊກອງ',
      'image': 'images/house.jpg',
      'price': '50,000 ກີບ',
      'status': 'ຍົກເລີກ',
    },
    {
      'title': 'ວີລ້າ ສະຫງວນ',
      'date': '5 ມິຖຸນາ 2025',
      'location': 'ຫຼວງພະບາງ',
      'image': 'images/house.jpg',
      'price': '75,000 ກີບ',
      'status': 'ສຳເລັດ',
    },
    {
      'title': 'ໂຮງແຮມດີສະຫຼາດ',
      'date': '30 ພຶດສະພາ 2025',
      'location': 'ຈຳປາສັກ',
      'image': 'images/house.jpg',
      'price': '60,000 ກີບ',
      'status': 'ລໍຖ້າຢືນຢັນ',
    },
    {
      'title': 'ອະພາດເມັນ',
      'date': '10 ກໍລະກົດ 2025',
      'location': 'ນະຄອນຫຼວງ ເວຽງຈັນ',
      'image': 'images/house.jpg',
      'price': '50,000 ກີບ',
      'status': 'ສຳເລັດ',
    },
    {
      'title': 'ຫ້ອງແຖວແຊຫ້ອງ',
      'date': '25 ມິຖຸນາ 2025',
      'location': 'ໄຊຍະບູລີ',
      'image': 'images/house.jpg',
      'price': '50,000 ກີບ',
      'status': 'ລໍຖ້າຢືນຢັນ',
    },
    {
      'title': 'ເຮືອນ 2 ຊັ້ນ',
      'date': '15 ພຶດສະພາ 2025',
      'location': 'ເຊກອງ',
      'image': 'images/house.jpg',
      'price': '50,000 ກີບ',
      'status': 'ຍົກເລີກ',
    },
    {
      'title': 'ວີລ້າ ສະຫງວນ',
      'date': '5 ມິຖຸນາ 2025',
      'location': 'ຫຼວງພະບາງ',
      'image': 'images/house.jpg',
      'price': '75,000 ກີບ',
      'status': 'ສຳເລັດ',
    },
    {
      'title': 'ໂຮງແຮມດີສະຫຼາດ',
      'date': '30 ພຶດສະພາ 2025',
      'location': 'ຈຳປາສັກ',
      'image': 'images/house.jpg',
      'price': '60,000 ກີບ',
      'status': 'ລໍຖ້າຢືນຢັນ',
    },
    {
      'title': 'ອະພາດເມັນ',
      'date': '10 ກໍລະກົດ 2025',
      'location': 'ນະຄອນຫຼວງ ເວຽງຈັນ',
      'image': 'images/house.jpg',
      'price': '50,000 ກີບ',
      'status': 'ສຳເລັດ',
    },
    {
      'title': 'ຫ້ອງແຖວແຊຫ້ອງ',
      'date': '25 ມິຖຸນາ 2025',
      'location': 'ໄຊຍະບູລີ',
      'image': 'images/house.jpg',
      'price': '50,000 ກີບ',
      'status': 'ລໍຖ້າຢືນຢັນ',
    },
    {
      'title': 'ເຮືອນ 2 ຊັ້ນ',
      'date': '15 ພຶດສະພາ 2025',
      'location': 'ເຊກອງ',
      'image': 'images/house.jpg',
      'price': '50,000 ກີບ',
      'status': 'ຍົກເລີກ',
    },
    {
      'title': 'ວີລ້າ ສະຫງວນ',
      'date': '5 ມິຖຸນາ 2025',
      'location': 'ຫຼວງພະບາງ',
      'image': 'images/house.jpg',
      'price': '75,000 ກີບ',
      'status': 'ສຳເລັດ',
    },
    {
      'title': 'ໂຮງແຮມດີສະຫຼາດ',
      'date': '30 ພຶດສະພາ 2025',
      'location': 'ຈຳປາສັກ',
      'image': 'images/house.jpg',
      'price': '60,000 ກີບ',
      'status': 'ລໍຖ້າຢືນຢັນ',
    },
  ];

  String? _selectedFilter;
  List<Map<String, String>> get _filteredBookings {
    if (_selectedFilter == null || _selectedFilter == 'ທັງໝົດ') {
      return allBookings;
    }
    return allBookings
        .where((booking) => booking['status'] == _selectedFilter)
        .toList();
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'ສຳເລັດ':
        return Colors.green;
      case 'ລໍຖ້າຢືນຢັນ':
        return Colors.orange;
      case 'ຍົກເລີກ':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

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
          title: const Text('ປະຫວັດການຈອງ'),
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
          // Filter buttons
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _buildFilterButton('ທັງໝົດ', null),
                  const SizedBox(width: 8),
                  _buildFilterButton('ສຳເລັດ', 'ສຳເລັດ'),
                  const SizedBox(width: 8),
                  _buildFilterButton('ລໍຖ້າ', 'ລໍຖ້າຢືນຢັນ'),
                  const SizedBox(width: 8),
                  _buildFilterButton('ຍົກເລີກ', 'ຍົກເລີກ'),
                ],
              ),
            ),
          ),

          // Booking list
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: GridView.builder(
                itemCount: _filteredBookings.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 0.85,
                ),
                itemBuilder: (context, index) {
                  final booking = _filteredBookings[index];
                  return Card(
                    elevation: 1,
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(12),
                            topRight: Radius.circular(12),
                          ),
                          child: Image.asset(
                            booking['image']!,
                            width: double.infinity,
                            height: 100,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Expanded(
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: Padding(
                              padding: const EdgeInsets.all(8),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          booking['title']!,
                                          style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 4),
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 6,
                                          vertical: 2,
                                        ),
                                        decoration: BoxDecoration(
                                          color: _getStatusColor(
                                            booking['status']!,
                                          ).withOpacity(0.2),
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                          border: Border.all(
                                            color: _getStatusColor(
                                              booking['status']!,
                                            ),
                                            width: 1,
                                          ),
                                        ),
                                        child: Text(
                                          booking['status']!,
                                          style: TextStyle(
                                            fontSize: 10,
                                            color: _getStatusColor(
                                              booking['status']!,
                                            ),
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 4),
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.location_on,
                                        size: 14,
                                        color: Colors.grey,
                                      ),
                                      const SizedBox(width: 4),
                                      Expanded(
                                        child: Text(
                                          booking['location']!,
                                          style: const TextStyle(
                                            fontSize: 12,
                                            color: Colors.grey,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 4),
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.calendar_today,
                                        size: 14,
                                        color: Colors.grey,
                                      ),
                                      const SizedBox(width: 4),
                                      Text(
                                        booking['date']!,
                                        style: const TextStyle(
                                          fontSize: 12,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    booking['price'] ?? '',
                                    style: const TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF006B8B),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterButton(String label, String? status) {
    final isSelected = _selectedFilter == status;
    return OutlinedButton(
      onPressed: () {
        setState(() {
          _selectedFilter = status;
        });
      },
      style: OutlinedButton.styleFrom(
        padding: EdgeInsets.zero,
        minimumSize: Size.zero,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        backgroundColor: isSelected ? null : Colors.white,
        side: BorderSide(color: isSelected ? Colors.transparent : Colors.grey),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
      child: Container(
        constraints: BoxConstraints(minWidth: 70),
        decoration: isSelected
            ? BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF00CEB0), Color(0xFF006B8B)],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
                borderRadius: BorderRadius.circular(20),
              )
            : null,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
        ),
      ),
    );
  }
}
