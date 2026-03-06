import 'dart:io';
import 'package:_firebase_auth/models/post_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

// https://firebase.google.com/docs/auth/flutter/
class FirebaseService extends ChangeNotifier {
  // ! AUTHENTICATION
  // ? FirebaseAuth'dan auth işlemleri için katman oluşturduk. değiştirilemeyecek ve private olacak şekilde ayarladık
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // ! FİRESTORE
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // ! STORAGE
  final FirebaseStorage _storage = FirebaseStorage.instance;

  // ! GÖNDERİ LİSTESİ
  List<PostModel> _userPosts = [];
  List<PostModel> get userPosts => _userPosts;

  // Bunları void yapıyorum çünkü zaten mainde state değişimlerini dinleyen fonksiyonumuz arka planda sürekli açık
  // Bunları async yapıyorsun çünkü zaman alan işlemler

  // REGİSTER
  Future<bool> createUser(String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await sendEmailVerification();

      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email');
      }
      return false;
    }
  }

  // EMAİL DOĞRULAMA
  Future<void> sendEmailVerification() async {
    try {
      await _auth.currentUser?.sendEmailVerification();
    } on FirebaseAuthException catch (e) {
      print('Bir hata oluştu!: $e');
    }
  }

  // EMAİL DOĞRULANDI MI? Sen gelen maildeki linke girip onaylasan bile yerelde güncellemesi için .reload() yapman lazım
  Future<bool> isSent() async {
    await _auth.currentUser?.reload();
    if (_auth.currentUser?.emailVerified == true) {
      return true;
    } else {
      return false;
    }
  }

  // LOGİN
  Future<bool> login(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found that email!');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user!');
      }
      return false;
    }
  }

  // DELETE USER (Tam çalışmıyor olabilir)
  Future<void> deleteUser(String email, String password) async {
    // ? await login(email, password); Bunu kontrol et

    // Yanlış hatırlamıyorsam tekrar giriş yaptırıyor
    AuthCredential credential = EmailAuthProvider.credential(
      email: email,
      password: password,
    );

    try {
      await _auth.currentUser?.reauthenticateWithCredential(credential);
      await _auth.currentUser?.delete();

      print('User account has deleted!');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'requires-recent-login') {
        print('Recent login required!');
      } else if (e.code == 'user-mismatch') {
        print('User mismatch!');
      } else if (e.code == 'user-not-found') {
        print('User not found!');
      } else if (e.code == 'invalid-credential') {
        print('Invalid credential!');
      } else if (e.code == 'invalid-email') {
        print('Invalid email!');
      } else if (e.code == 'wrong-password') {
        print('Wrong password!');
      } else if (e.code == 'invalid-verification-code') {
        print('Invalid verification code!');
      } else if (e.code == 'invalid-verification-id') {
        print('Invalid verification ID!');
      }
    }
  }

  // LOGOUT
  Future<void> logout() async {
    await _auth.signOut();
  }

  // CHANGE PASSWORD with string
  Future<void> changePassword(String password) async {
    try {
      await _auth.currentUser?.updatePassword(password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak');
      }
    } catch (e) {
      print('Anything else');
    }
  }

  // ? Güvenlik amacıyla 2023 sonrası Firebase hata mesajı filan döndürmüyor. Hangi mailler var gözükmesin diye
  Future<bool> resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('Kayıtlı kullanıcı bulunamadı!');
      } else if (e.code == 'invalid-email') {
        print('Geçersiz bir e-posta adresi');
      }
      return false;
    } catch (e) {
      print('Beklenmedik bir hata oluştu: $e');
      return false;
    }
  }

  Future<String?> fetchEmail() async {
    String? mail = '';
    try {
      return mail = _auth.currentUser?.email;
    } catch (e) {
      print('Something went wrong $e');
    }
  }

  // ! FİRESTORE ve FİREBASE STORAGE

  /*
  flutter pub add cloud_firestore  -> Yazı, fiyat, link gibi ögeleri tutar
  flutter pub add firebase_storage -> Resim dosyalarını tutar
  flutter pub add image_picker     -> Telefonunun galerisin aççıp görsel seçmeni sağlar

  Firebase consolede Firestore ve Storage için projeler oluştur
  
  Kütüphaneleri ve instanceleri ekle
  */

  // Dosya yolları eğer Firebase'de yoksa otomatik oluşur
  // Storage'ye görseli yükle -> download
  Future<void> uploadImage(File? image) async {
    // Gelen görseli arlıyoruz
    File file = image!;

    // 2) Görseli Storage'ye yeni öge olarak yüklüyoruz -> Yüklendikten sonra görselin indirme linkini alıyoruz -> Görseli Firestore'a yeni öge olarak ekliyoruz.
    try {
      // Benzersiz bir isim oluşturuyoruz
      String fileName = 'post_${DateTime.now().millisecondsSinceEpoch}.jpg';
      // Storage'de 'post_images' klasörünün içine bu isimle bir yer ayırıyoruz.
      // Represents a reference to a Google Cloud Storage object. Developers can upload, download, and delete objects, as well as get/set object metadata.
      Reference ref = _storage.ref().child('post_images').child(fileName);

      // Dosyayı yüklüyoruz (Asıl işlemimizin başladığı yer)
      await ref.putFile(file);

      String downloadUrl = await ref.getDownloadURL();

      // Görsel artık Storage'de. Firestore'a ise bu görselin referansını yazıyoruz gibi düşün
      await _firestore.collection('posts').add({
        'imageUrl': downloadUrl,
        // Storage'den gelen link
        'ownerId':
            _auth.currentUser?.uid, // Paylaşan kişinin unique identification
        'createdAt':
            FieldValue.serverTimestamp(), // Kayıt zamanınını Firebase'nin kendi saatine göre ayarla
      });
    } catch (e) {
      print('Bir hata oluştu: $e');
    }
  }

  // Tüm kullanıcıların tüm postlarını getirmenin yolu bu. Karmaşık geliyor ama zamanla alışırım
  // Çalışması için konsolda bunu çalıştır : cd android && ./gradlew signingReport -> SHA1 ve SHA256 kopyala
  // Firebase'de ayarlarda anahtarları yapıştır
  // Böylece Firebase'ye yetkilendirme izin veriyormuşuz gibi düşün

  void getAllItems() {
    _firestore
        .collection('posts')
        .orderBy('createdAt', descending: true)
        .snapshots()
        .listen((snapshot) {
          _userPosts = snapshot.docs
              .map((doc) => PostModel.fromFirestore(doc.data(), doc.id))
              .toList();

          notifyListeners();
        });
  }

  Future<void> addComment(String postId, String comment) async {
    await _firestore
        .collection('posts')
        .doc(postId)
        .collection('comments')
        .add({
          'comment': comment,
          'ownerId': _auth.currentUser?.uid,
          'createdAt': FieldValue.serverTimestamp(),
        });
  }

  Stream<QuerySnapshot> getCommentsStream(String postId) {
    return _firestore
        .collection('posts')
        .doc(postId)
        .collection('comments')
        .orderBy('createdAt', descending: true)
        .snapshots();
  }

  // ! Firebase Remote Config

  
}
