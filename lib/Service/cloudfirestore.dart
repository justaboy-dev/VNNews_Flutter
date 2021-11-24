import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vnnews/Service/authencation.dart';

class CloudFireStore {
  FirebaseStorage rootRef =
      FirebaseStorage.instanceFor(bucket: "gs://vnnews-4cecd.appspot.com");
  late CollectionReference collectionReference;
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  Stream<QuerySnapshot> getPost() {
    collectionReference = firebaseFirestore.collection("Post");
    return collectionReference
        .orderBy("posttime", descending: true)
        .snapshots();
  }

  Stream<QuerySnapshot> getPostWithTittle(String tittle) {
    collectionReference = firebaseFirestore.collection("Post");
    return collectionReference
        .where("tittle", isGreaterThanOrEqualTo: tittle)
        .where("tittle", isLessThan: tittle + "\uf8ff".toString())
        .snapshots();
  }

  Stream<QuerySnapshot> getPostWithCategory(String? category) {
    collectionReference = firebaseFirestore.collection("Post");
    return collectionReference
        .where("category", isEqualTo: category)
        .snapshots();
  }

  Stream<QuerySnapshot> getPostWithID(String? id) {
    collectionReference = firebaseFirestore.collection("Post");
    return collectionReference.where("id", isEqualTo: id).snapshots();
  }

  Stream<QuerySnapshot> getVideo() {
    collectionReference = firebaseFirestore.collection("Video");
    return collectionReference
        .orderBy("posttime", descending: true)
        .snapshots();
  }

  Future<String> getVideoUrl(String path) async {
    return await rootRef.ref().child(path).getDownloadURL();
  }

  Future<String> getImageUrl(String path) async {
    return await rootRef.ref().child(path).getDownloadURL();
  }

  Stream<QuerySnapshot> getUserAvatarPath(String uid) {
    collectionReference = firebaseFirestore.collection("Users");
    return collectionReference.where("uid", isEqualTo: uid).snapshots();
  }

  Future<void> updateUser() async {
    collectionReference = firebaseFirestore.collection("Users");
    collectionReference
        .where("uid", isEqualTo: await AuthencationService().getCurrentUserID())
        .get()
        .then((QuerySnapshot snapshot) async {
      for (var value in snapshot.docs) {
        value.reference.update({
          "image": await AuthencationService().getCurrentUserImage(),
          "name": await AuthencationService().getCurrentUserName(),
        });
      }
    });
  }

  Future<void> createUser() async {
    collectionReference = firebaseFirestore.collection("Users");
    collectionReference
        .doc(await AuthencationService().getCurrentUserID())
        .set({
      "uid": await AuthencationService().getCurrentUserID(),
      "image": await AuthencationService().getCurrentUserImage(),
      "name": await AuthencationService().getCurrentUserName()
    });
  }

  Future<String> upLoadAvatar(XFile? file) async {
    File imageFile = File(file!.path);
    String downloadUrl = "";
    String filename = file.name;
    UploadTask uploadTask =
        rootRef.ref().child("useravatar").child(filename).putFile(imageFile);
    TaskSnapshot taskSnapshot = await uploadTask;
    downloadUrl = await taskSnapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  Future<void> updateView(int id) async {
    collectionReference = firebaseFirestore.collection("Post");
    collectionReference
        .where("id", isEqualTo: id)
        .get()
        .then((QuerySnapshot snapshot) {
      for (var value in snapshot.docs) {
        value.reference.update({"viewed": value["viewed"] + 1});
      }
    });
  }
}
