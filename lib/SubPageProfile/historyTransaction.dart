import 'package:flutter/material.dart';

class HistoryTransaction extends StatefulWidget {
  const HistoryTransaction({super.key});

  @override
  State<HistoryTransaction> createState() => _HistoryTransactionState();
}

class _HistoryTransactionState extends State<HistoryTransaction> {
  final List<Map<String, dynamic>> _allTransactions = [
    {
      'date': '2023-10-15 14:30',
      'amount': '150.00',
      'account': '•••• 4327',
      'status': 'ສຳເລັດ',
      'type': 'withdrawal',
      'transaction_id': 'TX12345678',
      'fee': '5.00',
      'method': 'ບັນຊີທະນາຄານ',
    },
    {
      'date': '2023-10-10 09:15',
      'amount': '200.00',
      'account': '20 ••••',
      'status': 'ສຳເລັດ',
      'type': 'withdrawal',
      'transaction_id': 'TX87654321',
      'fee': '5.00',
      'method': 'ບັນຊີທະນາຄານ',
    },
    {
      'date': '2023-10-05 16:45',
      'amount': '75.50',
      'account': '•••• 4327',
      'status': 'ຍົກເລີກ',
      'type': 'withdrawal',
      'transaction_id': 'TX13579246',
      'fee': '0.00',
      'method': 'ບັນຊີທະນາຄານ',
    },
    {
      'date': '2023-09-28 11:20',
      'amount': '300.00',
      'account': '20 ••••',
      'status': 'ສຳເລັດ',
      'type': 'withdrawal',
      'transaction_id': 'TX24681357',
      'fee': '5.00',
      'method': 'ບັນຊີທະນາຄານ',
    },
    {
      'date': '2023-09-20 10:10',
      'amount': '100.00',
      'account': '•••• 4327',
      'status': 'ລໍຖ້າຢືນຢັນ',
      'type': 'withdrawal',
      'transaction_id': 'TX98765432',
      'fee': '5.00',
      'method': 'ບັນຊີທະນາຄານ',
    },
  ];

  String? _selectedFilter;

  List<Map<String, dynamic>> get _filteredTransactions {
    if (_selectedFilter == null) {
      return _allTransactions;
    }
    return _allTransactions
        .where((t) => t['status'] == _selectedFilter)
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

  void _showTransactionDetails(Map<String, dynamic> transaction) {
    showDialog(
      context: context,
      builder: (context) => TransactionDetailDialog(transaction: transaction),
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
          title: const Text('ປະຫວັດການຖອນເງິນ'),
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
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
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

          // Transaction list
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: _filteredTransactions.length,
              separatorBuilder: (context, index) => const Divider(height: 1),
              itemBuilder: (context, index) {
                final transaction = _filteredTransactions[index];
                return GestureDetector(
                  onTap: () => _showTransactionDetails(transaction),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(vertical: 8),
                    leading: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: const Color(0xFF00CEB0).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(
                        transaction['method'] == 'E-Wallet'
                            ? Icons.account_balance_wallet
                            : Icons.account_balance,
                        color: const Color(0xFF006B8B),
                        size: 30,
                      ),
                    ),
                    title: Row(
                      children: [
                        Text(
                          '-${transaction['amount']} ກີບ',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: _getStatusColor(
                              transaction['status'],
                            ).withOpacity(0.2),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: _getStatusColor(transaction['status']),
                              width: 1,
                            ),
                          ),
                          child: Text(
                            transaction['status'],
                            style: TextStyle(
                              fontSize: 10,
                              color: _getStatusColor(transaction['status']),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 4),
                        Text(
                          transaction['account'],
                          style: const TextStyle(color: Colors.grey),
                        ),
                        Text(
                          transaction['date'],
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                    trailing: const Icon(
                      Icons.chevron_right,
                      color: Colors.grey,
                    ),
                  ),
                );
              },
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
        constraints: const BoxConstraints(minWidth: 70),
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

class TransactionDetailDialog extends StatelessWidget {
  final Map<String, dynamic> transaction;

  const TransactionDetailDialog({super.key, required this.transaction});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 0,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'ລາຍລະອຽດການຖອນເງິນ',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[800],
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close, color: Colors.grey),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Divider
            Container(
              height: 1,
              color: Colors.grey[200],
              margin: const EdgeInsets.symmetric(vertical: 8),
            ),

            // Content
            _buildDetailRow('ຈຳນວນເງິນ', '-${transaction['amount']} ກີບ'),
            _buildDetailRow('ວິທີຖອນ', transaction['method']),
            _buildDetailRow('ບັນຊີປາຍທາງ', transaction['account']),
            _buildDetailRow('ຄ່າທຳນຽມ', '${transaction['fee']} ກີບ'),
            _buildDetailRow('ລະຫັດທຸລະກຳ', transaction['transaction_id']),
            _buildDetailRow('ວັນທີ່', transaction['date']),
            _buildDetailRow(
              'ສະຖານະ',
              transaction['status'],
              statusColor: _getStatusColor(transaction['status']),
            ),

            const SizedBox(height: 24),

            // Close button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.zero, // Remove default padding
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  backgroundColor:
                      Colors.transparent, // Make button background transparent
                  shadowColor: Colors.transparent, // Remove shadow
                ),
                child: Ink(
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF00CEB0), Color(0xFF006B8B)],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    alignment: Alignment.center,
                    child: const Text(
                      'ປິດ',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value, {Color? statusColor}) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 120,
              child: Text(
                label,
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                value,
                style: TextStyle(
                  color: statusColor ?? Colors.grey[800],
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
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
}
