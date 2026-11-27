import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_flutter/notification_service.dart';
import 'package:flutter/material.dart';
import 'package:firebase_flutter/widget/auth_wrapper.dart';
import 'firebase_options.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Daftarkan handler untuk pesan saat aplikasi background / mati   // BARU
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  runApp(const MyApp());

  // Inisialisasi notifikasi (izin, token, listener)                  // BARU
  await NotificationService.init();
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Firebase Auth Simple',
      navigatorKey: navigatorKey, // <-- BARU: agar bisa navigasi dari notifikasi
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const AuthWrapper(),
    );
  }
}