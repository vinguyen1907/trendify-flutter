import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class PushDataScreen extends StatelessWidget {
  PushDataScreen({super.key});
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            ElevatedButton(
                onPressed: () async {
                  // await LocalNotificationService.showNotification();
                },
                child: const Text("Push"))
          ],
        ),
      ),
    );
  }

  Future<void> pushJsonDataToFirestore() async {
    await firestore.collection("products").get().then((value) async {
      for (var element in value.docs) {
        firestore
            .collection("products")
            .doc(element.id)
            .update({'createdAt': generateRandomDate()});
      }
    });
    // Load JSON data from assets
    // final String jsonData =
    //     await rootBundle.loadString('assets/data/data.json');
    // final data = json.decode(jsonData);

    // Loop through each JSON object and push to Firestore
    // for (final jsonEntry in jsonList) {
    //   final JsonData jsonData = JsonData.fromJson(jsonEntry);
    // final List<Map<String, dynamic>> products = data['products'];
    // final List<dynamic> categories =
    //     data['categories'].cast<Map<String, dynamic>>();
    // final List<dynamic> products =
    //     data['products'].cast<Map<String, dynamic>>();
    // final List<dynamic> productDetails =
    //     data['productDetails'].cast<Map<String, dynamic>>();
    // // final List<dynamic> promotions =
    // //     data['promotion'].cast<Map<String, dynamic>>();
    // //
    // for (final x in productDetails) {
    //   _pushData(x);
    // }

    // await firestore.collection('products').get().then((value) async {
    //   for (int i = 0; i < value.size; i++) {
    //     for (int y = 0; y < productDetails.length; y++) {
    //       await firestore
    //           .collection("products")
    //           .doc(value.docs[i].id)
    //           .collection("productDetails")
    //           .add({
    //         'size': productDetails[i]['size'],
    //         'color': productDetails[i]['color'],
    //         'stock': productDetails[i]['stock'],
    //       });
    //     }
    //   }
    // });

    // for (int i = 0; i < promotions.length; i++) {
    //   try {
    //     await firestore.collection('promotions').add({
    //       "code": promotions[i]['code'],
    //       "content": promotions[i]['content'],
    //       "imgUrl": promotions[i]['imgUrl'],
    //       "amount": promotions[i]['amount'],
    //       "type": promotions[i]['type'],
    //       "minimumOrderValue": promotions[i]['minimumOrderValue'],
    //       "maximumDiscount": promotions[i]['maximumDiscount'],
    //       "startDate": DateTime.now(),
    //       "endDate": DateTime.now(),
    //     }).then((value) => firestore
    //         .collection('promotions')
    //         .doc(value.id)
    //         .update({'id': value.id}));
    //     print('Data pushed to Firestore: ${promotions[i]['code']}');
    //   } catch (error) {
    //     print('Error pushing data to Firestore: $error');
    //   }
    // }

    // for (int i = 0; i < products.length; i++) {
    //   try {
    //     await firestore.collection('products').add({
    //       "name": products[i]['name'],
    //       "brand": products[i]['brand'],
    //       "description": products[i]['description'],
    //       "price": products[i]['price'],
    //       "categoryId": products[i]['categoryId'],
    //       "averageRating": 0,
    //       "reviewCount": 0,
    //       "imgUrl": products[i]['imgUrl'],
    //     }).then((value) => firestore
    //         .collection('products')
    //         .doc(value.id)
    //         .update({'id': value.id}));
    //     print('Data pushed to Firestore: ${products[i]['name']}');
    //   } catch (error) {
    //     print('Error pushing data to Firestore: $error');
    //   }
    // }

    // for (int i = 0; i < categories.length; i++) {
    //   try {
    //     await firestore.collection('categories').add({
    //       "name": categories[i]['name'],
    //       "imgUrl": categories[i]['imgUrl'],
    //       "productCount": 10,
    //     });
    //     print('Data pushed to Firestore: ${categories[i]['name']}');
    //   } catch (error) {
    //     print('Error pushing data to Firestore: $error');
    //   }
    // }
  }

  //
  Future<void> _pushData(dynamic x) async {
    firestore
        .collection('products')
        .where('categoryId', isEqualTo: x['categoryId'])
        .get()
        .then((value) {
      for (var element in value.docs) {
        firestore
            .collection('products')
            .doc(element.id)
            .collection("productDetails")
            .add({
          'size': x['size'],
          'color': x['color'],
          'stock': x['stock'],
        });
      }
    });
  }

  DateTime generateRandomDate() {
    Random random = Random();
    Duration difference = DateTime(2023, 8, 1).difference(DateTime(2023, 1, 1));
    int randomDays = random.nextInt(difference.inDays + 1);

    return DateTime(2023, 1, 1).add(Duration(days: randomDays));
  }
}
