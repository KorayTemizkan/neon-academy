import 'package:flutter/material.dart';
import 'package:struct_class/model_service.dart';
import 'package:struct_class/models/contact_information_model.dart';
import 'package:struct_class/models/neon_academy_member_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<NeonAcademyMemberModel> neonAcademyMembers = [];
  List<ContactInformationModel> contactInformations = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchNeonAcademyMembers().then((data) {
      setState(() {
        neonAcademyMembers = data;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (neonAcademyMembers.isEmpty) {
      return const CircularProgressIndicator();
    }

    return MaterialApp(
      home: Scaffold(
        body: Column(
          children: [
            SizedBox(height: 15),

            Expanded(
              child: ListView.builder(
                itemCount: 19,
                itemBuilder: (context, index) {
                  final member = neonAcademyMembers[index];

                  return Card(
                    margin: EdgeInsets.all(16),
                    elevation: 1,

                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Text('Ad: ${member.fullName}'),
                          Text('Unvan: ${member.title}'),
                          Text('Yaş: ${member.age}'),
                          Text('Memleket: ${member.homeTown}'),
                          Text('Burç: ${member.horoscope}'),
                          Text('Düzey: ${member.memberLevel}'),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
