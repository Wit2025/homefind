import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:homefind/%E0%B9%87Home/MainScreen.dart';
import 'package:homefind/SubPageProfile/ChangePassword.dart';
import 'package:homefind/SubPageProfile/Help.dart';
import 'package:homefind/SubPageProfile/HistoryBooking.dart';
import 'package:homefind/SubPageProfile/Languege.dart';
import 'package:homefind/SubPageProfile/MyAccount.dart';
import 'package:homefind/SubPageProfile/Privacy.dart';
import 'package:homefind/SubPageProfile/historyTransaction.dart';
import 'package:homefind/SubPageProfile/point.dart';
import 'package:homefind/SubPageProfile/withdraw.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Future<void> logout(BuildContext context) async {
    await showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: '',
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (_, animation, secondaryAnimation) {
        return ScaleTransition(
          scale: CurvedAnimation(parent: animation, curve: Curves.easeOutBack),
          child: AlertDialog(
            backgroundColor: Colors.transparent,
            elevation: 0,
            contentPadding: EdgeInsets.zero,
            content: Container(
              padding: const EdgeInsets.all(25),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xFF00CEB0), Color(0xFF006B8B)],
                ),
                borderRadius: BorderRadius.circular(25),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 20,
                    spreadRadius: 5,
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Animated icon
                  RotationTransition(
                    turns: Tween(begin: 0.0, end: 0.25).animate(
                      CurvedAnimation(
                        parent: animation,
                        curve: Curves.elasticOut,
                      ),
                    ),
                    child: Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.exit_to_app,
                        size: 40,
                        color: Colors.white,
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Title with fade animation
                  FadeTransition(
                    opacity: animation,
                    child: const Text(
                      'ອອກຈາກລະບົບ',
                      style: TextStyle(
                        fontFamily: 'NotoSansLao',
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),

                  const SizedBox(height: 15),

                  // Message with slide animation
                  SlideTransition(
                    position: Tween<Offset>(
                      begin: const Offset(0, 0.5),
                      end: Offset.zero,
                    ).animate(animation),
                    child: const Text(
                      'ທ່ານໝັ້ນໃຈບໍວ່າຕ້ອງການອອກຈາກລະບົບ?',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'NotoSansLao',
                        fontSize: 16,
                        color: Colors.white,
                        height: 1.5,
                      ),
                    ),
                  ),

                  const SizedBox(height: 25),

                  // Buttons row with staggered animation
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Cancel button
                      ScaleTransition(
                        scale: Tween(begin: 0.7, end: 1.0).animate(
                          CurvedAnimation(
                            parent: animation,
                            curve: const Interval(
                              0.4,
                              1.0,
                              curve: Curves.easeOutBack,
                            ),
                          ),
                        ),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 25,
                              vertical: 12,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            elevation: 3,
                          ),
                          onPressed: () => Navigator.of(context).pop(),
                          child: const Text(
                            'ຍົກເລີກ',
                            style: TextStyle(
                              fontFamily: 'NotoSansLao',
                              color: Color(0xFF006B8B),
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(width: 15),

                      // Confirm button
                      ScaleTransition(
                        scale: Tween(begin: 0.7, end: 1.0).animate(
                          CurvedAnimation(
                            parent: animation,
                            curve: const Interval(
                              0.6,
                              1.0,
                              curve: Curves.easeOutBack,
                            ),
                          ),
                        ),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red[400],
                            padding: const EdgeInsets.symmetric(
                              horizontal: 25,
                              vertical: 12,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            elevation: 3,
                          ),
                          onPressed: () async {
                            final prefs = await SharedPreferences.getInstance();
                            await prefs.remove('isLoggedIn');

                            // Add haptic feedback
                            HapticFeedback.mediumImpact();

                            Navigator.of(context).pop();
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MainScreen(),
                              ),
                            );
                          },
                          child: const Text(
                            'ອອກຈາກລະບົບ',
                            style: TextStyle(
                              fontFamily: 'NotoSansLao',
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 87, 167, 177),
              Color.fromARGB(255, 12, 105, 122),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Column(
                children: [
                  const SizedBox(height: 140),
                  Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 150),
                          Container(
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  spreadRadius: 2,
                                  blurRadius: 2,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    _buildIncomeExpenseItem(
                                      Icons.arrow_upward,
                                      'ລາຍໄດ້',
                                      '3,214 ກີບ',
                                      Colors.green,
                                    ),
                                    const SizedBox(width: 10),
                                    Container(
                                      width: 5,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        color: Colors.grey.shade300,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      margin: const EdgeInsets.symmetric(
                                        horizontal: 8.0,
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    _buildIncomeExpenseItem(
                                      Icons.arrow_downward,
                                      'ຄ່າທຳນຽມ',
                                      '1,640 ກິບ',
                                      Colors.red,
                                    ),
                                  ],
                                ),

                                const SizedBox(height: 10),
                                Container(
                                  margin: const EdgeInsets.symmetric(
                                    vertical: 10,
                                  ),
                                  height: 4,
                                  decoration: BoxDecoration(
                                    color: Colors.grey.withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                                const SizedBox(height: 10),

                                Container(
                                  padding: const EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.3),
                                        spreadRadius: 1,
                                        blurRadius: 2,
                                        offset: const Offset(0, 1),
                                      ),
                                    ],
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      _buildActionButton(
                                        icon: Icons.arrow_downward,
                                        label: 'ຖອນເງິນ',
                                        backgroundColor: const Color.fromARGB(
                                          61,
                                          158,
                                          158,
                                          158,
                                        ),
                                        iconColor: Color(0xFF006B8B),
                                        labelColor: Colors.black,
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  WithdrawPages(),
                                            ),
                                          );
                                        },
                                      ),
                                      _buildActionButton(
                                        icon: Icons.emoji_events,
                                        label: 'ຄະແນນ',
                                        backgroundColor: const Color.fromARGB(
                                          61,
                                          158,
                                          158,
                                          158,
                                        ),
                                        iconColor: Color(0xFF006B8B),
                                        labelColor: Colors.black,
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  PointPages(),
                                            ),
                                          );
                                        },
                                      ),
                                      _buildActionButton(
                                        icon: Icons.history,
                                        label: 'ປະຫວັດການຖອນ',
                                        backgroundColor: const Color.fromARGB(
                                          61,
                                          158,
                                          158,
                                          158,
                                        ),
                                        iconColor: Color(0xFF006B8B),
                                        labelColor: Colors.black,
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  HistoryTransaction(),
                                            ),
                                          );
                                        },
                                      ),
                                      _buildActionButton(
                                        icon: Icons.share,
                                        label: 'ເຊີນເພື່ອນ',
                                        backgroundColor: const Color.fromARGB(
                                          61,
                                          158,
                                          158,
                                          158,
                                        ),
                                        iconColor: Color(0xFF006B8B),
                                        labelColor: Colors.black,
                                        onTap: () {},
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 30),
                          const Text(
                            'ທົ່ວໄປ',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10),
                          _buildSettingsItem(
                            title: 'ຂໍ້ມູນສ່ວນຕົວ',
                            icon: Icons.person,
                            iconColor: Color(0xFF006B8B),
                            textColor: Colors.black87,
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => MyAccountPage(),
                                ),
                              );
                            },
                          ),
                          _buildSettingsItem(
                            title: 'ປ່ຽນລະຫັດຜ່ານ',
                            icon: Icons.lock,
                            iconColor: Color(0xFF006B8B),
                            textColor: Colors.black87,
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ChangePasswordPages(),
                                ),
                              );
                            },
                          ),
                          _buildSettingsItem(
                            title: 'ພາສາ',
                            icon: Icons.language,
                            iconColor: Color(0xFF006B8B),
                            textColor: Colors.black87,
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => LanguegePages(),
                                ),
                              );
                            },
                          ),
                          _buildSettingsItem(
                            title: 'ປະຫວັດການຈອງ',
                            icon: Icons.history,
                            iconColor: Color(0xFF006B8B),
                            textColor: Colors.black87,
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => HistoryBookingPages(),
                                ),
                              );
                            },
                          ),
                          _buildSettingsItem(
                            title: 'ຂໍ້ກຳນົດ ແລະ ນະໂຍບາຍ',
                            icon: Icons.receipt,
                            iconColor: Color(0xFF006B8B),
                            textColor: Colors.black87,
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => PrivacyPages(),
                                ),
                              );
                            },
                          ),
                          _buildSettingsItem(
                            title: 'ຊ່ວຍເຫຼືອ',
                            icon: Icons.help,
                            iconColor: Color(0xFF006B8B),
                            textColor: Colors.black87,
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => HelpPages(),
                                ),
                              );
                            },
                          ),
                          _buildSettingsItem(
                            title: 'ອອກຈາກລະບົບ',
                            icon: Icons.logout,
                            iconColor: Colors.red,
                            textColor: Colors.black87,
                            onTap: () => logout(context),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Positioned(
                top: 65,
                left: 0,
                right: 0,
                child: Column(
                  children: [
                    Container(
                      width: 150,
                      height: 150,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 10.0),
                      ),
                      child: const CircleAvatar(
                        radius: 80,
                        backgroundImage: AssetImage('assets/images/house.jpg'),
                        backgroundColor: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Username',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Text(
                      'Email.com',
                      style: TextStyle(color: Colors.black, fontSize: 14),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildIncomeExpenseItem(
    IconData icon,
    String title,
    String amount,
    Color color,
  ) {
    return Row(
      children: [
        Icon(icon, color: color),
        const SizedBox(width: 10),
        Column(
          children: [
            Text(
              title,
              style: const TextStyle(color: Colors.black87, fontSize: 14),
            ),
            const SizedBox(height: 5),
            Text(
              amount,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required Color backgroundColor,
    required Color iconColor,
    required Color labelColor,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: backgroundColor,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: iconColor),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: TextStyle(
              color: labelColor,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsItem({
    required String title,
    required IconData icon,
    Color iconColor = Colors.grey,
    Color textColor = Colors.black,
    VoidCallback? onTap,
  }) {
    return Column(
      children: [
        ListTile(
          leading: Icon(icon, color: iconColor),
          title: Text(title, style: TextStyle(color: textColor, fontSize: 16)),
          trailing: const Icon(
            Icons.arrow_forward_ios,
            size: 16,
            color: Colors.grey,
          ),
          onTap: onTap ?? () {},
        ),
        Divider(color: Colors.grey[200], height: 1),
      ],
    );
  }
}
