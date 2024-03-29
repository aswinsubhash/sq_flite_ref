import 'package:get/get.dart';
import 'package:machine_test_norq/app/data/db/app_db.dart';
import 'package:machine_test_norq/app/data/models/product_model.dart';
import 'package:machine_test_norq/app/routes/app_pages.dart';
import 'package:machine_test_norq/app/widgets/app_snackbar.dart';

class DetailsController extends GetxController {
  ProductModel product = Get.arguments['product'];

  Rx<bool> isExpanded = false.obs;

  String data = '';

  @override
  void onInit() {
    data =
        "${product.description}. Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum. It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for 'lorem ipsum' will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like)";
    super.onInit();
  }

  void toggleExpansion() {
    isExpanded.value = !isExpanded.value;
  }

  final isLoading = false.obs;
  final isSuccess = false.obs;

  void addToCart() async {
    isLoading(true);

    try {
      // Add the product to the cart database
      await CartDatabaseProvider().addToCartInDatabase(product);

      // Simulate an API call
      await Future.delayed(const Duration(seconds: 2));

      isLoading(false);
      AppSnackbar.showSnackbar(
        'Success',
        'Successfully added to cart!',
      );
      isSuccess(true);
    } catch (error) {
      // If adding to cart fails
      isLoading(false);
      AppSnackbar.showSnackbar(
        'Error',
        'Error adding to cart. Please try again later',
      );
    }
  }

  /// function to navigate to cart page
  void navigateToCart() {
    Get.toNamed(
      Routes.cart,
    );
  }
}
