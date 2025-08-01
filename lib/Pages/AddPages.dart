import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class AddPage extends StatefulWidget {
  const AddPage({super.key});

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  final _formKey = GlobalKey<FormState>();
  String? _selectedCategory = "ເຮືອນ";
  String? _selectedStatus = "ເຊົ່າ";
  String? _selectedRoomSharing = "ບໍ່ແຊຫ້ອງ";
  List<File> _selectedImages = [];
  bool _isLoading = false;

  // Form controllers
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _areaController = TextEditingController();

  // Amenities selection
  Map<String, bool> _amenities = {
    'ຈອດລົດ': false,
    'ອິນເຕີເນັດ': false,
    'ເຄື່ອງເຮືອນ': false,
    'ເຮືອນຄາບ': false,
    'ຕູ້ເຢັນ': false,
    'ກວດຄົນເຂົ້າ': false,
  };

  @override
  void dispose() {
    _titleController.dispose();
    _priceController.dispose();
    _locationController.dispose();
    _descriptionController.dispose();
    _phoneController.dispose();
    _areaController.dispose();
    super.dispose();
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
          title: const Text('ເພິ່ມທີ່ພັກໃໝ່'),
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

      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Section 1: Basic Information
                    _buildSectionHeader('ຂໍ້ມູນພື້ນຖານ'),
                    const SizedBox(height: 12),

                    // Property Images
                    _buildImageUploadSection(),
                    const SizedBox(height: 20),

                    // Property Title
                    _buildInputField(
                      label: 'ຊື່ທີ່ພັກ',
                      controller: _titleController,
                      icon: Icons.title,
                      validator: (value) =>
                          value?.isEmpty ?? true ? 'ກະລຸນາໃສ່ຊື່ທີ່ພັກ' : null,
                    ),
                    const SizedBox(height: 16),

                    // Property Category
                    _buildDropdownSection(
                      'ປະເພດທີ່ພັກ',
                      _selectedCategory,
                      ['ເຮືອນ', 'ຫ້ອງແຖວ', 'ວິວລ່າ', 'ອາພາດເມັ້ນ'],

                      (value) => setState(() => _selectedCategory = value),
                      Icons.category,
                    ),
                    const SizedBox(height: 16),

                    // Property Status
                    _buildDropdownSection(
                      'ສະຖານະ',
                      _selectedStatus,
                      ['ເຊົ່າ', 'ຂາຍ'],
                      (value) => setState(() => _selectedStatus = value),
                      Icons.sell,
                    ),
                    const SizedBox(height: 16),

                    // Room Sharing (only shown if status is "ເຊົ່າ")
                    if (_selectedStatus == 'ເຊົ່າ') ...[
                      _buildDropdownSection(
                        'ການແຊ່ຫ້ອງ',
                        _selectedRoomSharing,
                        ['ແຊຫ້ອງ', 'ບໍ່ແຊຫ້ອງ'],
                        (value) => setState(() => _selectedRoomSharing = value),
                        Icons.people,
                      ),
                      const SizedBox(height: 16),
                    ],

                    // Section 2: Property Details
                    _buildSectionHeader('ລາຍລະອຽດທີ່ພັກ'),
                    const SizedBox(height: 12),

                    // Property Price
                    _buildInputField(
                      label: 'ລາຄາ (₭)',
                      controller: _priceController,
                      icon: Icons.attach_money,
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value?.isEmpty ?? true) return 'ກະລຸນາໃສ່ລາຄາ';
                        if (double.tryParse(value!) == null)
                          return 'ກະລຸນາໃສ່ຕົວເລກຖືກຕ້ອງ';
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),

                    // Property Area
                    _buildInputField(
                      label: 'ຂະໜາດ (ຕລ.ມ.)',
                      controller: _areaController,
                      icon: Icons.aspect_ratio,
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value?.isEmpty ?? true) return 'ກະລຸນາໃສ່ຂະໜາດ';
                        if (double.tryParse(value!) == null)
                          return 'ກະລຸນາໃສ່ຕົວເລກຖືກຕ້ອງ';
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),

                    // Property Location
                    _buildInputField(
                      label: 'ທີ່ຢູ່',
                      controller: _locationController,
                      icon: Icons.location_on,
                      validator: (value) =>
                          value?.isEmpty ?? true ? 'ກະລຸນາໃສ່ທີ່ຢູ່' : null,
                    ),
                    const SizedBox(height: 16),

                    // Contact Phone
                    _buildInputField(
                      label: 'ເບີໂທລະສັບ',
                      controller: _phoneController,
                      icon: Icons.phone,
                      keyboardType: TextInputType.phone,
                      validator: (value) =>
                          value?.isEmpty ?? true ? 'ກະລຸນາໃສ່ເບີໂທ' : null,
                    ),
                    const SizedBox(height: 16),

                    // Property Description
                    _buildDescriptionField(),
                    const SizedBox(height: 20),

                    // Amenities Section
                    _buildSectionHeader('ສິ່ງອຳນວຍຄວາມສະດວກ'),
                    const SizedBox(height: 12),
                    _buildAmenitiesGrid(),
                    const SizedBox(height: 30),

                    // Submit Button
                    _buildSubmitButton(),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Color(0xFF006B8B),
      ),
    );
  }

  Widget _buildInputField({
    required String label,
    required TextEditingController controller,
    required IconData icon,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
    int? maxLength,
  }) {
    return Material(
      elevation: 2,
      borderRadius: BorderRadius.circular(10),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: Colors.white,
          prefixIcon: Icon(icon, color: const Color(0xFF006B8B)),
          contentPadding: const EdgeInsets.symmetric(
            vertical: 15,
            horizontal: 20,
          ),
          counterText: '',
        ),
        keyboardType: keyboardType,
        validator: validator,
        maxLength: maxLength,
      ),
    );
  }

  Widget _buildDescriptionField() {
    return Material(
      elevation: 2,
      borderRadius: BorderRadius.circular(10),
      child: TextFormField(
        controller: _descriptionController,
        decoration: InputDecoration(
          labelText: 'ລາຍລະອຽດ',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: Colors.white,
          alignLabelWithHint: true,
          contentPadding: const EdgeInsets.all(20),
        ),
        maxLines: 5,
        validator: (value) =>
            value?.isEmpty ?? true ? 'ກະລຸນາໃສ່ລາຍລະອຽດ' : null,
      ),
    );
  }

  Widget _buildImageUploadSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'ຮູບພາບທີ່ພັກ (ຢ່າງໜ້ອຍ 1 ຮູບ)',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Color(0xFF006B8B),
          ),
        ),
        const SizedBox(height: 8),
        Container(
          height: 150,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
          child: _selectedImages.isEmpty
              ? _buildEmptyImagePlaceholder()
              : _buildImageRow(),
        ),
        const SizedBox(height: 8),
        _buildImageUploadButton(),
      ],
    );
  }

  Widget _buildEmptyImagePlaceholder() {
    return GestureDetector(
      onTap: _pickImages,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.camera_alt, size: 40, color: Colors.grey[600]),
            const SizedBox(height: 8),
            Text('ເພີ່ມຮູບພາບ', style: TextStyle(color: Colors.grey[600])),
          ],
        ),
      ),
    );
  }

  // Widget _buildImageGrid() {
  Widget _buildImageRow() {
    return SizedBox(
      height: 100, // ความสูงของรูปภาพแต่ละรูป
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount:
            _selectedImages.length + (_selectedImages.length < 10 ? 1 : 0),
        itemBuilder: (context, index) {
          if (index == _selectedImages.length) {
            return GestureDetector(
              onTap: _pickImages,
              child: Container(
                width: 100,
                margin: const EdgeInsets.only(right: 8),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.add),
              ),
            );
          }
          return Stack(
            children: [
              Container(
                width: 100,
                margin: const EdgeInsets.only(right: 8),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.file(
                    _selectedImages[index],
                    fit: BoxFit.cover,
                    width: 100,
                    height: 100,
                  ),
                ),
              ),
              Positioned(
                top: 4,
                right: 12,
                child: GestureDetector(
                  onTap: () => _removeImage(index),
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.close,
                      size: 16,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildImageUploadButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: _pickImages,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF006B8B),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          padding: const EdgeInsets.symmetric(vertical: 12),
        ),
        icon: const Icon(Icons.add_a_photo, color: Colors.white),
        label: const Text('ເພີ່ມຮູບພາບ', style: TextStyle(color: Colors.white)),
      ),
    );
  }

  Widget _buildDropdownSection(
    String label,
    String? value,
    List<String> items,
    void Function(String?) onChanged,
    IconData icon,
  ) {
    return Material(
      elevation: 2,
      borderRadius: BorderRadius.circular(10),
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: Colors.white,
          prefixIcon: Icon(icon, color: const Color(0xFF006B8B)),
          contentPadding: const EdgeInsets.symmetric(
            vertical: 5,
            horizontal: 10,
          ),
        ),
        child: DropdownButtonHideUnderline(
          child: Theme(
            data: Theme.of(context).copyWith(canvasColor: Colors.white),
            child: DropdownButton<String>(
              value: value,
              isExpanded: true,
              icon: const Icon(Icons.arrow_drop_down, color: Color(0xFF006B8B)),
              style: const TextStyle(color: Colors.black, fontSize: 16),
              items: items.map((String item) {
                return DropdownMenuItem<String>(value: item, child: Text(item));
              }).toList(),
              onChanged: onChanged,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAmenitiesGrid() {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        childAspectRatio: 3,
      ),
      itemCount: _amenities.length,
      itemBuilder: (context, index) {
        final amenity = _amenities.keys.elementAt(index);
        return FilterChip(
          backgroundColor: Colors.white,
          label: Text(amenity),
          selected: _amenities[amenity]!,
          onSelected: (selected) {
            setState(() {
              _amenities[amenity] = selected;
            });
          },
          selectedColor: const Color(0xFF00CEB0),
          checkmarkColor: Colors.white,
          labelStyle: TextStyle(
            color: _amenities[amenity]! ? Colors.white : Colors.black,
          ),
          avatar: Icon(
            _getAmenityIcon(amenity),
            color: _amenities[amenity]!
                ? Colors.white
                : const Color(0xFF006B8B),
          ),
        );
      },
    );
  }

  IconData _getAmenityIcon(String amenity) {
    switch (amenity) {
      case 'ຈອດລົດ':
        return Icons.local_parking;
      case 'ອິນເຕີເນັດ':
        return Icons.wifi;
      case 'ເຄື່ອງເຮືອນ':
        return Icons.kitchen;
      case 'ເຮືອນຄາບ':
        return Icons.pool;
      case 'ຕູ້ເຢັນ':
        return Icons.ac_unit;
      case 'ກວດຄົນເຂົ້າ':
        return Icons.security;
      default:
        return Icons.check;
    }
  }

  Widget _buildSubmitButton() {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: _isLoading ? null : _submitForm,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF006B8B),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          elevation: 3,
        ),
        child: _isLoading
            ? const CircularProgressIndicator(color: Colors.white)
            : const Text(
                'ຕົກລົງ',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
      ),
    );
  }

  Future<void> _pickImages() async {
    try {
      final pickedFiles = await ImagePicker().pickMultiImage(
        maxWidth: 1200,
        maxHeight: 1200,
        imageQuality: 85,
      );

      if (pickedFiles.isNotEmpty) {
        setState(() {
          _selectedImages.addAll(pickedFiles.map((file) => File(file.path)));
          if (_selectedImages.length > 10) {
            _selectedImages = _selectedImages.sublist(0, 10);
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('ສາມາດເພີ່ມຮູບໄດ້ສູງສຸດ 10 ຮູບ')),
            );
          }
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('ຜິດພາດໃນການເລືອກຮູບ: $e')));
    }
  }

  void _removeImage(int index) {
    setState(() {
      _selectedImages.removeAt(index);
    });
  }

  Future<void> _submitForm() async {
    if (!_formKey.currentState!.validate()) return;
    if (_selectedImages.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('ກະລຸນາເພີ່ມຮູບພາບຢ່າງໜ້ອຍ 1 ຮູບ')),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      // Simulate network request
      await Future.delayed(const Duration(seconds: 2));

      // Process form data

      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('ເພີ່ມທີ່ພັກສຳເລັດແລ້ວ'),
          backgroundColor: Colors.green,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      );

      // Reset form
      _formKey.currentState!.reset();
      setState(() {
        _selectedImages.clear();
        _selectedCategory = "ເຮືອນ";
        _selectedStatus = "ເຊົ່າ";
        _selectedRoomSharing = "ບໍ່ແຊຫ້ອງ";
        _amenities = _amenities.map((key, value) => MapEntry(key, false));
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('ຜິດພາດ: $e'), backgroundColor: Colors.red),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }
}
