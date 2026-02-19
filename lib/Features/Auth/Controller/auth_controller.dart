import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  final FirebaseAuth auth = FirebaseAuth.instance;

  Rx<User?> firebaseUser = Rx<User?>(null);
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    firebaseUser.bindStream(auth.authStateChanges());
  }

  Future<void> login(String email, String password) async {
    try {
      isLoading.value = true;

      await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      Get.snackbar(
        "Success",
        "Login berhasil",
        snackPosition: SnackPosition.TOP,
        margin: const EdgeInsets.all(15),
        borderRadius: 12,
      );
      Get.offAllNamed('/home');
    } on FirebaseAuthException catch (e) {
      Get.snackbar(
        "Error",
        e.message ?? "Login gagal",
        snackPosition: SnackPosition.TOP,
        margin: const EdgeInsets.all(15),
        borderRadius: 12,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> register(String email, String password) async {
    try {
      isLoading.value = true;

      await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      Get.snackbar(
        "Success",
        "Register berhasil",
        snackPosition: SnackPosition.TOP,
        margin: const EdgeInsets.all(15),
        borderRadius: 12,
      );
      Get.offAllNamed('/login');
    } on FirebaseAuthException catch (e) {
      Get.snackbar(
        "Error",
        e.message ?? "Register gagal",
        snackPosition: SnackPosition.TOP,
        margin: const EdgeInsets.all(15),
        borderRadius: 12,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> logout() async {
    await auth.signOut();
  }

  void setInitialScreen(User? user){
    if(user == null){
      Get.offAllNamed('/login');
    } else {
      Get.offAllNamed('/home');
    }
  }
}
