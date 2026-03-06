import 'package:_firebase_auth/controllers/firebase_remote_config_service.dart';
import 'package:_firebase_auth/controllers/firebase_service.dart';
import 'package:_firebase_auth/views/auth/login_view.dart';
import 'package:_firebase_auth/views/auth/verify_email_view.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late String debug;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    debug = 'Welcome to Register Page!';
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blue,
      ),

      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Text(debug),

                  SizedBox(height: 16),

                  TextField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      labelStyle: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide(color: Colors.red),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide(color: Colors.red),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide(color: Colors.red),
                      ),
                    ),
                  ),

                  SizedBox(height: 16),

                  TextField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      labelStyle: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide(color: Colors.red),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide(color: Colors.red),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide(color: Colors.red),
                      ),
                    ),
                  ),

                  SizedBox(height: 16),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () async {
                        bool isSuccess = await context
                            .read<FirebaseService>()
                            .createUser(
                              _emailController.text,
                              _passwordController.text,
                            );

                        // Bunu çözmen lazım
                        Duration(seconds: 2);

                        if (isSuccess) {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const VerifyEmailView(),
                            ),
                          );
                        } else {
                          setState(() {
                            debug = 'Something went wrong, try again!';
                          });
                        }
                      },
                      child: Text('Register'),
                    ),
                  ),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => LoginView()),
                        );
                      },
                      child: Text('Have you registered before?'),
                    ),
                  ),

                  // OTURUM KONTROLÜ İÇİN TEST
                  Divider(height: 24),
                  Text('Oturum Kontrolü'),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          // Bu yapıyı artık ezberle kaçıncı kez karşına çıkıyor. Future verileri göstermenin yolu
                          FutureBuilder<String?>(
                            // neyi bekleyeceğini yazarsın
                            future: context
                                .read<FirebaseService>()
                                .fetchEmail(),
                            // neler yapacağını yazarsın
                            builder: (context, snapshot) {
                              return Text(snapshot.data ?? '');
                            },
                          ),
                        ],
                      ),
                    ),
                  ),

                  Divider(height: 24),

                  Text('Remote Config Service'),
                  Consumer<FirebaseRemoteConfigService>(
                    builder: (context, configService, child) {
                      return ClipRRect(
                        child: configService.isHidden
                            ? const Center(
                                child: Icon(
                                  Icons.hourglass_empty,
                                  size: 50,
                                  color: Colors.grey,
                                ),
                              )
                            : Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(configService.welcomeMessage),
                                      Text(' ${configService.year}'),
                                    ],
                                  ),
                                  Image.network(
                                    configService.imageUrl,
                                    fit: BoxFit.cover,
                                    loadingBuilder:
                                        (context, child, loadingProgress) {
                                          if (loadingProgress == null)
                                            return child;
                                          return const Center(
                                            child: CircularProgressIndicator(),
                                          );
                                        },
                                    errorBuilder:
                                        (context, error, stackTrace) =>
                                            const Icon(Icons.error),
                                  ),
                                ],
                              ),
                      );
                    },
                  ),
                  
                  SizedBox(height: 16),
                  Text('Crashlytics'),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        // Uygulamayı bilerek çökertiyoruz (Sadece test için!)
                        FirebaseCrashlytics.instance.crash();
                      },
                      child: const Text("instance.crash()"),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
