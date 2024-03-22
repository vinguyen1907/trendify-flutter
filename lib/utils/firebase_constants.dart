import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
final FirebaseFirestore firestore = FirebaseFirestore.instance;
final CollectionReference usersRef = firestore.collection("users");
final DocumentReference currentUserRef =
    usersRef.doc(firebaseAuth.currentUser!.uid);
final CollectionReference categoriesRef = firestore.collection("categories");
final CollectionReference productsRef = firestore.collection("products");
final CollectionReference promotionsRef = firestore.collection("promotions");
final CollectionReference ordersRef = firestore.collection("orders");
final DocumentReference ordersStatisticsDocRef =
    firestore.collection("statistics").doc("orders_statistics");
final DocumentReference productsStatisticsDocRef =
    firestore.collection("statistics").doc("products_statistics");
final CollectionReference favoritesRef = currentUserRef.collection("favorites");
final CollectionReference faqsRef = firestore.collection("faqs");
final CollectionReference chatRoomsRef = firestore.collection("chat_rooms");
final CollectionReference notificationsRef =
    firestore.collection("notifications");
