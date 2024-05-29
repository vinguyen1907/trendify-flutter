import 'package:ecommerce_app/models/models.dart';

abstract class IAddressRepository {
  Future<List<ShippingAddress>> fetchShippingAddresses();
  Future<void> addShippingAddress({required ShippingAddress address, bool? setAsDefault});
  Future<void> updateDefaultShippingAddress({required ShippingAddress address});
  Future<void> updateShippingAddress({required ShippingAddress address, bool? setAsDefault});
  Future<void> deleteAddress({required String addressId});
}
