import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:machine_test_norq/app/modules/cart/controllers/cart_controller.dart';
import 'package:machine_test_norq/app/widgets/cart_count_button.dart';

class CartView extends GetView<CartController> {
  const CartView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF7F7F7),
        title: const Text(
          'CART',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
        leadingWidth: 60,
        leading: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: GestureDetector(
            onTap: () => Get.back(),
            child: Row(
              children: [
                const SizedBox(width: 5),
                Material(
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
              ],
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: Obx(() {
          return controller.productList.isEmpty
              ? Center(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Lottie.asset('assets/json/empty_cart.json'),
                        const SizedBox(height: 10.0),
                        const Text(
                          'Cart is empty! Please add some items',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0,
                          ),
                          textAlign: TextAlign.center,
                        )
                      ],
                    ),
                  ),
                )
              : ListView.separated(
                  padding: const EdgeInsets.all(16.0),
                  itemCount: controller.productList.length,
                  itemBuilder: (context, index) {
                    return Stack(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16.0,
                            vertical: 8.0,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: Row(
                            children: [
                              Image.network(
                                controller.productList[index].image ?? '',
                                height: 150.0,
                                width: 100.0,
                              ),
                              const SizedBox(width: 15.0),
                              Flexible(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      controller.productList[index].title ?? '',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14.0,
                                      ),
                                    ),
                                    Text(
                                      controller.productList[index].category ??
                                          '',
                                      style: const TextStyle(
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.blueGrey,
                                      ),
                                      textAlign: TextAlign.start,
                                    ),
                                    Text(
                                      '₹${controller.productList[index].price}',
                                      style: const TextStyle(
                                        fontSize: 22.0,
                                        fontWeight: FontWeight.w100,
                                        color: Color(0xFF7E8BA9),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          right: 16,
                          bottom: 8,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              CartCountButton(
                                isIncrement: false,
                                isDelete:
                                    (controller.productList[index].quantity ??
                                            0) ==
                                        1,
                                onTap: () {
                                  if (controller.productList[index].id !=
                                      null) {
                                    if ((controller
                                                .productList[index].quantity ??
                                            0) ==
                                        1) {
                                      showDeleteDialog(index);
                                    } else {
                                      controller.removeFromCart(
                                        controller.productList[index],
                                      );
                                    }
                                  }
                                },
                              ),
                              const SizedBox(width: 10.0),
                              Text(
                                '${controller.productList[index].quantity}',
                                style: const TextStyle(
                                    fontWeight: FontWeight.w600),
                              ),
                              const SizedBox(width: 10.0),
                              CartCountButton(
                                isIncrement: true,
                                onTap: () {
                                  controller.addToCart(
                                    controller.productList[index],
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                  separatorBuilder: (_, __) {
                    return const SizedBox(height: 10.0);
                  },
                );
        }),
      ),
      bottomNavigationBar: Obx(() {
        return controller.productList.isEmpty
            ? const SizedBox.shrink()
            : SafeArea(
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
                      Flexible(
                        child: Obx(() {
                          return Text(
                            '₹${controller.total.toStringAsFixed(2)}',
                            style: const TextStyle(
                              fontSize: 30.0,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF7E8BA9),
                            ),
                            textAlign: TextAlign.start,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          );
                        }),
                      ),
                      ElevatedButton.icon(
                        onPressed: () {},
                        icon: Image.asset(
                          'assets/images/checkout.png',
                          height: 24.0,
                          width: 24.0,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        label: const Text(
                          'Checkout',
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ),
                ),
              );
      }),
    );
  }

  void showDeleteDialog(int index) {
    Get.dialog(
      AlertDialog(
        title: const Text('Delete this item?'),
        content: const Text('This cannot be undone'),
        actions: <Widget>[
          TextButton(
            child: const Text("Cancel"),
            onPressed: () {
              Get.back();
            },
          ),
          TextButton(
            onPressed: () {
              controller.deleteFromCart(
                controller.productList[index],
              );
              Get.back();
            },
            child: const Text(
              'Delete',
              style: TextStyle(
                color: Colors.red,
              ),
            ),
          ),
        ],
      ),
      barrierDismissible: false,
    );
  }
}
