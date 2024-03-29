import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:machine_test_norq/app/modules/details/controllers/details_controller.dart';

class DetailsView extends GetView<DetailsController> {
  const DetailsView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Hero(
                      tag: 'product-image-${controller.product.id}',
                      child: Image.network(
                        controller.product.image ?? '',
                        height: 300,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 17,
                    left: 3,
                    child: GestureDetector(
                      onTap: () => Get.back(),
                      child: Material(
                        elevation: 2,
                        shape: const CircleBorder(),
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Image.asset(
                            'assets/images/back.png',
                            height: 24.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 50.0),
              Text(
                controller.product.title ?? '',
                style: const TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
                textAlign: TextAlign.start,
              ),
              const SizedBox(height: 2.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    controller.product.category ?? '',
                    style: const TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w500,
                      color: Colors.blueGrey,
                    ),
                    textAlign: TextAlign.start,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '${controller.product.ratingRate ?? '0'}',
                        style: const TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.w500,
                          color: Colors.blueGrey,
                        ),
                      ),
                      const SizedBox(width: 5.0),
                      RatingBar.builder(
                        ignoreGestures: true,
                        itemSize: 15,
                        initialRating:
                            controller.product.ratingRate?.toDouble() ?? 0.0,
                        minRating: 1,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 5,
                        itemPadding:
                            const EdgeInsets.symmetric(horizontal: 4.0),
                        itemBuilder: (context, _) => const Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        unratedColor: Colors.grey[350],
                        onRatingUpdate: (_) {},
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 15.0),
              Obx(() {
                return AnimatedSize(
                  duration: const Duration(
                    milliseconds: 300,
                  ),
                  curve: Curves.easeInOut,
                  child: RichText(
                    key: ValueKey(
                      controller.isExpanded.value ? true : false,
                    ),
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: controller.isExpanded.value
                              ? controller.data
                              : '${controller.data.substring(0, 300)}...',
                          style: const TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                        ),
                        TextSpan(
                          text: controller.isExpanded.value
                              ? ' Hide More'
                              : ' See More',
                          style: const TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              controller.toggleExpansion();
                            },
                        ),
                      ],
                    ),
                  ),
                );
              })
            ],
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(
            left: 16.0,
            top: 8.0,
            right: 16.0,
            bottom: 8.0
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '₹${controller.product.price}',
                style: const TextStyle(
                  fontSize: 30.0,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF7E8BA9),
                ),
                textAlign: TextAlign.start,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              Obx(() {
                return ElevatedButton.icon(
                  onPressed: controller.isLoading.value
                      ? () {}
                      : controller.isSuccess.value
                          ? controller.navigateToCart
                          : controller.addToCart,
                  icon: controller.isLoading.value
                      ? SizedBox(
                          height: 24.0,
                          width: 24.0,
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                              Theme.of(context).colorScheme.primary,
                            ),
                          ),
                        )
                      : Image.asset(
                          'assets/images/cart.png',
                          height: 24.0,
                          width: 24.0,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                  label: Text(
                    controller.isLoading.value
                        ? 'Adding to Cart...'
                        : controller.isSuccess.value
                            ? 'Go To Cart'
                            : 'Add To Cart',
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
