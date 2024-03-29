import 'package:get/get.dart';
import 'package:machine_test_norq/app/data/db/app_db.dart';
import 'package:machine_test_norq/app/data/models/product_model.dart';
import 'package:machine_test_norq/app/widgets/app_snackbar.dart';

class CartController extends GetxController {
  final productList = <ProductModel>[].obs;
  Rx<num> total = 0.0.obs;

  @override
  void onInit() {
    loadProductsFromDatabase();

    super.onInit();
  }

  /// Fetch products from the database
  Future<void> loadProductsFromDatabase() async {
    productList.clear();
    final cartProvider = CartDatabaseProvider();
    final cartItems = await cartProvider.getDbItems();
    for (var element in cartItems) {
      if ((element.quantity ?? 0) > 0) {
        productList.add(element);
      }
    }
    _getTotal();
  }

  Future<void> _getTotal() async {
    total.value = 0.0; // Reset total to 0 before recalculating
    for (var element in productList) {
      total.value += element.quantity! * element.price!;
    }
  }

  Future<void> addToCart(ProductModel product) async {
    try {
      // Add the product to the cart database
      await CartDatabaseProvider().addToCartInDatabase(product);
      await loadProductsFromDatabase();
      _getTotal();
    } catch (error) {
      AppSnackbar.showSnackbar(
        'Error',
        'Error adding to cart. Please try again later',
      );
    }
  }

  Future<void> removeFromCart(ProductModel product) async {
    try {
      // Add the product to the cart database
      await CartDatabaseProvider().removeFromCartInDatabase(product.id!);
      await loadProductsFromDatabase();
      _getTotal();
    } catch (error) {
      AppSnackbar.showSnackbar(
        'Error',
        'Error removing from cart. Please try again later',
      );
    }
  }

  Future<void> deleteFromCart(ProductModel product) async {
    try {
      await CartDatabaseProvider().removeFromCart(product.id!);
      await loadProductsFromDatabase();
      _getTotal();
      AppSnackbar.showSnackbar(
        'Success',
        'Successfully removed from cart',
      );
    } catch (e) {
      AppSnackbar.showSnackbar(
        'Error',
        'Error deleting from cart. Please try again later',
      );
    }
  }
}
