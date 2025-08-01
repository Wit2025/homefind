import 'package:flutter/material.dart';

class HelpPages extends StatefulWidget {
  const HelpPages({super.key});

  @override
  State<HelpPages> createState() => _HelpPagesState();
}

class _HelpPagesState extends State<HelpPages> {
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
          title: const Text('ຊ່ວຍເຫຼືອ'),
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

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: 'ຊອກຫາຄຳຖາມ...',
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.grey[200],
                contentPadding: const EdgeInsets.symmetric(vertical: 12.0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 24),

            _buildHelpItem(
              icon: Icons.lock,
              title: 'ປັນຫາການເຂົ້າລະບົບ',
              subtitle: 'ລືມລະຫັດຜ່ານ ຫຼື ບັນຊີຖືກລັອກ',
            ),
            const SizedBox(height: 16),
            _buildHelpItem(
              icon: Icons.account_circle,
              title: 'ຈັດການບັນຊີ',
              subtitle: 'ປ່ຽນຂໍ້ມູນສ່ວນຕົວ ຫຼື ລຶບບັນຊີ',
            ),
            const SizedBox(height: 16),
            _buildHelpItem(
              icon: Icons.shopping_cart,
              title: 'ຄຳສັ່ງຊື້ & ການຊຳລະເງິນ',
              subtitle: 'ກວດສອບການຊື້ ຫຼື ຄືນເງິນ',
            ),
            const SizedBox(height: 16),
            _buildHelpItem(
              icon: Icons.privacy_tip,
              title: 'ຄວາມປອດໄພ & ຄວາມເປັນສ່ວນໂຕ',
              subtitle: 'ກ່ຽວກັບນະໂຍບາຍຂໍ້ມູນ',
            ),
            const SizedBox(height: 32),

            Center(
              child: ElevatedButton.icon(
                onPressed: () {
                  // TODO: contact support
                },
                label: const Text('ຕິດຕໍ່ຝ່າຍຊ່ວຍເຫຼືອ'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF00CEB0),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    vertical: 14,
                    horizontal: 24,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 12,
                  horizontal: 20,
                ),
                decoration: BoxDecoration(
                  color: Color(0xFFF0F0F0),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Color(0xFF00CEB0), width: 1.5),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Icon(Icons.phone, color: Color(0xFF00CEB0)),
                    SizedBox(width: 10),
                    Text(
                      '209747xxxx',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHelpItem({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return Material(
      color: Colors.grey[100],
      borderRadius: BorderRadius.circular(12),
      child: ListTile(
        leading: Icon(icon, color: const Color(0xFF00CEB0)),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: () {
          // TODO: go to detail help page
        },
      ),
    );
  }
}
