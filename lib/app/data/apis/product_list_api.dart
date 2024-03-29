import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:machine_test_norq/app/data/models/product_model.dart';

class ProductListApi {
  Future<ProductListModel?> getProductsList() async {
    try {
      Response response = await Dio().get(
        'https://fakestoreapi.com/products',
      );
      debugPrint('LoginAPI response is $response');

      if (response.statusCode! >= 200 && response.statusCode! <= 299) {
        ProductListModel productListModel =
            ProductListModel.fromJson({'data': response.data});

        /// Insert products into database
        await ProductListModel.fromJsonWithDatabaseInsert(productListModel);
        return productListModel;
      } else {
        return null;
      }
    } catch (e) {
      debugPrint('getProductsList catch is $e');
      return null;
    }
  }
}
