import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:machine_test_norq/app/routes/app_pages.dart';
import 'package:machine_test_norq/app/widgets/app_snackbar.dart';

class SignUpController extends GetxController {
  final TextEditingController loginController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmController = TextEditingController();

  final showPassword = false.obs;
  final showConfirmPassword = false.obs;

  final isLoading = false.obs;

  void checkValidation() {
    if (loginController.text.trim().isEmpty) {
      AppSnackbar.showSnackbar(
        'Error!',
        'Email field is required',
      );
    } else if (!loginController.text.trim().isEmail) {
      AppSnackbar.showSnackbar(
        'Error!',
        'Email format is incorrect',
      );
    } else if (passwordController.text.trim().isEmpty) {
      AppSnackbar.showSnackbar(
        'Error!',
        'Password field is required',
      );
    } else if (passwordController.text.trim().length < 6) {
      AppSnackbar.showSnackbar(
        'Error!',
        'Password should contain more than 6 characters',
      );
    } else if (confirmController.text.trim().isEmpty ||
        confirmController.text.trim() != passwordController.text.trim()) {
      AppSnackbar.showSnackbar(
        'Error!',
        'Password mismatched',
      );
    } else {
      firebaseSignUp();
    }
  }

  Future<void> firebaseSignUp() async {
    isLoading.value = true;
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: loginController.text.trim(),
        password: passwordController.text.trim(),
      );

      isLoading.value = false;
      final box = GetStorage();
      box.write('loggedIn', true);
      Get.offAllNamed(Routes.home);
    } on FirebaseAuthException catch (e) {
      isLoading.value = false;
      if (e.code == 'weak-password') {
        AppSnackbar.showSnackbar(
          'Error',
          'The password provided is too weak',
        );
      } else if (e.code == 'email-already-in-use') {
        AppSnackbar.showSnackbar(
          'Error',
          'An account already exists with that email',
        );
      }
    } catch (e) {
      AppSnackbar.showSnackbar(
        'Failed',
        '$e',
      );
    }
  }

  void togglePasswordVisibility() {
    showPassword.value = !showPassword.value;
  }

  void toggleConfirmPasswordVisibility() {
    showConfirmPassword.value = !showConfirmPassword.value;
  }
}
