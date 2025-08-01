import 'package:flutter/material.dart';

class LanguegePages extends StatefulWidget {
  const LanguegePages({super.key});

  @override
  State<LanguegePages> createState() => _LanguegePagesState();
}

class _LanguegePagesState extends State<LanguegePages> {
  String _selectedLanguage = 'lo';

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
          title: const Text('ປ່ຽນພາສາ'),
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
      body: ListView(
        padding: const EdgeInsets.only(bottom: 80),
        children: [
          const SizedBox(height: 20),
          RadioListTile<String>(
            title: const Text('ລາວ (Lao)'),
            value: 'lo',
            groupValue: _selectedLanguage,
            onChanged: (value) {
              setState(() {
                _selectedLanguage = value!;
              });
            },
            secondary: Image.asset('images/lao.png', width: 32, height: 32),
          ),
          Divider(),
          RadioListTile<String>(
            title: const Text('English'),
            value: 'en',
            groupValue: _selectedLanguage,
            onChanged: (value) {
              setState(() {
                _selectedLanguage = value!;
              });
            },
            secondary: Image.asset('images/en.png', width: 32, height: 32),
          ),
          Divider(),
          RadioListTile<String>(
            title: const Text('中文 (Chinese)'),
            value: 'zh',
            groupValue: _selectedLanguage,
            onChanged: (value) {
              setState(() {
                _selectedLanguage = value!;
              });
            },
            secondary: Image.asset('images/ch.png', width: 32, height: 32),
          ),
          Divider(),
          RadioListTile<String>(
            title: const Text('한국어 (Korean)'),
            value: 'ko',
            groupValue: _selectedLanguage,
            onChanged: (value) {
              setState(() {
                _selectedLanguage = value!;
              });
            },
            secondary: Image.asset('images/ko.png', width: 32, height: 32),
          ),
        ],
      ),
    );
  }
}
