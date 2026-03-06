import 'package:_firebase_auth/controllers/firebase_service.dart';
import 'package:_firebase_auth/views/auth/login_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class VerifyEmailView extends StatefulWidget {
  const VerifyEmailView({super.key});

  @override
  State<VerifyEmailView> createState() => _VerifyEmailViewState();
}

class _VerifyEmailViewState extends State<VerifyEmailView> {
  late TextEditingController verifyController;
  late String debug;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    verifyController = TextEditingController();
    debug = '';
  }

  @override
  void dispose() {
    // TODO: implement dispose
    verifyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Verify Email', style: TextStyle(color: Colors.white)),
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

                  Text(
                    'Verification email sent! Please check your inbox and click the link. Once verified, tap the \'Verify\' button below to proceed to the home page.!',textAlign: TextAlign.center,
                  ),

                  SizedBox(height: 16),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () async {
                        var isSent = await context
                            .read<FirebaseService>()
                            .isSent();
                        if (isSent) {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => LoginView(),
                            ),
                          );
                        } else {
                          setState(() {
                            debug = 'You haven\'t verified yet!';
                          });
                        }
                      },
                      child: Text('Verify'),
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
