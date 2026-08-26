import 'dart:io';
import 'package:flutter/material.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController(
    text: 'Prateek Raj',
  );
  final TextEditingController _rollController = TextEditingController(
    text: '25155141',
  );
  final TextEditingController _txnIdController = TextEditingController();

  String _selectedPlan = '1 Month';
  String _selectedHostel = 'KP-7 (Boys)';
  File? _pickedSlipImage;
  bool _isSubmitting = false;

  final Map<String, int> _planPrices = {
    '1 Month': 500,
    '3 Months': 1500,
    'Semester (6 Mos)': 3000,
  };

  final List<String> _hostels = [
    'KP-1 (Boys)',
    'KP-2 (Boys)',
    'KP-3 (Boys)',
    'KP-4 (Boys)',
    'KP-5 (Boys)',
    'KP-6 (Boys)',
    'KP-7 (Boys)',
    'KP-8 (Boys)',
    'KP-9 (Boys)',
    'KP-10 (Boys)',
    'KP-11 (Boys)',
    'KP-12 (Boys)',
    'KP-14 (Boys)',
    'KP-15 (Boys)',
    'KP-16 (Boys)',
    'KP-18 (Boys)',
    'KP-19 (Boys)',
    'KP-20 (Boys)',
    'KP-21 (Boys)',
    'KP-22 (Boys)',
    'QC-1 (Girls)',
    'QC-2 (Girls)',
    'QC-3 (Girls)',
    'QC-4 (Girls)',
    'QC-5 (Girls)',
    'QC-6 (Girls)',
    'QC-7 (Girls)',
    'QC-8 (Girls)',
    'QC-9 (Girls)',
    'QC-10 (Girls)',
    'QC-11 (Girls)',
    'QC-12 (Girls)',
    'QC-13 (Girls)',
    'QC-14 (Girls)',
    'QC-15 (Girls)',
    'QC-16 (Girls)',
    'QC-17 (Girls)',
    'QC-18 (Girls)',
    'KSOM Boys Hostel',
    'KSOM Girls Hostel',
    'KSRM Hostel',
    'KIMS Boys Hostel',
    'KIMS Girls Hostel',
    'KIDS Boys Hostel',
    'KIDS Girls Hostel',
    'KLS Boys Hostel',
    'KLS Girls Hostel',
    'International Boys Hostel',
    'International Girls Hostel',
    'Day Scholar',
  ];

  void _showImagePickerModal() {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF1B2028),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Wrap(
            children: [
              ListTile(
                leading: const Icon(Icons.camera_alt, color: Color(0xFF00C853)),
                title: const Text('Take a Photo of Slip'),
                onTap: () {
                  Navigator.pop(ctx);
                  _showImagePickerUnavailableMessage();
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.photo_library,
                  color: Color(0xFF00C853),
                ),
                title: const Text('Choose from Gallery'),
                onTap: () {
                  Navigator.pop(ctx);
                  _showImagePickerUnavailableMessage();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showImagePickerUnavailableMessage() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Image selection is not available in this build.'),
      ),
    );
  }

  void _submitRegistration() async {
    if (!_formKey.currentState!.validate()) return;

    if (_pickedSlipImage == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Please upload a photo of your KIIT Accounts payment slip.',
          ),
          backgroundColor: Colors.redAccent,
        ),
      );
      return;
    }

    setState(() => _isSubmitting = true);

    // Simulate network submission to Firestore / Cloud Storage
    await Future.delayed(const Duration(seconds: 2));

    if (mounted) {
      setState(() => _isSubmitting = false);
      _showSuccessDialog();
    }
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFF1B2028),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Row(
          children: [
            Icon(Icons.check_circle, color: Color(0xFF00C853), size: 28),
            SizedBox(width: 10),
            Text('Request Submitted'),
          ],
        ),
        content: const Text(
          'Your registration slip has been sent to the gym desk for verification. Your pass will activate once verified.',
          style: TextStyle(color: Colors.white70, fontSize: 14),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
              Navigator.pop(context); // Return to Profile or Pass screen
            },
            child: const Text('OK', style: TextStyle(color: Color(0xFF00C853))),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _rollController.dispose();
    _txnIdController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Membership / Renewal'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Notice Callout
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: const Color(0xFF262D38),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Row(
                  children: [
                    Icon(
                      Icons.verified_user_outlined,
                      color: Color(0xFF00C853),
                      size: 22,
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'Upload the physical Accounts slip or UPI transaction reference for sports desk validation.',
                        style: TextStyle(fontSize: 12.5, color: Colors.white70),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Membership Plan Selector
              const Text(
                'Select Plan Duration',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              ),
              const SizedBox(height: 10),
              Row(
                children: _planPrices.keys.map((plan) {
                  final isSelected = _selectedPlan == plan;
                  return Expanded(
                    child: GestureDetector(
                      onTap: () => setState(() => _selectedPlan = plan),
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? const Color(0xFF00C853).withValues(alpha: 0.15)
                              : const Color(0xFF1B2028),
                          border: Border.all(
                            color: isSelected
                                ? const Color(0xFF00C853)
                                : const Color(0xFF262D38),
                            width: 1.5,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          children: [
                            Text(
                              plan,
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: isSelected
                                    ? const Color(0xFF00E676)
                                    : Colors.white70,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '₹${_planPrices[plan]}',
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 24),

              // Student Information Fields
              const Text(
                'Student Information',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _nameController,
                decoration: _inputDecoration('Full Name', Icons.person_outline),
                validator: (val) => val == null || val.isEmpty
                    ? 'Please enter your name'
                    : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _rollController,
                decoration: _inputDecoration(
                  'Roll / Registration No',
                  Icons.badge_outlined,
                ),
                keyboardType: TextInputType.number,
                validator: (val) => val == null || val.isEmpty
                    ? 'Please enter your Roll No'
                    : null,
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<String>(
                initialValue: _selectedHostel,
                dropdownColor: const Color(0xFF1B2028),
                decoration: _inputDecoration(
                  'Hostel / Residence',
                  Icons.home_outlined,
                ),
                items: _hostels
                    .map((h) => DropdownMenuItem(value: h, child: Text(h)))
                    .toList(),
                onChanged: (val) => setState(() => _selectedHostel = val!),
              ),
              const SizedBox(height: 24),

              // Payment Verification Section
              const Text(
                'Payment & Receipt Details',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _txnIdController,
                decoration: _inputDecoration(
                  'Slip No / UPI Ref ID (12 digits)',
                  Icons.tag,
                ),
                validator: (val) => val == null || val.isEmpty
                    ? 'Enter Accounts slip number or UPI reference'
                    : null,
              ),
              const SizedBox(height: 16),

              // Slip Image Upload Box
              GestureDetector(
                onTap: _showImagePickerModal,
                child: Container(
                  width: double.infinity,
                  height: 160,
                  decoration: BoxDecoration(
                    color: const Color(0xFF1B2028),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: _pickedSlipImage != null
                          ? const Color(0xFF00C853)
                          : const Color(0xFF262D38),
                      style: BorderStyle.solid,
                      width: 1.5,
                    ),
                  ),
                  child: _pickedSlipImage != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Stack(
                            fit: StackFit.expand,
                            children: [
                              Image.file(_pickedSlipImage!, fit: BoxFit.cover),
                              Container(
                                color: Colors.black45,
                                child: const Center(
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        Icons.edit,
                                        color: Colors.white,
                                        size: 18,
                                      ),
                                      SizedBox(width: 6),
                                      Text(
                                        'Change Photo',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      : const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.cloud_upload_outlined,
                              size: 36,
                              color: Color(0xFF00C853),
                            ),
                            SizedBox(height: 8),
                            Text(
                              'Tap to upload Payment Slip photo',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              'JPG, PNG supported',
                              style: TextStyle(
                                fontSize: 11,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                ),
              ),
              const SizedBox(height: 28),

              // Submit Button
              ElevatedButton(
                onPressed: _isSubmitting ? null : _submitRegistration,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF00C853),
                  foregroundColor: Colors.black,
                  minimumSize: const Size.fromHeight(52),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: _isSubmitting
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            Colors.black,
                          ),
                        ),
                      )
                    : const Text(
                        'Submit for Desk Approval',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(String label, IconData icon) {
    return InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(color: Colors.grey, fontSize: 13),
      prefixIcon: Icon(icon, size: 20, color: Colors.grey),
      filled: true,
      fillColor: const Color(0xFF1B2028),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFF262D38)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFF00C853), width: 1.5),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.redAccent),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.redAccent, width: 1.5),
      ),
    );
  }
}
