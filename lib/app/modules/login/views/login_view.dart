import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:machine_test_norq/app/modules/login/controllers/login_controller.dart';
import 'package:machine_test_norq/app/routes/app_pages.dart';
import 'package:machine_test_norq/app/widgets/app_textfield.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                const Text(
                  'Login',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24.0,
                  ),
                ),
                const SizedBox(height: 30.0),
                AppTextField(
                  controller: controller.loginController,
                  hintText: 'Email',
                  icon: 'assets/images/email.png',
                ),
                const SizedBox(height: 15.0),
                Obx(() {
                  return AppTextField(
                    controller: controller.passwordController,
                    hintText: 'Password',
                    icon: 'assets/images/lock.png',
                    obscureText: controller.showPassword.value,
                    isPasswordField: true,
                    showHidePassword: () =>
                        controller.togglePasswordVisibility(),
                  );
                }),
                const SizedBox(height: 30.0),
                Obx(() {
                  return ElevatedButton(
                    onPressed: controller.isLoading.value
                        ? () {}
                        : () {
                            controller.checkValidation();
                          },
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(
                        controller.isLoading.value ? 30 : double.infinity,
                        45.0,
                      ),
                    ),
                    child: controller.isLoading.value
                        ? SizedBox(
                            height: 24.0,
                            width: 24.0,
                            child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(
                                Theme.of(context).colorScheme.primary,
                              ),
                            ),
                          )
                        : const Text('Login'),
                  );
                }),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () => Get.toNamed(Routes.signUp),
            child: const Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: "Don't have an account?",
                  ),
                  TextSpan(
                    text: ' SignUp',
                    style: TextStyle(
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
