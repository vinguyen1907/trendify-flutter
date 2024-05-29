import 'package:ecommerce_app/models/shipping_address.dart';
import 'package:ecommerce_app/constants/constants.dart';
import 'package:ecommerce_app/repositories/interfaces/interfaces.dart';

class AddressRepository implements IAddressRepository {
  @override
  Future<List<ShippingAddress>> fetchShippingAddresses() async {
    try {
      final snapshot = await usersRef
          .doc(firebaseAuth.currentUser!.uid)
          .collection("addresses")
          .get();

      return snapshot.docs.map((doc) {
        ShippingAddress address = ShippingAddress.fromMap(doc.data());
        address = address.copyWith(id: doc.id);
        return address;
      }).toList();
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<void> addShippingAddress(
      {required ShippingAddress address, bool? setAsDefault}) async {
    try {
      await usersRef
          .doc(firebaseAuth.currentUser!.uid)
          .collection("addresses")
          .doc()
          .set(address.toMap());

      if (setAsDefault == true) {
        await updateDefaultShippingAddress(address: address);
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<void> updateDefaultShippingAddress(
      {required ShippingAddress address}) async {
    try {
      await usersRef
          .doc(firebaseAuth.currentUser!.uid)
          .update({"defaultShippingAddress": address.toMap()});
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<void> updateShippingAddress(
      {required ShippingAddress address, bool? setAsDefault}) async {
    try {
      await usersRef
          .doc(firebaseAuth.currentUser!.uid)
          .collection("addresses")
          .doc(address.id)
          .update(address.toMap());

      if (setAsDefault == true) {
        await updateDefaultShippingAddress(address: address);
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<void> deleteAddress({required String addressId}) async {
    try {
      await usersRef
          .doc(firebaseAuth.currentUser!.uid)
          .collection("addresses")
          .doc(addressId)
          .delete();
    } catch (e) {
      throw Exception(e);
    }
  }
}
