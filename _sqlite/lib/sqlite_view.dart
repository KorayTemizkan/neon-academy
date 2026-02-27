import 'package:_sqlite/asgardian_model.dart';
import 'package:_sqlite/database_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:collection/collection.dart'; // Bu satırı eklediğiğimizde firstwhereornull kullanabiliyoruz

class SqliteView extends StatefulWidget {
  const SqliteView({super.key});

  @override
  State<SqliteView> createState() => _SqliteViewState();
}

class _SqliteViewState extends State<SqliteView> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _surnameController = TextEditingController();
  TextEditingController _ageController = TextEditingController();
  TextEditingController _emailController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final _dbList = context.watch<DatabaseProvider>().asgardians;

    return Scaffold(
      appBar: AppBar(
        title: Text('SQLite', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blue,
      ),

      // Klavye açıldığında kaydırma yapabilmek için CustomScrollView en iyi yöntemdir
      body: CustomScrollView(
        slivers: [
          // Form Bölümü
          SliverToBoxAdapter(
            child: Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    SizedBox(height: 16),
                    // AD
                    TextFormField(
                      controller: _nameController,
                      textInputAction: TextInputAction.done,
                      onFieldSubmitted: (value) {
                        FocusScope.of(context).unfocus();
                      },
                      decoration: InputDecoration(
                        labelText: 'Name',
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
                          borderSide: BorderSide(color: Colors.blue),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Lütfen geçerli bir ad soyad giriniz';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.name,
                      style: TextStyle(color: Colors.blue),
                    ),

                    SizedBox(height: 16),

                    // SOYAD
                    TextFormField(
                      controller: _surnameController,
                      textInputAction: TextInputAction.done,
                      onFieldSubmitted: (value) {
                        FocusScope.of(context).unfocus();
                      },
                      decoration: InputDecoration(
                        labelText: 'Surname',
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
                          borderSide: BorderSide(color: Colors.blue),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Lütfen geçerli bir soyad soyad giriniz';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.name,
                      style: TextStyle(color: Colors.blue),
                    ),

                    SizedBox(height: 16),

                    // YAŞ
                    TextFormField(
                      controller: _ageController,
                      textInputAction: TextInputAction.done,
                      onFieldSubmitted: (value) {
                        FocusScope.of(context).unfocus();
                      },
                      decoration: InputDecoration(
                        labelText: 'Yaş',
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
                          borderSide: BorderSide(color: Colors.blue),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Lütfen geçerli bir soyad soyad giriniz';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.number,
                      style: TextStyle(color: Colors.blue),
                    ),

                    SizedBox(height: 16),

                    // EMAİL
                    TextFormField(
                      inputFormatters: [],
                      controller: _emailController,

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
                          borderSide: BorderSide(color: Colors.blue),
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

                    SizedBox(height: 24),

                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                      ),
                      onPressed: () {
                        // burada currentState! olmasının sebebi bir keyin dart dilinde bir widgete bağlı olup olmadığının
                        // çalışma anına kadar kesino olarak bilinemeyecek olmasıdır
                        // biz ! olarak bunun garanti olarak bağlandığını kabul ediyoruz
                        if (_formKey.currentState!.validate()) {
                          context.read<DatabaseProvider>().addAsgardian(
                            _nameController.text,
                            _surnameController.text,
                            int.parse(_ageController.text),
                            _emailController.text,
                          );

                          _formKey.currentState!.reset();
                          _nameController.clear();
                          _surnameController.clear();
                          _ageController.clear();
                          _emailController.clear();
                        }
                      },
                      child: Text(
                        'Yeni Kişi Ekle',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),

                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                      ),
                      onPressed: () async {
                        // burada currentState! olmasının sebebi bir keyin dart dilinde bir widgete bağlı olup olmadığının
                        // çalışma anına kadar kesino olarak bilinemeyecek olmasıdır
                        // biz ! olarak bunun garanti olarak bağlandığını kabul ediyoruz
                        var model = _dbList.firstWhereOrNull(
                          (element) => element.name == _nameController.text,
                        );

                        if (model != null) {
                          await context
                              .read<DatabaseProvider>()
                              .deleteAsgardian(model.id);

                          _formKey.currentState!.reset();
                          _nameController.clear();
                          _surnameController.clear();
                          _ageController.clear();
                          _emailController.clear();
                        }
                      },
                      child: Text(
                        'Ad gir ve o kişiyi sil',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),

                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                      ),
                      onPressed: () async {
                        // burada currentState! olmasının sebebi bir keyin dart dilinde bir widgete bağlı olup olmadığının
                        // çalışma anına kadar kesino olarak bilinemeyecek olmasıdır
                        // biz ! olarak bunun garanti olarak bağlandığını kabul ediyoruz
                        var model = _dbList.firstWhereOrNull(
                          (element) => element.name == _nameController.text,
                        );

                        if (model != null) {
                          await context
                              .read<DatabaseProvider>()
                              .updateAsgardian(
                                _nameController.text,
                                _surnameController.text,
                                int.parse(_ageController.text),
                                _emailController.text,
                                model.id,
                              );

                          _formKey.currentState!.reset();
                          _nameController.clear();
                          _surnameController.clear();
                          _ageController.clear();
                          _emailController.clear();
                        }
                      },
                      child: Text(
                        'Ad gir ve o kişiyi güncelle',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Liste Bölümü
          _dbList.isEmpty
              ? const SliverToBoxAdapter(
                  child: Center(child: Text('Henüz öge yok!')),
                )
              : SliverList(
                  delegate: SliverChildBuilderDelegate(
                    childCount: _dbList.length,
                    (context, index) {
                      final asgardian = _dbList[index];

                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Card(
                          elevation: 1,
                          child: Column(
                            children: [
                              Text('Id: ' + asgardian.id.toString()),
                              Text('Ad: ' + asgardian.name),
                              Text('Soyad: ' + asgardian.surname),
                              Text('Yaş: ' + asgardian.age.toString()),
                              Text('Email: ' + asgardian.email),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
        ],
      ),

      /* Eski ve bozuk yöntemim artık sliver kullanmam lazım
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 8),
            Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    // AD
                    TextFormField(
                      controller: _nameController,
                      textInputAction: TextInputAction.done,
                      onFieldSubmitted: (value) {
                        FocusScope.of(context).unfocus();
                      },
                      decoration: InputDecoration(
                        labelText: 'Name',
                        labelStyle: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
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
                          borderSide: BorderSide(color: Colors.blue),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Lütfen geçerli bir ad soyad giriniz';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.name,
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    SizedBox(height: 16),

                    // SOYAD
                    TextFormField(
                      controller: _surnameController,
                      textInputAction: TextInputAction.done,
                      onFieldSubmitted: (value) {
                        FocusScope.of(context).unfocus();
                      },
                      decoration: InputDecoration(
                        labelText: 'Surname',
                        labelStyle: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
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
                          borderSide: BorderSide(color: Colors.blue),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Lütfen geçerli bir soyad soyad giriniz';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.name,
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    SizedBox(height: 16),

                    // YAŞ
                    TextFormField(
                      controller: _ageController,
                      textInputAction: TextInputAction.done,
                      onFieldSubmitted: (value) {
                        FocusScope.of(context).unfocus();
                      },
                      decoration: InputDecoration(
                        labelText: 'Yaş',
                        labelStyle: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
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
                          borderSide: BorderSide(color: Colors.blue),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Lütfen geçerli bir soyad soyad giriniz';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.number,
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    SizedBox(height: 16),

                    // EMAİL
                    TextFormField(
                      inputFormatters: [],
                      controller: _emailController,

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
                          borderSide: BorderSide(color: Colors.blue),
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

                    SizedBox(height: 24),

                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                      ),
                      onPressed: () {
                        // burada currentState! olmasının sebebi bir keyin dart dilinde bir widgete bağlı olup olmadığının
                        // çalışma anına kadar kesino olarak bilinemeyecek olmasıdır
                        // biz ! olarak bunun garanti olarak bağlandığını kabul ediyoruz
                        if (_formKey.currentState!.validate()) {
                          context.read<DatabaseProvider>().addAsgardian(
                            _nameController.text,
                            _surnameController.text,
                            int.parse(_ageController.text),
                            _emailController.text,
                          );
                        }
                      },
                      child: Text(
                        'Yeni Kişi Ekle',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 24),
            Divider(height: 2),
            SizedBox(height: 24),

            ListView.builder(
              shrinkWrap: true, // Bu yapıyı artık terk etmem lazım biliyorum. Slivera alışmam lazım
              itemCount: dbList.length,
              itemBuilder: (context, index) {
                final asgardian = dbList[index];

                return Card(
                  elevation: 1,
                  child: Column(
                    children: [
                      Text(asgardian.id.toString()),
                      Text(asgardian.name),
                      Text(asgardian.surname),
                      Text(asgardian.age.toString()),
                      Text(asgardian.email),
                      Text(asgardian.name),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),*/
    );
  }
}
