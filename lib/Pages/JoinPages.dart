import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class JoinPages extends StatefulWidget {
  final VoidCallback onGoToAddPage;

  const JoinPages({Key? key, required this.onGoToAddPage}) : super(key: key);

  @override
  State<JoinPages> createState() => _JoinPagesState();
}

class _JoinPagesState extends State<JoinPages> {
  bool _termsAccepted = false;
  final Color _primaryColor = const Color(0xFF0C697A);
  final Color _secondaryColor = const Color(0xFF57A7B1);
  final Color _accentColor = const Color(0xFF4DB6AC);

  @override
  void initState() {
    super.initState();
    _checkTermsAcceptance();
  }

  Future<void> _checkTermsAcceptance() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _termsAccepted = prefs.getBool('terms_accepted') ?? false;
    });

    if (!_termsAccepted) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _showTermsAndConditionsPage();
      });
    }
  }

  Future<void> _resetTermsAcceptance() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('terms_accepted'); // Remove the stored status
    setState(() {
      _termsAccepted = false; // Reset the state
    });
    // Optionally, show the page immediately after reset
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _showTermsAndConditionsPage();
    });
  }

  void _showTermsAndConditionsPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TermsAndConditionsPage(
          primaryColor: _primaryColor,
          secondaryColor: _secondaryColor,
          accentColor: _accentColor,
          onAccept: () async {
            final prefs = await SharedPreferences.getInstance();
            await prefs.setBool('terms_accepted', true);
            setState(() {
              _termsAccepted = true;
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'ເຂົ້າຮ່ວມ',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Colors.white,
          ),
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [_secondaryColor, _primaryColor],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        actions: [
          // Add a reset button to the AppBar for testing purposes
          IconButton(
            icon: const Icon(Icons.refresh, color: Colors.white),
            onPressed: _resetTermsAcceptance,
            tooltip: 'ຣີເຊັດການຍອມຮັບເງື່ອນໄຂ',
          ),
        ],
      ),
      body: Center(
        child: _termsAccepted
            ? Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildActionButton(
                      text: 'Post ເອງ',
                      icon: Icons.add_circle_outline,
                      onPressed: () {
                        showPostDialog(context);
                      },
                      isPrimary: true,
                    ),
                    const SizedBox(height: 20),
                    _buildActionButton(
                      text: 'ຝາກໃຫ້ Post',
                      icon: Icons.send_outlined,
                      onPressed: () {
                        widget.onGoToAddPage();
                      },
                      isPrimary: false,
                    ),
                  ],
                ),
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(_primaryColor),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'ກຳລັງໂຫລດ...',
                    style: TextStyle(color: _primaryColor, fontSize: 16),
                  ),
                ],
              ),
      ),
    );
  }

  Widget _buildActionButton({
    required String text,
    required IconData icon,
    required VoidCallback onPressed,
    required bool isPrimary,
  }) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          foregroundColor: isPrimary ? Colors.white : _primaryColor,
          backgroundColor: isPrimary ? _primaryColor : Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: isPrimary
                ? BorderSide.none
                : BorderSide(color: _primaryColor, width: 2),
          ),
          elevation: 0,
          shadowColor: Colors.transparent,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 24),
            const SizedBox(width: 10),
            Text(
              text,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  void showPostDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: Container(
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [
                  Color.fromARGB(255, 87, 167, 177),
                  Color.fromARGB(255, 12, 105, 122),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(20),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 10,
                  offset: Offset(0, 5),
                ),
              ],
            ),
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'ຂໍ້ມູນ',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 15),
                const Text(
                  'ຂະບວນການນີ້ກຳລັງພັດທະນາຢູ່...',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 25),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: const Color.fromARGB(255, 12, 105, 122),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30,
                      vertical: 12,
                    ),
                  ),
                  onPressed: () => Navigator.pop(context),
                  child: const Text(
                    'ປິດ',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class TermsAndConditionsPage extends StatefulWidget {
  final VoidCallback onAccept; // Callback function when terms are accepted
  final Color primaryColor;
  final Color secondaryColor;
  final Color accentColor;

  const TermsAndConditionsPage({
    super.key,
    required this.onAccept,
    required this.primaryColor,
    required this.secondaryColor,
    required this.accentColor,
  });

  @override
  _TermsAndConditionsPageState createState() => _TermsAndConditionsPageState();
}

class _TermsAndConditionsPageState extends State<TermsAndConditionsPage> {
  late ScrollController _scrollController;
  bool _scrolledToEnd = false; // New state for tracking if scrolled to end
  bool _isChecked = false; // New state for the checkbox

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(
      _onScroll,
    ); // Add listener to detect scroll position
    // Check if content is smaller than viewport, if so, enable accept button immediately
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.position.maxScrollExtent == 0) {
        setState(() {
          _scrolledToEnd =
              true; // Set scrolled to end if content is not scrollable
        });
      }
    });
  }

  @override
  void dispose() {
    _scrollController.removeListener(
      _onScroll,
    ); // Remove listener to prevent memory leaks
    _scrollController.dispose(); // Dispose the scroll controller
    super.dispose();
  }

  // Listener function to check if the user has scrolled to the end
  void _onScroll() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      if (!_scrolledToEnd) {
        setState(() {
          _scrolledToEnd = true; // User has scrolled to the end
        });
      }
    } else {
      // If user scrolls back up, disable the button again
      if (_scrolledToEnd) {
        setState(() {
          _scrolledToEnd = false;
        });
      }
    }
  }

  // Helper to determine if the accept button should be enabled
  bool get _canAcceptButtonBeEnabled => _scrolledToEnd && _isChecked;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop:
          _canAcceptButtonBeEnabled, // Allow popping only if terms are accepted and checkbox is checked
      onPopInvoked: (didPop) {
        if (didPop && !_canAcceptButtonBeEnabled) {}
      },
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          title: const Text(
            'ເງື່ອນໄຂ ແລະ ນະໂຍບາຍການເຂົ້າຮ່ວມ',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: Colors.white,
            ),
          ),
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [widget.secondaryColor, widget.primaryColor],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          automaticallyImplyLeading: false, // Hide back button
        ),
        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                controller: _scrollController, // Assign the scroll controller
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 8),
                    Center(
                      child: Icon(
                        Icons.assignment_outlined,
                        size: 50,
                        color: widget.primaryColor,
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Center(
                      child: Text(
                        'ຍິນດີຕ້ອນຮັບສູ່ແພລັດຟອມຂອງພວກເຮົາ!',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'ກະລຸນາອ່ານເງື່ອນໄຂ ແລະ ນະໂຍບາຍລຸ່ມນີ້ຢ່າງລະອຽດກ່ອນທີ່ຈະດຳເນີນການຕໍ່. ການເຂົ້າຮ່ວມແພລັດຟອມຂອງພວກເຮົາຖືວ່າທ່ານໄດ້ອ່ານ, ເຂົ້າໃຈ ແລະ ຍອມຮັບເງື່ອນໄຂທັງໝົດທີ່ລະບຸໄວ້.',
                      style: TextStyle(fontSize: 14, height: 1.5),
                    ),
                    const SizedBox(height: 24),
                    _buildSectionTitle('1. ຄໍານິຍາມ'),
                    _buildSectionContent(
                      '1.1 "ແພລັດຟອມ" ໝາຍເຖິງ ເວັບໄຊທ໌, ແອັບພລິເຄຊັນ ຫຼື ບໍລິການໃດໆ ທີ່ພວກເຮົາຈັດຫາໃຫ້',
                    ),
                    _buildSectionContent(
                      '1.2 "ຜູ້ໃຊ້" ໝາຍເຖິງ ບຸກຄົນໃດໆ ທີ່ເຂົ້າເຖິງ ຫຼື ນໍາໃຊ້ແພລັດຟອມຂອງພວກເຮົາ',
                    ),
                    _buildSectionContent(
                      '1.3 "ເນື້ອຫາ" ໝາຍເຖິງ ຂໍ້ຄວາມ, ຮູບພາບ, ວິດີໂອ ຫຼື ຂໍ້ມູນໃດໆ ທີ່ໂພສລົງໃນແພລັດຟອມ',
                    ),
                    const SizedBox(height: 16),
                    _buildSectionTitle('2. ການຍອມຮັບເງື່ອນໄຂ'),
                    _buildSectionContent(
                      '2.1 ການນໍາໃຊ້ແພລັດຟອມຂອງພວກເຮົາ, ທ່ານຕົກລົງທີ່ຈະຜູກມັດຕາມເງື່ອນໄຂ ແລະ ນະໂຍບາຍເຫຼົ່ານີ້, ລວມທັງນະໂຍບາຍຄວາມເປັນສ່ວນຕົວຂອງພວກເຮົາ',
                    ),
                    _buildSectionContent(
                      '2.2 ຖ້າທ່ານບໍ່ເຫັນດີກັບເງື່ອນໄຂໃດໆ, ທ່ານບໍ່ຄວນນໍາໃຊ້ແພລັດຟອມຂອງພວກເຮົາ',
                    ),
                    const SizedBox(height: 16),
                    _buildSectionTitle('3. ການນໍາໃຊ້ແພລັດຟອມ'),
                    _buildSectionContent(
                      '3.1 ທ່ານຕ້ອງມີອາຍຸຢ່າງໜ້ອຍ 18 ປີບໍລິບູນຈຶ່ງຈະສາມາດນໍາໃຊ້ແພລັດຟອມນີ້ໄດ້',
                    ),
                    _buildSectionContent(
                      '3.2 ທ່ານຕົກລົງທີ່ຈະບໍ່ໂພສເນື້ອຫາທີ່ຜິດກົດໝາຍ, ເປັນອັນຕະລາຍ, ຂົ່ມຂູ່, ດູໝິ່ນ, ຄຸກຄາມ, ໝິ່ນປະໝາດ, ຫຍາບຄາຍ, ລາມົກອານາຈານ ຫຼື ເປັນທີ່ໜ້າລັງກຽດ',
                    ),
                    _buildSectionContent(
                      '3.3 ທ່ານຕົກລົງທີ່ຈະບໍ່ນໍາໃຊ້ແພລັດຟອມເພື່ອຈຸດປະສົງທີ່ບໍ່ໄດ້ຮັບອະນຸຍາດ ຫຼື ຜິດກົດໝາຍ',
                    ),
                    _buildSectionContent(
                      '3.4 ພວກເຮົາຂໍສະຫງວນສິດໃນການລຶບເນື້ອຫາໃດໆ ທີ່ພວກເຮົາເຫັນວ່າບໍ່ເໝາະສົມ ຫຼື ລະງັບບັນຊີຜູ້ໃຊ້ໃດໆ ທີ່ລະເມີດເງື່ອນໄຂເຫຼົ່ານີ້',
                    ),
                    const SizedBox(height: 16),
                    _buildSectionTitle('4. ນະໂຍບາຍຄວາມເປັນສ່ວນຕົວ'),
                    _buildSectionContent(
                      '4.1 ພວກເຮົາໃຫ້ຄວາມສໍາຄັນກັບຄວາມເປັນສ່ວນຕົວຂອງທ່ານ. ກະລຸນາອ່ານນະໂຍບາຍຄວາມເປັນສ່ວນຕົວຂອງພວກເຮົາເພື່ອເຮັດຄວາມເຂົ້າໃຈວ່າພວກເຮົາເກັບກໍາ, ນໍາໃຊ້ ແລະ ເປີດເຜີຍຂໍ້ມູນຂອງທ່ານແນວໃດ',
                    ),
                    _buildSectionContent(
                      '4.2 ການນໍາໃຊ້ແພລັດຟອມຂອງພວກເຮົາ, ທ່ານຍິນຍອມໃຫ້ພວກເຮົາເກັບກໍາ ແລະ ນໍາໃຊ້ຂໍ້ມູນຂອງທ່ານຕາມທີ່ລະບຸໄວ້ໃນນະໂຍບາຍຄວາມເປັນສ່ວນຕົວ',
                    ),
                    const SizedBox(height: 16),
                    _buildSectionTitle('5. ຊັບສິນທາງປັນຍາ'),
                    _buildSectionContent(
                      '5.1 ເນື້ອຫາທັງໝົດໃນແພລັດຟອມເປັນຊັບສິນຂອງພວກເຮົາ ຫຼື ຜູ້ໃຫ້ອະນຸຍາດຂອງພວກເຮົາ ແລະ ໄດ້ຮັບການຄຸ້ມຄອງໂດຍກົດໝາຍລິຂະສິດ ແລະ ເຄື່ອງໝາຍການຄ້າ',
                    ),
                    _buildSectionContent(
                      '5.2 ທ່ານບໍ່ສາມາດຄັດລອກ, ສໍາເນົາ, ແຈກຢາຍ ຫຼື ສ້າງຜົນງານລອກລຽນແບບຈາກເນື້ອຫາໃດໆ ໂດຍບໍ່ໄດ້ຮັບອະນຸຍາດເປັນລາຍລັກອັກສອນຈາກພວກເຮົາ',
                    ),
                    const SizedBox(height: 16),
                    _buildSectionTitle('6. ການຈໍາກັດຄວາມຮັບຜິດຊອບ'),
                    _buildSectionContent(
                      '6.1 ແພລັດຟອມຂອງພວກເຮົາໃຫ້ບໍລິການ "ຕາມສະພາບ" ແລະ "ຕາມທີ່ມີ" ໂດຍບໍ່ມີການຮັບປະກັນໃດໆ ທັງໂດຍຊັດແຈ້ງ ຫຼື ໂດຍນัย',
                    ),
                    _buildSectionContent(
                      '6.2 ພວກເຮົາຈະບໍ່ຮັບຜິດຊອບຕໍ່ຄວາມເສຍຫາຍໃດໆ ທີ່ເກີດຂຶ້ນຈາກການນໍາໃຊ້ ຫຼື ການບໍ່ສາມາດນໍາໃຊ້ແພລັດຟອມຂອງພວກເຮົາ',
                    ),
                    const SizedBox(height: 16),
                    _buildSectionTitle('7. ການປ່ຽນແປງເງື່ອນໄຂ'),
                    _buildSectionContent(
                      '7.1 ພວກເຮົາຂໍສະຫງວນສິດໃນການແກ້ໄຂ ຫຼື ປັບປຸງເງື່ອນໄຂ ແລະ ນະໂຍບາຍເຫຼົ່ານີ້ໄດ້ຕະຫຼອດເວລາ. ການປ່ຽນແປງຈະມີຜົນທັນທີເມື່ອມີການໂພສລົງໃນແພລັດຟອມ',
                    ),
                    _buildSectionContent(
                      '7.2 ການນໍາໃຊ້ແພລັດຟອມຕໍ່ໄປຫຼັງຈາກມີການປ່ຽນແປງ, ຖືວ່າທ່ານຍອມຮັບເງື່ອນໄຂທີ່ແກ້ໄຂແລ້ວ',
                    ),
                    const SizedBox(height: 16),
                    _buildSectionTitle('8. ກົດໝາຍທີ່ນໍາໃຊ້'),
                    _buildSectionContent(
                      '8.1 ເງື່ອນໄຂ ແລະ ນະໂຍບາຍເຫຼົ່ານີ້ຈະຢູ່ພາຍໃຕ້ບັງຄັບ ແລະ ຕີຄວາມຕາມກົດໝາຍຂອງ ສ.ປ.ປ. ລາວ',
                    ),
                    _buildSectionContent(
                      '8.2 ຂໍ້ພິພາດໃດໆ ທີ່ເກີດຂຶ້ນຈາກ ຫຼື ກ່ຽວຂ້ອງກັບເງື່ອນໄຂເຫຼົ່ານີ້ຈະຢູ່ພາຍໃຕ້ເຂດອໍານາດສານຂອງ ສ.ປ.ປ. ລາວ',
                    ),
                    const SizedBox(height: 16),
                    _buildSectionTitle('9. ການຕິດຕໍ່ພວກເຮົາ'),
                    _buildSectionContent(
                      '9.1 ຖ້າທ່ານມີຄໍາຖາມໃດໆ ກ່ຽວກັບເງື່ອນໄຂ ແລະ ນະໂຍບາຍເຫຼົ່ານີ້, ກະລຸນາຕິດຕໍ່ພວກເຮົາທີ່ support@example.com',
                    ),
                    const SizedBox(height: 24),
                    _buildSectionTitle('ເງື່ອນໄຂເພີ່ມເຕີມ'),
                    _buildSectionContent(
                      'ກະລຸນາຮັບຊາບວ່າພວກເຮົາອາດຈະມີການປັບປຸງ ຫຼື ເພີ່ມເງື່ອນໄຂ ແລະ ນະໂຍບາຍເພີ່ມເຕີມເປັນບາງຄັ້ງຄາວ, ເພື່ອໃຫ້ສອດຄ່ອງກັບການປ່ຽນແປງຂອງກົດໝາຍ ຫຼື ການໃຫ້ບໍລິການຂອງພວກເຮົາ. ການປ່ຽນແປງເຫຼົ່ານີ້ຈະຖືກປະກາດໃນແພລັດຟອມ ແລະ ຈະມີຜົນບັງຄັບໃຊ້ທັນທີທີ່ທ່ານນໍາໃຊ້ບໍລິການຂອງພວກເຮົາຕໍ່ໄປຫຼັງຈາກມີການປະກາດ.',
                    ),
                    const SizedBox(height: 16),
                    _buildSectionContent(
                      'ພວກເຮົາຂໍຂອບໃຈທີ່ທ່ານສະຫຼະເວລາອ່ານ ແລະ ເຮັດຄວາມເຂົ້າໃຈເງື່ອນໄຂ ແລະ ນະໂຍບາຍເຫຼົ່ານີ້. ການຍອມຮັບຂອງທ່ານຈະຊ່ວຍໃຫ້ພວກເຮົາສາມາດໃຫ້ບໍລິການທີ່ດີທີ່ສຸດແກ່ທ່ານໄດ້.',
                    ),
                    const SizedBox(height: 16),
                    Center(
                      child: Text(
                        'ຂໍໃຫ້ມີຄວາມສຸກກັບການນໍາໃຊ້ແພລັດຟອມຂອງພວກເຮົາ!',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20), // Space before checkbox
                    // Checkbox for terms acceptance
                    CheckboxListTile(
                      title: const Text(
                        'ຂ້ອຍໄດ້ອ່ານ ແລະ ຍອມຮັບເງື່ອນໄຂ ແລະ ນະໂຍບາຍທັງໝົດແລ້ວ',
                        style: TextStyle(fontSize: 15),
                      ),
                      value: _isChecked,
                      onChanged: _scrolledToEnd
                          ? (bool? newValue) {
                              setState(() {
                                _isChecked = newValue ?? false;
                              });
                            }
                          : null, // Disable checkbox if not scrolled to end
                      controlAffinity: ListTileControlAffinity.leading,
                      activeColor: widget.primaryColor,
                    ),
                    const SizedBox(height: 20), // Space after checkbox
                  ],
                ),
              ),
            ),
            // Accept button at the bottom
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: _canAcceptButtonBeEnabled
                    ? () {
                        widget.onAccept();
                        Navigator.of(context).pop();
                      }
                    : null, // Button is disabled until terms are scrolled to the end and checkbox is checked
                style: ElevatedButton.styleFrom(
                  backgroundColor: _canAcceptButtonBeEnabled
                      ? widget.primaryColor
                      : Colors.grey,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 3,
                  minimumSize: const Size.fromHeight(
                    50,
                  ), // Make button full width
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.check_circle_outline),
                    SizedBox(width: 10),
                    Text(
                      'ຍອມຮັບ',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
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

  Widget _buildSectionTitle(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: widget.primaryColor,
        ),
      ),
    );
  }

  Widget _buildSectionContent(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(text, style: const TextStyle(fontSize: 14, height: 1.5)),
    );
  }
}
