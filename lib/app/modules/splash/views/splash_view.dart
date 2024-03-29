import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:machine_test_norq/app/modules/splash/controllers/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.asset(
                'assets/json/splash.json',
                height: 200.0,
                width: 200.0,
              ),
              const SizedBox(height: 15.0),
              Text(
                controller.text,
                style: const TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF00B6E8),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
