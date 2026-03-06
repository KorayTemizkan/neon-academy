import 'package:_firebase_auth/controllers/firebase_service.dart';
import 'package:_firebase_auth/views/home_view.dart';
import 'package:_firebase_auth/views/auth/login_view.dart';
import 'package:_firebase_auth/views/auth/register_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ForgetPasswordView extends StatefulWidget {
  const ForgetPasswordView({super.key});

  @override
  State<ForgetPasswordView> createState() => _ForgetPasswordViewState();
}

class _ForgetPasswordViewState extends State<ForgetPasswordView> {
  late TextEditingController _emailController;
  late bool isSent;
  String debug = 'Welcome to Reset Password Page!';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _emailController = TextEditingController();
    isSent = false;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reset Password', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blue,
      ),

      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Text(debug, textAlign: TextAlign.center,),

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

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () async {
                        if (isSent == false) {
                          isSent = await context
                              .read<FirebaseService>()
                              .resetPassword(_emailController.text);

                          if (isSent) {
                            setState(() {
                              debug =
                                  'Link gönderildi, giriş ekranına dönmek için butona basınız!';
                            });
                          } else {
                            setState(() {
                              debug = 'AWTESRH';
                            });
                          }
                        }
                      },
                      child: Text('Set Reset Password Link'),
                    ),
                  ),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () async {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => LoginView()),
                        );
                      },
                      child: Text('Go Back'),
                    ),
                  ),

                     // OTURUM KONTROLÜ İÇİN TEST
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
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
