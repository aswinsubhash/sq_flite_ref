import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:machine_test_norq/app/data/apis/product_list_api.dart';
import 'package:machine_test_norq/app/data/db/app_db.dart';
import 'package:machine_test_norq/app/data/models/product_model.dart';
import 'package:machine_test_norq/app/routes/app_pages.dart';
import 'package:machine_test_norq/app/widgets/app_snackbar.dart';

class HomeController extends GetxController {
  final productList = <ProductModel>[].obs;

  @override
  void onInit() {
    checkDataInDatabase();
    super.onInit();
  }

  /// Check if data exists in the database
  void checkDataInDatabase() async {
    final cartProvider = CartDatabaseProvider();
    final hasData = await cartProvider.hasData();
    if (hasData) {
      // Data exists in the database, load it
      loadProductsFromDatabase();
    } else {
      // No data in the database, fetch from API
      callProductListApi();
    }
  }

  /// Fetch products from the database
  Future<void> loadProductsFromDatabase() async {
    final cartProvider = CartDatabaseProvider();
    final cartItems = await cartProvider.getDbItems();
    productList.assignAll(cartItems);
  }

  /// Call productList API
  Future<void> callProductListApi() async {
    ProductListModel? response = await ProductListApi().getProductsList();

    if (response != null) {
      if (response.productList != null) {
        productList.value = response.productList ?? [];
      } else {
        // Handle empty response
      }
    } else {
      // Handle error
    }
  }

  Future<void> addToCart(ProductModel product) async {
    try {
      // Add the product to the cart database
      await CartDatabaseProvider().addToCartInDatabase(product);
      await loadProductsFromDatabase();
      AppSnackbar.showSnackbar(
        'Success',
        'Successfully added to cart!',
      );
    } catch (error) {
      AppSnackbar.showSnackbar(
        'Error',
        'Error adding to cart. Please try again later',
      );
    }
  }

  /// function to navigate to details page
  void navigateToDetails({required ProductModel product}) {
    Get.toNamed(
      Routes.details,
      arguments: {
        'product': product,
      },
    )?.whenComplete(() {
      checkDataInDatabase();
    });
  }

  /// function to navigate to cart page
  void navigateToCart() {
    Get.toNamed(
      Routes.cart,
    )?.whenComplete(() {
      checkDataInDatabase();
    });
  }

  void showLogoutDialog() {
    Get.dialog(
      AlertDialog(
        title: const Text('Logout'),
        content: const Text('Sure to logout?'),
        actions: <Widget>[
          TextButton(
            child: const Text("Cancel"),
            onPressed: () {
              Get.back();
            },
          ),
          TextButton(
            onPressed: () {
              Get.back();

              FirebaseAuth.instance.signOut().then((value) {
                final box = GetStorage();
                box.remove('loggedIn');
                Get.offAllNamed(Routes.login);
              });
            },
            child: const Text(
              'Logout',
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
