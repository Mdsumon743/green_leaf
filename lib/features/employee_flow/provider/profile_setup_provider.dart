import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:image_picker/image_picker.dart';

class ProfileSetUpState {
  final File? profileImage;
  final String? gender;
  final DateTime? dateOfBirth;
  final String bio;
  final String address;
  final List<String> skills;
  final String? experience;
  final File? certificationFile;
  final bool isLoading;

  const ProfileSetUpState({
    this.profileImage,
    this.gender,
    this.dateOfBirth,
    this.bio = '',
    this.address = '',
    this.skills = const [],
    this.experience,
    this.certificationFile,
    this.isLoading = false,
  });

  ProfileSetUpState copyWith({
    File? profileImage,
    String? gender,
    DateTime? dateOfBirth,
    String? bio,
    String? address,
    List<String>? skills,
    String? experience,
    File? certificationFile,
    bool? isLoading,
    bool clearProfileImage = false,
    bool clearCertification = false,
  }) {
    return ProfileSetUpState(
      profileImage:
      clearProfileImage ? null : (profileImage ?? this.profileImage),
      gender: gender ?? this.gender,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      bio: bio ?? this.bio,
      address: address ?? this.address,
      skills: skills ?? this.skills,
      experience: experience ?? this.experience,
      certificationFile: clearCertification
          ? null
          : (certificationFile ?? this.certificationFile),
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

// ─── Notifier ─────────────────────────────────────────────────────────────────

class ProfileSetUpNotifier extends StateNotifier<ProfileSetUpState> {
  ProfileSetUpNotifier() : super(const ProfileSetUpState());

  final ImagePicker _picker = ImagePicker();

  // Controllers live in the notifier so ConsumerWidget stays stateless
  final TextEditingController bioController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController employeeCodeController = TextEditingController();
  final TextEditingController skillController = TextEditingController();

  @override
  void dispose() {
    bioController.dispose();
    addressController.dispose();
    skillController.dispose();
    super.dispose();
  }

  // ── Image / File ────────────────────────────────────────────────────────────

  Future<void> pickImageFromCamera() async {
    final XFile? file =
    await _picker.pickImage(source: ImageSource.camera, imageQuality: 85);
    if (file != null) state = state.copyWith(profileImage: File(file.path));
  }

  Future<void> pickImageFromGallery() async {
    final XFile? file =
    await _picker.pickImage(source: ImageSource.gallery, imageQuality: 85);
    if (file != null) state = state.copyWith(profileImage: File(file.path));
  }

  Future<void> pickCertification() async {
    // Swap ImagePicker for file_picker if you need real PDF support:
    // final result = await FilePicker.platform.pickFiles(
    //   type: FileType.custom, allowedExtensions: ['jpg', 'png', 'pdf']);
    final XFile? file =
    await _picker.pickImage(source: ImageSource.gallery, imageQuality: 90);
    if (file != null) state = state.copyWith(certificationFile: File(file.path));
  }

  void removeCertification() => state = state.copyWith(clearCertification: true);

  // ── Field Setters ────────────────────────────────────────────────────────────

  void setGender(String gender) => state = state.copyWith(gender: gender);

  void setDateOfBirth(DateTime date) =>
      state = state.copyWith(dateOfBirth: date);

  void setBio(String bio) => state = state.copyWith(bio: bio);

  void setAddress(String address) => state = state.copyWith(address: address);

  void addSkill(String skill) {
    if (skill.trim().isNotEmpty && !state.skills.contains(skill.trim())) {
      state = state.copyWith(skills: [...state.skills, skill.trim()]);
    }
    skillController.clear();
  }

  void removeSkill(String skill) => state = state.copyWith(
      skills: state.skills.where((s) => s != skill).toList());

  void setExperience(String experience) =>
      state = state.copyWith(experience: experience);

  // ── Submit ───────────────────────────────────────────────────────────────────

  Future<void> submit() async {
    state = state.copyWith(isLoading: true);
    // TODO: call your repository / API here
    await Future.delayed(const Duration(seconds: 2));
    state = state.copyWith(isLoading: false);
  }
}

// ─── Provider ─────────────────────────────────────────────────────────────────

final profileSetUpProvider =
StateNotifierProvider.autoDispose<ProfileSetUpNotifier, ProfileSetUpState>(
      (ref) => ProfileSetUpNotifier(),
);