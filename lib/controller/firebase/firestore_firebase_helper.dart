import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/controller/firebase/firebase_auth_helper.dart';
import 'package:e_commerce/model/product_model.dart';

class FireStoreHelper {
  static final cloudInstance = FirebaseFirestore.instance;
  static final cloudFireStoreUsers = cloudInstance.collection("user");
  static final cloudFireStoreWishList = cloudInstance.collection("wishlist");
  static final cloudFireStoreCart = cloudInstance.collection("cart");

  //User

  static getUserData() async {
    Map user = {};
    DocumentReference snapshots = cloudFireStoreUsers
        .doc(FirebaseAuthHelper.firebaseAuth.currentUser!.uid);
    await snapshots.get().then((value) {
      user = value.data() as Map;
    });
    return user;
  }

  static Future addNewUser(Map userData) async {
    await cloudFireStoreUsers
        .doc(FirebaseAuthHelper.firebaseAuth.currentUser!.uid)
        .set({
      "username": userData["username"],
      "email": userData["email"],
      "weight": userData["weight"],
      "height": userData["height"],
      "age": userData["age"],
    });
  }

  static Future<void> updateUserData(Map<String, dynamic> newData) async {
    await cloudFireStoreUsers
        .doc(FirebaseAuthHelper.firebaseAuth.currentUser!.uid)
        .update(newData);
  }

  //Wishlist

  static Future<String> addProductToWishlist(ProductModel productData) async {
    final DocumentSnapshot snapshot = await cloudFireStoreWishList
        .doc(FirebaseAuthHelper.firebaseAuth.currentUser!.uid +
            productData.id.toString())
        .get();

    if (snapshot.exists) {
      return 'Product already exists in the wishlist.';
    } else {
      await cloudFireStoreWishList
          .doc(FirebaseAuthHelper.firebaseAuth.currentUser!.uid +
              productData.id.toString())
          .set({
        ...productData.toJson(),
        'id': FirebaseAuthHelper.firebaseAuth.currentUser!.uid
      });
      return 'Product added to the wishlist.';
    }
  }

  static Stream<QuerySnapshot> getWishlist() {
    try {
      return cloudFireStoreWishList
          .where("id",
              isEqualTo: FirebaseAuthHelper.firebaseAuth.currentUser!.uid)
          .snapshots();
    } catch (e) {
      rethrow;
    }
  }

  static Future removeFromWishList(String productId) async {
    await cloudFireStoreWishList
        .doc(FirebaseAuthHelper.firebaseAuth.currentUser!.uid + productId)
        .delete();
  }

  //Cart
  static Future<String> addProductToCart(Map productData) async {
    final DocumentSnapshot snapshot = await cloudFireStoreCart
        .doc(FirebaseAuthHelper.firebaseAuth.currentUser!.uid +
            productData["id"])
        .get();

    if (snapshot.exists) {
      return 'Product already exists in the Cart.';
    } else {
      await cloudFireStoreCart
          .doc(FirebaseAuthHelper.firebaseAuth.currentUser!.uid +
              productData["id"])
          .set({
        ...productData,
        'userid': FirebaseAuthHelper.firebaseAuth.currentUser!.uid
      });
      return 'Product added to the wishlist.';
    }
  }

  static Stream<QuerySnapshot> getCartProduct() {
    try {
      return cloudFireStoreCart
          .where("userid",
              isEqualTo: FirebaseAuthHelper.firebaseAuth.currentUser!.uid)
          .snapshots();
    } catch (e) {
      rethrow;
    }
  }

  static Future removeFromCard(String productId) async {
    await cloudFireStoreCart
        .doc(FirebaseAuthHelper.firebaseAuth.currentUser!.uid + productId)
        .delete();
  }

  static Future<void> addToQuantity(String productId) async {
    final userCartDoc = cloudFireStoreCart
        .doc(FirebaseAuthHelper.firebaseAuth.currentUser!.uid + productId);

    DocumentSnapshot<Map> cartSnapshot = await userCartDoc.get();

    double currentPrice =
        cartSnapshot.exists ? (double.parse(cartSnapshot.data()!["price"])) : 0;

    int currentQuantity = cartSnapshot.exists
        ? (cartSnapshot.data()!['quantity'] ?? 0) as int
        : 0;

    int newQuantity = currentQuantity + 1;

    await userCartDoc.set({
      'quantity': newQuantity,
      'totalprice': (currentPrice * newQuantity).toString()
    }, SetOptions(merge: true));
  }

  static Future<void> removeFromQuantity(String productId) async {
    final userCartDoc = cloudFireStoreCart
        .doc(FirebaseAuthHelper.firebaseAuth.currentUser!.uid + productId);

    DocumentSnapshot<Map> cartSnapshot = await userCartDoc.get();

    double currentPrice =
        cartSnapshot.exists ? (double.parse(cartSnapshot.data()!["price"])) : 0;

    int currentQuantity = cartSnapshot.exists
        ? (cartSnapshot.data()!['quantity'] ?? 0) as int
        : 0;

    int newQuantity = currentQuantity - 1;

    if (newQuantity < 1) {
      newQuantity = 1;
    }

    await userCartDoc.set({
      'quantity': newQuantity,
      'totalprice': (currentPrice * newQuantity).toString()
    }, SetOptions(merge: true));
  }

  static Future<void> checkOut() async {
    try {
      QuerySnapshot querySnapshot = await cloudFireStoreCart
          .where('userid',
              isEqualTo: FirebaseAuthHelper.firebaseAuth.currentUser!.uid)
          .get();

      WriteBatch batch = FirebaseFirestore.instance.batch();

      querySnapshot.docs.forEach((doc) {
        batch.delete(doc.reference);
      });

      await batch.commit();
    } catch (e) {
      rethrow;
    }
  }
}
