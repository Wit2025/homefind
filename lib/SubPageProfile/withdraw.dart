import 'package:flutter/material.dart';

class WithdrawPages extends StatefulWidget {
  const WithdrawPages({super.key});

  @override
  State<WithdrawPages> createState() => _WithdrawPagesState();
}

class _WithdrawPagesState extends State<WithdrawPages> {
  final TextEditingController _amountController = TextEditingController(
    text: '',
  );

  final double _availableBalance = 458.78;

  String? _selectedAccountId = '4327';

  final List<Map<String, String>> _accounts = [
    {'id': '4327', 'name': 'ບັນຊີທະນາຄານ', 'number': '•• •••• •••• 4327'},
  ];

  void _submitWithdrawal() {
    if (_amountController.text.trim().isEmpty || _selectedAccountId == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('ກະລຸນາປ້ອນຂໍ້ມູນໃຫ້ຄົບ')));
      return;
    }

    final selected = _accounts.firstWhere(
      (a) => a['id'] == _selectedAccountId,
      orElse: () => {},
    );

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'ຖອນ \$${_amountController.text} ໄປ ${selected['name']} (${selected['number']})',
        ),
      ),
    );
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
          title: const Text('ຖອນເງິນ'),
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
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            const SizedBox(height: 20),

            Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width * 0.8,
                ),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'ປ້ອນຈຳນວນ',
                        style: TextStyle(fontSize: 14, color: Colors.black),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 8),
            Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width * 0.8,
                ),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _amountController,
                          keyboardType: const TextInputType.numberWithOptions(
                            decimal: true,
                          ),
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            isDense: true,
                            hintText: '0.00 ກີບ',
                            hintStyle: TextStyle(
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF00CEB0),
                            ),
                          ),
                          maxLines: 1,
                          scrollPhysics: const BouncingScrollPhysics(),
                          onChanged: (value) {
                            // Format the number with thousand separators
                            _formatNumber(value);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 8),

            Text(
              '$_availableBalance ກີບ',
              style: const TextStyle(color: Colors.black, fontSize: 16),
            ),
            const Text(
              'ຍອດເງິນ',
              style: TextStyle(color: Colors.black, fontSize: 12),
            ),

            const SizedBox(height: 32),

            // Title
            Row(
              children: [
                const Icon(
                  Icons.account_balance_wallet_outlined,
                  size: 20,
                  color: Color(0xFF00CEB0),
                ),
                const SizedBox(width: 8),
                const Text('ຖອນເງິນໄປບັນຊີ', style: TextStyle(fontSize: 16)),
                const Spacer(),
                TextButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.add, size: 16),
                  label: const Text(
                    'ເພີ່ມບັນຊີ',
                    style: TextStyle(fontSize: 14),
                  ),
                  style: TextButton.styleFrom(
                    foregroundColor: Color(0xFF00CEB0),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Account list with radio
            ..._accounts.map((account) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedAccountId = account['id'];
                  });
                },
                child: Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: _selectedAccountId == account['id']
                          ? Color(0xFF00CEB0)
                          : Colors.grey.shade300,
                      width: 1.5,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    children: [
                      Icon(
                        account['name']?.contains('E-Wallet') == true
                            ? Icons.account_balance_wallet
                            : Icons.account_balance,
                        size: 30,
                        color: Color.fromARGB(255, 12, 105, 122),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              account['name'] ?? '',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              account['number'] ?? '',
                              style: const TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                      Radio<String>(
                        value: account['id']!,
                        groupValue: _selectedAccountId,
                        onChanged: (value) {
                          setState(() {
                            _selectedAccountId = value;
                          });
                        },
                        activeColor: Colors.blue,
                      ),
                    ],
                  ),
                ),
              );
            }),

            const Spacer(),

            // Confirm button
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: _submitWithdrawal,
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.zero,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  backgroundColor: Colors.transparent, // ให้พื้นหลังโปร่งใส
                  shadowColor: Colors.transparent,
                ),
                child: Ink(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color.fromARGB(255, 87, 167, 177),
                        const Color.fromARGB(255, 12, 105, 122),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Container(
                    alignment: Alignment.center,
                    child: const Text(
                      'ຢືນຢັນການຖອນເງິນ',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  void _formatNumber(String value) {
    if (value.isEmpty) return;

    // Remove all non-digit characters except decimal point
    String cleanValue = value.replaceAll(RegExp(r'[^0-9.]'), '');

    // Handle multiple decimal points
    if (cleanValue.split('.').length > 2) {
      cleanValue = cleanValue.substring(0, cleanValue.length - 1);
    }

    // Split into whole and decimal parts
    List<String> parts = cleanValue.split('.');
    String wholePart = parts[0];
    String decimalPart = parts.length > 1 ? '.${parts[1]}' : '';

    // Add thousand separators
    String formatted = '';
    for (int i = 0; i < wholePart.length; i++) {
      if ((wholePart.length - i) % 3 == 0 && i != 0) {
        formatted += ',';
      }
      formatted += wholePart[i];
    }

    // Update the controller
    _amountController.value = TextEditingValue(
      text: '$formatted$decimalPart ກີບ',
      selection: TextSelection.collapsed(
        offset: '$formatted$decimalPart'.length,
      ),
    );
  }
}
