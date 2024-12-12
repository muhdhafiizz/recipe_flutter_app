import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';

class ProfileController with ChangeNotifier {
  final ImagePicker _imagePicker = ImagePicker();
  String? _profileImageUrl;

  String? get profileImageUrl => _profileImageUrl;

  Locale _locale = const Locale("en");

  Locale get locale => _locale;

  void switchLanguage(int index) {
    _locale = index == 0 ? const Locale("en") : const Locale("ms");
    notifyListeners();
  }

  Future<void> updateProfilePicture(BuildContext context) async {
    try {
      final XFile? image = await _imagePicker.pickImage(source: ImageSource.gallery);

      if (image == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("No image selected")),
        );
        return;
      }

      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("User not signed in")),
        );
        return;
      }

      final storageRef = FirebaseStorage.instance
          .ref()
          .child('profile_pictures/${user.uid}.jpg');
      await storageRef.putFile(File(image.path));

      final imageUrl = await storageRef.getDownloadURL();
      await user.updatePhotoURL(imageUrl);
      await user.reload();

      _profileImageUrl = imageUrl;
      notifyListeners();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Profile picture updated successfully")),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error updating profile picture: $e")),
      );
    }
  }
}
