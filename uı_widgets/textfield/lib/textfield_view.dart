import 'package:flutter/material.dart';
import 'package:textfield/form_model.dart';

class TextfieldView extends StatefulWidget {
  const TextfieldView({super.key});

  @override
  State<TextfieldView> createState() => _TextfieldViewState();
}

// Yardım aldığım kaynak
// https://www.geeksforgeeks.org/flutter/form-validation-in-flutter/

class _TextfieldViewState extends State<TextfieldView> {
  TextEditingController nameSurnameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  FormModel model = FormModel();
  final _formKey =
      GlobalKey<
        FormState
      >(); // Formumuzu tanımlayacak eşsiz bir küresel anahtar tanımladık

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            SizedBox(height: 24),

            Form(
              key: _formKey,
              child: Column(
                children: [
                  /*
                  The academy members were given a task to work on, they were to create a text field for the user's name-surname,
                  and give it a placeholder of "Enter Name-Surname". They were also to change the text color to red and the font to bold.
                 */
                  TextFormField(
                    controller: nameSurnameController,
                     // Varsayılan olarak okey tuşununun 
                    textInputAction: TextInputAction.done,
                    // Klavyeyi kapattığında odağı kaldır
                    onFieldSubmitted: (value) {
                      FocusScope.of(context).unfocus();
                    },
                    decoration: InputDecoration(
                      labelText: 'Name-Surname',
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

                    validator: (value) {
                      if (value!.isEmpty || value == null) {
                        return 'Lütfen geçerli bir ad soyad giriniz!';
                      }
                      return null;
                    },

                    keyboardType: TextInputType.name,

                    style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  SizedBox(height: 24),

                  /*
                  The second text field was to be created for the user's email and given a placeholder of "Enter Email".
                  The text color was to be blue and the font to be italic.
                  */
                  TextFormField(
                    inputFormatters: [],
                    controller: emailController,
                    
                    // Varsayılan olarak okey tuşununun 
                    textInputAction: TextInputAction.done,
                    // Klavyeyi kapattığında odağı kaldır
                    onFieldSubmitted: (value) {
                      FocusScope.of(context).unfocus();
                    },
                    decoration: InputDecoration(
                      labelText: 'Email',
                      labelStyle: TextStyle(color: Colors.blue),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide(color: Colors.blue),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide(color: Colors.blue),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide(color: Colors.red),
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty ||
                          !RegExp(
                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
                          ).hasMatch(value)) {
                        return 'Lütfen geçerli bir mail adresi giriniz!';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.emailAddress,
                    style: TextStyle(
                      color: Colors.blue,
                      fontFamily: 'myFont',
                      fontStyle: FontStyle.italic,
                    ),
                  ),

                  /*
                  The third text field was to be created for the user's phone number and given a placeholder of "Enter Phone Number".
                  The text color was to be green and the font to be underline.
                  */
                  SizedBox(height: 24),

                  TextFormField(
                    maxLength: 10,
                    inputFormatters: [],
                     // Varsayılan olarak okey tuşununun 
                    textInputAction: TextInputAction.done,
                    // Klavyeyi kapattığında odağı kaldır
                    onFieldSubmitted: (value) {
                      FocusScope.of(context).unfocus();
                    },
                    controller: phoneController,
                    decoration: InputDecoration(
                      labelText: 'Phone (555)',
                      labelStyle: TextStyle(color: Colors.green),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide(color: Colors.green),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide(color: Colors.green),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide(color: Colors.red),
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty ||
                          !RegExp(
                            r'^[\+]?[(]?[0-9]{3}[)]?[-\s\.]?[0-9]{3}[-\s\.]?[0-9]{4,6}$',
                          ).hasMatch(value)) {
                        return 'Lütfen geçerli bir telefon numarası giriniz!';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.phone,
                    style: TextStyle(
                      color: Colors.green,
                      decoration: TextDecoration.underline,
                      decorationColor: Colors.green,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 24),

            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              onPressed: () {
                // burada currentState! olmasının sebebi bir keyin dart dilinde bir widgete bağlı olup olmadığının
                // çalışma anına kadar kesino olarak bilinemeyecek olmasıdır
                // biz ! olarak bunun garanti olarak bağlandığını kabul ediyoruz
                if (_formKey.currentState!.validate()) {
                  setState(() {
                    model.name = nameSurnameController.text;
                    model.email = emailController.text;
                    model.phoneNumber = phoneController.text;
                  });
                }
              },
              child: Text('Gönder', style: TextStyle(color: Colors.white)),
            ),

            SizedBox(height: 24),

            Card(
              elevation: 1,
              margin: EdgeInsets.all(8),

              child: Padding(
                padding: EdgeInsets.all(8),
                child: Column(
                  children: [
                    Text(
                      'BİLGİLER:\n\nAd Soyad: ${model.name}\nEmail: ${model.email}\nTelefon: ${model.phoneNumber}',
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
