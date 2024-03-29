import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:machine_test_norq/app/routes/app_pages.dart';
import 'package:machine_test_norq/app/widgets/app_snackbar.dart';

class LoginController extends GetxController {
  final TextEditingController loginController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final showPassword = false.obs;

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
    } else {
      firebaseLogin();
    }
  }

  Future<void> firebaseLogin() async {
    isLoading.value = true;
    Future.delayed(const Duration(seconds: 3), () async {
      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: loginController.text.trim(),
          password: passwordController.text.trim(),
        );
        isLoading.value = false;
        final box = GetStorage();
        box.write('loggedIn', true);
        Get.offAllNamed(Routes.home);
      } on FirebaseAuthException catch (e) {
        isLoading.value = false;
        if (e.code == 'INVALID_LOGIN_CREDENTIALS') {
          AppSnackbar.showSnackbar(
            'Error',
            'Invalid login credentials',
          );
        } else {
          AppSnackbar.showSnackbar(
            'Error',
            e.code,
          );
        }
      } catch (e) {
        AppSnackbar.showSnackbar(
          'Failed',
          '$e',
        );
      }
    });
  }

  void togglePasswordVisibility() {
    showPassword.value = !showPassword.value;
  }
}
