import 'package:ase/core/dio_settings.dart';
import 'package:ase/data/models/order_detail_model.dart';
import 'package:ase/data/models/order_model.dart';
import 'package:ase/data/models/request_detail_model.dart';
import 'package:ase/data/models/request_model.dart';
import 'package:ase/presentation/pages/order/options/order_options.dart';
import 'package:ase/presentation/pages/profile/views/order/options/order_options.dart';

final class OrderRepo implements IOrderRepo {
  final DioSettings _dio = DioSettings();
  @override
  Future<OrderPaginationModel> getOrders(int page,
      {ShipmentOption? option, OrderStatus? status}) async {
    final response = await _dio.get("v1/logistics/orders/", queryParameters: {
      "page": page,
      "user_role": option?.name,
      "status": status?.value
    });
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

  @override
  Future<OrderDetailModel> getOrderDetail(String number) async {
    final response = await _dio.get("v1/logistics/orders/$number/");
    return OrderDetailModel.fromJson(response.data);
  }
}

abstract class IOrderRepo {
  Future<RequestPaginationModel> getRequests(int page);
  Future<OrderPaginationModel> getOrders(int page,
      {required ShipmentOption option, OrderStatus? status});
  Future<RequestDetailModel> getRequestDetail(int id);
  Future<OrderDetailModel> getOrderDetail(String number);
}
