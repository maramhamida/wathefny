import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/foundation.dart'; // kIsWeb
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'myappbar.dart';
import 'routes.dart';

class JobSeekerScreen extends StatefulWidget {
  const JobSeekerScreen({super.key});

  @override
  State<JobSeekerScreen> createState() => _JobSeekerSignUpState();
}

class _JobSeekerSignUpState extends State<JobSeekerScreen> {
  final _formKey = GlobalKey<FormState>();

  File? _profileImageFile; // Mobile
  Uint8List? _profileImageWeb; // Web

  File? _certificateFile; // Mobile
  Uint8List? _certificateWeb; // Web

  final picker = ImagePicker();

  String? selectedMajor;
  String? selectedExperience;

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final idController = TextEditingController();
  final aboutController = TextEditingController();
  final passwordController = TextEditingController();

  final supabase = Supabase.instance.client;

  // ---------------- PICK PROFILE IMAGE ----------------
  Future<void> pickProfileImage() async {
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      if (kIsWeb) {
        _profileImageWeb = await picked.readAsBytes();
      } else {
        _profileImageFile = File(picked.path);
      }
      setState(() {});
    }
  }

  // ---------------- PICK CERTIFICATE ----------------
  Future<void> pickCertificate() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'doc', 'docx'],
      withData: kIsWeb, // important for Web
    );

    if (result != null && result.files.single.path != null) {
      if (kIsWeb) {
        _certificateWeb = result.files.single.bytes!;
      } else {
        _certificateFile = File(result.files.single.path!);
      }
      setState(() {});
    }
  }

  // ---------------- SIGN UP ----------------
  Future<void> signUpDirect() async {
    if (!_formKey.currentState!.validate() ||
        selectedMajor == null ||
        selectedExperience == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill all required fields")),
      );
      return;
    }

    try {
      final userId = DateTime.now().millisecondsSinceEpoch.toString();

      // Upload profile image
      String profileUrl = "";
      final profilePath = "$userId/profile.png";
      if (kIsWeb && _profileImageWeb != null) {
        await supabase.storage
            .from('profile-photos')
            .uploadBinary(
              profilePath,
              _profileImageWeb!,
              fileOptions: const FileOptions(upsert: true),
            );
        profileUrl = supabase.storage
            .from('profile-photos')
            .getPublicUrl(profilePath);
      } else if (!kIsWeb && _profileImageFile != null) {
        await supabase.storage
            .from('profile-photos')
            .upload(
              profilePath,
              _profileImageFile!,
              fileOptions: const FileOptions(upsert: true),
            );
        profileUrl = supabase.storage
            .from('profile-photos')
            .getPublicUrl(profilePath);
      }

      // Upload certificate
      String certificateUrl = "";
      final certificatePath = "$userId/certificate.pdf";
      if (kIsWeb && _certificateWeb != null) {
        await supabase.storage
            .from('certificates')
            .uploadBinary(
              certificatePath,
              _certificateWeb!,
              fileOptions: const FileOptions(upsert: true),
            );
        certificateUrl = supabase.storage
            .from('certificates')
            .getPublicUrl(certificatePath);
      } else if (!kIsWeb && _certificateFile != null) {
        await supabase.storage
            .from('certificates')
            .upload(
              certificatePath,
              _certificateFile!,
              fileOptions: const FileOptions(upsert: true),
            );
        certificateUrl = supabase.storage
            .from('certificates')
            .getPublicUrl(certificatePath);
      }

      // Insert into database
      await supabase.from('applicant_profiles').insert({
        'uuid': userId,
        'full_name': nameController.text.trim(),
        'email': emailController.text.trim(),
        'national_id': idController.text.trim(),
        'major': selectedMajor,
        'experience_summary': selectedExperience,
        'bio': aboutController.text.trim(),
        'profile_image': profileUrl,
        'certificate': certificateUrl,
      });

      successDialog();
    } catch (e, st) {
      print("Error: $e");
      print("Stack: $st");
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  void successDialog() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.check_circle, size: 80, color: Color(0xFF73946B)),
            const SizedBox(height: 20),
            const Text(
              "Successfully Registered",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pushReplacementNamed(context, Routes.home);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4CA6A8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
              child: const Text(
                "Continue",
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ---------------- UI ----------------
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEDF2EC),
      appBar: MyAppBar(title: "Sign Up"),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const SizedBox(height: 20),
              Stack(
                children: [
                  GestureDetector(
                    onTap: pickProfileImage,
                    child: CircleAvatar(
                      radius: 60,
                      backgroundImage: kIsWeb
                          ? (_profileImageWeb != null
                                ? MemoryImage(_profileImageWeb!)
                                : const AssetImage("assets/images/logo.png")
                                      as ImageProvider)
                          : (_profileImageFile != null
                                ? FileImage(_profileImageFile!)
                                : const AssetImage("assets/images/logo.png")
                                      as ImageProvider),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: GestureDetector(
                      onTap: pickProfileImage,
                      child: Container(
                        width: 32,
                        height: 32,
                        decoration: const BoxDecoration(
                          color: Color(0xFF73946B),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.add,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              _field("Full Name", "Enter username in English", nameController),
              _field(
                "Email",
                "Enter your email",
                emailController,
                type: TextInputType.emailAddress,
              ),
              _field(
                "ID Number",
                "Enter your national ID",
                idController,
                type: TextInputType.number,
              ),
              _dropdown("Major", selectedMajor, [
                "Computer Science",
                "Information Technology",
                "Software Engineering",
                "AI & Data",
              ], (v) => setState(() => selectedMajor = v)),
              _dropdown(
                "Experience Area",
                selectedExperience,
                [
                  "Mobile Development",
                  "Web Development",
                  "Networking",
                  "Cyber Security",
                ],
                (v) => setState(() => selectedExperience = v),
              ),
              _field("About Me", "Write a short bio", aboutController),
              _label("Certificate"),
              GestureDetector(
                onTap: pickCertificate,
                child: Container(
                  height: 56,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.7),
                    borderRadius: BorderRadius.circular(17),
                    border: Border.all(color: const Color(0xFF4CA6A8)),
                  ),
                  child: Text(
                    (kIsWeb
                            ? (_certificateWeb != null)
                            : (_certificateFile != null))
                        ? "File Selected"
                        : "Upload certificate",
                    style: TextStyle(
                      color: Colors.grey[800],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 25),
              _field(
                "Password",
                "Enter your password",
                passwordController,
                obscure: true,
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: signUpDirect,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4CA6A8),
                  minimumSize: const Size(double.infinity, 48),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40),
                  ),
                ),
                child: const Text(
                  "Sign Up",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _label(String text) => Padding(
    padding: const EdgeInsets.only(bottom: 10),
    child: Align(
      alignment: Alignment.centerLeft,
      child: Text(
        text,
        style: const TextStyle(
          fontFamily: 'JosefinSans',
          fontSize: 25,
          fontWeight: FontWeight.w400,
        ),
      ),
    ),
  );

  Widget _field(
    String label,
    String hint,
    TextEditingController c, {
    bool obscure = false,
    TextInputType? type,
  }) => Padding(
    padding: const EdgeInsets.only(bottom: 25),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _label(label),
        SizedBox(
          height: 56,
          child: TextFormField(
            controller: c,
            obscureText: obscure,
            keyboardType: type,
            validator: (v) => v == null || v.isEmpty ? "$label required" : null,
            style: const TextStyle(fontFamily: 'JosefinSans', fontSize: 16),
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: TextStyle(color: Colors.grey[400]),
              filled: true,
              fillColor: Colors.white.withOpacity(0.7),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 0,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(17),
                borderSide: const BorderSide(
                  color: Color(0xFF4CA6A8),
                  width: 1,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(17),
                borderSide: const BorderSide(
                  color: Color(0xFF4CA6A8),
                  width: 1.5,
                ),
              ),
            ),
          ),
        ),
      ],
    ),
  );

  Widget _dropdown(
    String label,
    String? value,
    List<String> items,
    Function(String?) onChanged,
  ) => Padding(
    padding: const EdgeInsets.only(bottom: 25),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _label(label),
        Container(
          height: 56,
          padding: const EdgeInsets.symmetric(horizontal: 15),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.7),
            borderRadius: BorderRadius.circular(17),
            border: Border.all(color: const Color(0xFF4CA6A8)),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: value,
              hint: const Text("Select"),
              isExpanded: true,
              onChanged: onChanged,
              items: items
                  .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                  .toList(),
            ),
          ),
        ),
      ],
    ),
  );
}
