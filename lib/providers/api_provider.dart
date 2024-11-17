import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image/image.dart' as img;


class ApiProvider {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore fireStore = FirebaseFirestore.instance;
  final FirebaseStorage firebaseStorage = FirebaseStorage.instance;

  User? get currentUser => _auth.currentUser;
  Future<String?> registerUser(String name, String email, String password) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = userCredential.user;
      if (user != null) {

        await fireStore.collection('users').doc(user.uid).set({
          'uid': user.uid,
          'name': name,
          'email': email,
          'user_type': "user",
        });
        return null;
      }
      return "User registration failed";
    } catch (e) {
      return e.toString();
    }
  }

  Future<String?> loginUser(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return null;
    } catch (e) {
      return e.toString();
    }
  }

 fetchEmailByUsername(String email) async {
    try {
      QuerySnapshot userSnapshot = await fireStore
          .collection('users')
          .where('email', isEqualTo: email)
          .get();

      if (userSnapshot.docs.isEmpty) {
        return null;
      }
      return userSnapshot.docs.first;
    } catch (e) {
      throw Exception("Error fetching email: $e");
    }
  }
   Future<Map<String, dynamic>?> getData(String collection, {String? docId}) async {
    try {
      if (docId != null) {
        // Fetch a specific document
        DocumentSnapshot doc = await fireStore.collection(collection).doc(docId).get();
        return doc.data() as Map<String, dynamic>?;
      } else {
        // Fetch all documents in the collection
        QuerySnapshot snapshot = await fireStore.collection(collection).get();
        return {
          "documents": snapshot.docs
              .map((doc) => {"id": doc.id, ...doc.data() as Map<String, dynamic>})
              .toList(),
        };
      }
    } catch (e) {
      print("Error fetching data: $e");
      return null;
    }
  }


  Future<bool> putData(String collection, Map<String, dynamic> data, {String? docId}) async {
    try {
      if (docId != null) {
        // Update an existing document
        await fireStore.collection(collection).doc(docId).set(data, SetOptions(merge: true));
      } else {
        // Add a new document
        await fireStore.collection(collection).add(data);
      }
      return true;
    } catch (e) {
      print("Error adding/updating data: $e");
      return false;
    }
  }

  Future<bool> deleteData(String collection, String docId) async {
    try {
      await fireStore.collection(collection).doc(docId).delete();
      return true;
    } catch (e) {
      print("Error deleting data: $e");
      return false;
    }
  }

  logoutUser() async {
    try {
      await _auth.signOut();
    } catch (e) {
      throw Exception("Error logging out: $e");
    }
  }


  Future<String?> uploadImage(File imageFile, String folderPath) async {
    try {

      img.Image? image = img.decodeImage(imageFile.readAsBytesSync());

      if (image == null) {
        print("Error: Could not decode image.");
        return null;
      }

      img.Image compressedImage = img.copyResize(image, width: 800); // Resize image to 800px width, maintaining aspect ratio

      List<int> compressedBytes = img.encodeJpg(compressedImage, quality: 85); // Adjust quality as needed

      File compressedFile = File(imageFile.path)..writeAsBytesSync(compressedBytes);

      String fileName = DateTime.now().millisecondsSinceEpoch.toString();
      Reference storageRef = FirebaseStorage.instance.ref().child('$folderPath/$fileName');

      UploadTask uploadTask = storageRef.putFile(compressedFile);

      uploadTask.snapshotEvents.listen((TaskSnapshot snapshot) {
        double progress = (snapshot.bytesTransferred / snapshot.totalBytes) * 100;
        print("Upload Progress: ${progress.toStringAsFixed(2)}%");
      }, onError: (e) {
        print("Error during upload: $e");
      });

      TaskSnapshot snapshot = await uploadTask;

      // Get the download URL
      String downloadUrl = await snapshot.ref.getDownloadURL();
      print("Upload successful! File available at: $downloadUrl");
      return downloadUrl;

    } catch (e) {
      print("Error uploading image: $e");
      return null;
    }
  }

  Future<bool> removeItemFromCart(String userId, String productId) async {
    try {
      DocumentSnapshot cartDoc = await fireStore.collection('carts').doc(userId).get();
      if (cartDoc.exists) {
        Map<String, dynamic> cartData = cartDoc.data() as Map<String, dynamic>;
        List<dynamic> items = cartData['items'];
        items.removeWhere((item) => item['productId'] == productId);
        await fireStore.collection('carts').doc(userId).update({
          'items': items,
          'updatedAt': DateTime.now().toIso8601String(),
        });
        return true;
      }
      return false;
    } catch (e) {
      print("Error removing item from cart: $e");
      return false;
    }
  }


}
