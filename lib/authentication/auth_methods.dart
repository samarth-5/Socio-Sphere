import 'package:flutter/foundation.dart';

//Firebase
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:socio_sphere/authentication/storage_methods.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> signUpUser({
    required String email,
    required String password,
    required String username,
    required String bio,
    required Uint8List file,
  }) async {
    String res = 'Some error occured!';
    try {
      if (email.isNotEmpty &&
          password.isNotEmpty &&
          username.isNotEmpty &&
          bio.isNotEmpty &&
          file != null) {
        //register user
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
        
        //print(cred.user!.uid);
        String photoUrl = await StorageMethods().uploadImageToStorage('profilePics', file, false);
        //adding user to database
        await _firestore.collection('users').doc(cred.user!.uid).set({
          'username': username,
          'uid': cred.user!.uid,
          'email': email,
          'bio': bio,
          'followers': [],
          'following': [],
          'photoUrl': photoUrl,
        });
        res = 'success';
      }
      else{
        res = 'Please enter all the fields!';
      }
    } 
    on FirebaseAuthException catch(err){
      if(err.code == 'invalid-email'){
        res='Email is badly formatted!';
      }
      else if(err.code == 'weak-password'){
        res = 'Password should be atleast 6 characters!';
      }
    }
    catch (err) {
      res = err.toString();
    }
    return res;
  }
}
