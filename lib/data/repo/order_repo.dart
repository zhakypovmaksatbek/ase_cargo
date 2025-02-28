import 'package:ase/core/dio_settings.dart';
import 'package:ase/data/models/order_model.dart';
import 'package:ase/data/models/request_detail_model.dart';
import 'package:ase/data/models/request_model.dart';

final class OrderRepo implements IOrderRepo {
  final DioSettings _dio = DioSettings();
  @override
  Future<OrderPaginationModel> getOrders(int page) async {
    final response =
        await _dio.get("v1/logistics/orders/", queryParameters: {"page": page});
    return OrderPaginationModel.fromJson(response.data);
  }

  @override
  Future<RequestPaginationModel> getRequests(int page) async {
    final response = await _dio
        .get("v1/logistics/preorders/", queryParameters: {"page": page});
    return RequestPaginationModel.fromJson(response.data);
  }

  @override
  Future<RequestDetailModel> getRequestDetail(int id) async {
    final response = await _dio.get("v1/logistics/preorders/$id/");
    return RequestDetailModel.fromJson(response.data);
  }
}

abstract class IOrderRepo {
  Future<RequestPaginationModel> getRequests(int page);
  Future<OrderPaginationModel> getOrders(int page);
  Future<RequestDetailModel> getRequestDetail(int id);
}
