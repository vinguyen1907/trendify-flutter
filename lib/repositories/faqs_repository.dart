import 'package:ecommerce_app/models/faq.dart';
import 'package:ecommerce_app/utils/firebase_constants.dart';

class FAQsRepository {
  Future<List<FAQ>> getFAQs() async {
    try {
      final snapshot = await faqsRef.get();
      return snapshot.docs
          .map((e) => FAQ.fromMap(e.data() as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw Exception(e);
    }
  }
}
