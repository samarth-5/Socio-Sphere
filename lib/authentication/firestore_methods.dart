import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:socio_sphere/authentication/storage_methods.dart';
import 'package:socio_sphere/models/post.dart';
import 'package:uuid/uuid.dart';

class FirestoreMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //upload post
  Future<String> uploadPost(String description, Uint8List file, String uid,
      String username, String profImage) async {
    String res = "Some error occured!";
    String postId = const Uuid().v1();
    try {
      String photoUrl =
          await StorageMethods().uploadImageToStorage('posts', file, true);
      Post post = Post(
          description: description,
          uid: uid,
          username: username,
          likes: [],
          postId: postId,
          datePublished: DateTime.now(),
          postUrl: photoUrl,
          profImage: profImage);
      _firestore.collection('posts').doc(postId).set(post.toJson());
      res = "success";
     } 
    catch (err) {
      res = err.toString();
    }
    return res;
  }
}