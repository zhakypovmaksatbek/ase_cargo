import 'package:ase/core/dio_settings.dart';
import 'package:ase/data/models/box_model.dart';
import 'package:ase/data/models/signature_model.dart';

final class CourierRepo extends ICourierRepo {
  final dio = DioSettings();
  @override
  Future<BoxPaginationModel> getBox(CourierOrderStatus status) async {
    final response = await dio.get("v1/courier/box/", queryParameters: {
      "status": status.name,
    });
    return BoxPaginationModel.fromJson(response.data);
  }

  @override
  Future<void> addOrder(String boxCode) async {
    final response = await dio.post("v1/courier/box/add/$boxCode");
    return response.data;
  }

  @override
  Future<void> cancelOrder(String orderCode, String reason) async {
    final response = await dio.post(
      "v1/courier/box/cancel-order/$orderCode",
      data: {"reason": reason},
    );
    return response.data;
  }

  @override
  Future<void> deleteOrder(String boxCode, String reason) async {
    final response = await dio.delete(
      "v1/courier/box/remove-order/$boxCode",
      data: {"reason": reason},
    );
    return response.data;
  }

  @override
  Future<void> doneOrder(String orderCode, SignatureModel signature) async {
    final formData = await signature.toFormData();
    final response = await dio.post("v1/courier/box/set-order-done/$orderCode/",
        data: formData, isFormData: true);
    return response.data;
  }

  @override
  Future<BoxPaginationModel> getOrderHistory({int page = 1}) async {
    final response = await dio.get("v1/courier/history/", queryParameters: {
      "page": page,
    });
    return BoxPaginationModel.fromJson(response.data);
  }

  @override
  Future<BoxModel> searOrder(String orderCode) async {
    final response = await dio.get("v1/courier/search-orders/$orderCode");
    return BoxModel.fromJson(response.data);
  }
}

abstract class ICourierRepo {
  Future<BoxPaginationModel> getBox(CourierOrderStatus status);
  Future<void> addOrder(String boxCode);
  Future<void> deleteOrder(String boxCode, String reason);
  Future<void> cancelOrder(String orderCode, String reason);
  Future<void> doneOrder(String orderCode, SignatureModel signature);
  Future<BoxPaginationModel> getOrderHistory({int page});
  Future<BoxModel> searOrder(String orderCode);
}

enum CourierOrderStatus { active, cancelled }
