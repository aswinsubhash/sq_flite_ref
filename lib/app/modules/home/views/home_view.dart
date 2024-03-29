import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:machine_test_norq/app/modules/home/controllers/home_controller.dart';
import 'package:machine_test_norq/app/widgets/app_shimmer.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () => controller.showLogoutDialog(),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100.0),
                      child: Image.asset(
                        'assets/images/avatar.png',
                        height: 35.0,
                        width: 35.0,
                      ),
                    ),
                  ),
                  Obx(() {
                    return GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () => controller.navigateToCart(),
                      child: Badge.count(
                        count: controller.productList
                            .where((item) => (item.quantity ?? 0) >= 1)
                            .toList()
                            .length,
                        offset: const Offset(3, 1),
                        isLabelVisible: controller.productList
                            .where((item) => (item.quantity ?? 0) >= 1)
                            .toList()
                            .isNotEmpty,
                        child: Image.asset(
                          'assets/images/cart.png',
                          height: 30.0,
                          width: 30.0,
                        ),
                      ),
                    );
                  }),
                ],
              ),
              const SizedBox(height: 15.0),
              SizedBox(
                height: 45.0,
                child: TextField(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: 'Search',
                    prefixIcon: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Image.asset(
                        'assets/images/search.png',
                        height: 12.0,
                        width: 12.0,
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 12.0,
                      horizontal: 16.0,
                    ),
                  ),
                  textInputAction: TextInputAction.search,
                ),
              ),
              const SizedBox(height: 5.0),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.only(top: 15.0),
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'TRENDING PRODUCTS',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 10.0),
                      Obx(() {
                        return controller.productList.isEmpty
                            ? const AppShimmer()
                            : GridView.builder(
                                physics: const ClampingScrollPhysics(),
                                shrinkWrap: true,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  childAspectRatio: .75,
                                  crossAxisSpacing: 10.0,
                                  mainAxisSpacing: 10.0,
                                ),
                                itemCount: controller.productList.length,
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    behavior: HitTestBehavior.opaque,
                                    onTap: () {
                                      controller.navigateToDetails(
                                        product: controller.productList[index],
                                      );
                                    },
                                    child: Stack(
                                      children: [
                                        Card(
                                          elevation: 0.75,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20.0),
                                          ),
                                          child: Container(
                                            padding: const EdgeInsets.all(4.0),
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(20.0),
                                            ),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Align(
                                                  alignment: Alignment.center,
                                                  child: Hero(
                                                    tag:
                                                        'product-image-${controller.productList[index].id}',
                                                    child: Image.network(
                                                      controller
                                                              .productList[
                                                                  index]
                                                              .image ??
                                                          '',
                                                      height: 150,
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(height: 15.0),
                                                Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                    horizontal: 8.0,
                                                  ),
                                                  child: Text(
                                                    controller
                                                            .productList[index]
                                                            .title ??
                                                        '',
                                                    style: const TextStyle(
                                                      fontSize: 14.0,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: Colors.black,
                                                    ),
                                                    textAlign: TextAlign.start,
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                    left: 8.0,
                                                    right: 8.0,
                                                    top: 7.0,
                                                  ),
                                                  child: Text(
                                                    '₹${controller.productList[index].price}',
                                                    style: const TextStyle(
                                                      fontSize: 22.0,
                                                      fontWeight:
                                                          FontWeight.w100,
                                                      color: Color(0xFF7E8BA9),
                                                    ),
                                                    textAlign: TextAlign.start,
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          bottom: 15,
                                          right: 15,
                                          child: InkWell(
                                            onTap: () {
                                              controller.addToCart(
                                                controller.productList[index],
                                              );
                                            },
                                            child: Material(
                                              elevation: 2,
                                              shape: const CircleBorder(),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(5.0),
                                                child: AnimatedContainer(
                                                  duration: const Duration(
                                                      milliseconds: 300),
                                                  decoration:
                                                      const BoxDecoration(
                                                    shape: BoxShape.circle,
                                                  ),
                                                  child: Image.asset(
                                                    'assets/images/cart.png',
                                                    height: 24.0,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              );
                      }),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
