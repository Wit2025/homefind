import 'package:flutter/material.dart';
import 'package:homefind/%E0%B9%87Home/Homes.dart';
import 'package:homefind/Pages/AddPages.dart';
import 'package:homefind/Pages/JoinPages.dart';
import 'package:homefind/Pages/notification.dart';
import 'package:homefind/Pages/profile.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  void _changePage(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();

    _pages = [
      HomePage(),
      JoinPages(
        onGoToAddPage: () {
          setState(() {
            _currentIndex = 2;
          });
        },
      ),
      AddPage(),
      NotificationsBody(),
      ProfilePage(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) async {
            if (index == 2) {
              final prefs = await SharedPreferences.getInstance();
              bool accepted = prefs.getBool('terms_accepted') ?? false;

              if (!accepted) {
                _changePage(1);
                return;
              }
            }
            _changePage(index);
          },
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          selectedItemColor: Colors.teal,
          unselectedItemColor: Colors.grey,
          elevation: 0,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'ໜ້າຫຼັກ'),
            BottomNavigationBarItem(
              icon: Icon(Icons.join_full),
              label: 'ເຂົ້າຮ່ວມ',
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: EdgeInsets.all(8),
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: Colors.teal,
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                  ),
                  child: Icon(Icons.add, color: Colors.white, size: 24),
                ),
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.notifications),
              label: 'ແຈ້ງເຕືອນ',
            ),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'ໂປຟາຍ'),
          ],
        ),
      ),
    );
  }
}
