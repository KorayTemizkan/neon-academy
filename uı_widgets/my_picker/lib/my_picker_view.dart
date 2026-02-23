import 'dart:io';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_font_picker/flutter_font_picker.dart';
import 'package:image_picker/image_picker.dart';

class MyPickerView extends StatefulWidget {
  const MyPickerView({super.key});

  @override
  State<MyPickerView> createState() => _MyPickerViewState();
}

// https://pub.dev/packages/image_picker
// Koray en sade haliyle bu şekilde yapılıyor sen de uygulamanda profil düzenle kısmına ekle
class _MyPickerViewState extends State<MyPickerView>
    with TickerProviderStateMixin {
  File? _selectedImage;
  final ImagePicker _picker = ImagePicker();
  late final TabController _tabController;
  PickerFont _selectedFont = PickerFont(fontFamily: "Roboto");

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  // Galeriden seçmemizi sağlayan fonksiyonu yazalım
  Future<void> _selectFromGallery() async {
    final XFile? image = await _picker.pickImage(
      // XFile çoklu platform soyutlamaymış
      source: ImageSource.gallery,
      imageQuality: 80, // Görüntü kalitesini %20 düşürür
    );

    if (image != null) {
      setState(() {
        _selectedImage = File(image.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Resim Seç', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blue,

        bottom: TabBar(
          controller: _tabController,
          tabs: const <Widget>[
            Tab(icon: Icon(Icons.cloud_outlined)),
            Tab(icon: Icon(Icons.beach_access_sharp)),
            Tab(icon: Icon(Icons.brightness_5_sharp)),
            Tab(icon: Icon(Icons.navigate_before)),
          ],
        ),
      ),

      body: TabBarView(
        controller: _tabController,
        children: [
          Center(
            child: Column(
              children: [
                SizedBox(height: 48),
                Container(
                  width: 300,
                  height: 300,
                  decoration: BoxDecoration(
                    border: BoxBorder.all(color: Colors.red, width: 2),
                  ),
                  child: Image(
                    image: NetworkImage(
                      'https://media.istockphoto.com/id/1682296067/photo/happy-studio-portrait-or-professional-man-real-estate-agent-or-asian-businessman-smile-for.jpg?s=612x612&w=0&k=20&c=9zbG2-9fl741fbTWw5fNgcEEe4ll-JegrGlQQ6m54rg=',
                    ),
                    fit: BoxFit.cover,
                  ),
                ),

                Text('Koray Temizkan', style: _selectedFont.toTextStyle()),
                Text('22 yaş', style: _selectedFont.toTextStyle()),
              ],
            ),
          ),

          Center(
            child: Column(
              children: [
                SizedBox(height: 48),
                Container(
                  width: 300,
                  height: 300,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.red, width: 2),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: _selectedImage == null
                      ? const Center(child: Text('Resim Seçilmedi'))
                      : ClipRRect(
                          child: Image.file(_selectedImage!, fit: BoxFit.cover),
                          borderRadius: BorderRadius.circular(16),
                        ),
                ),

                SizedBox(height: 16),

                ElevatedButton(
                  onPressed: () {
                    _selectFromGallery();
                  },
                  child: Text('Galeriden resim seç'),
                ),
              ],
            ),
          ),

          Center(
            child: Column(
              children: [
                SizedBox(height: 48),
                Container(
                  width: 300,
                  height: 300,
                  decoration: BoxDecoration(
                    border: BoxBorder.all(color: Colors.red, width: 2),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: _selectedImage == null
                      ? const Center(child: Text('Resim Seçilmedi'))
                      : ClipRRect(
                          child: Image.file(_selectedImage!, fit: BoxFit.cover),
                          borderRadius: BorderRadiusGeometry.circular(16),
                        ),
                ),

                SizedBox(height: 16),

                ElevatedButton(
                  onPressed: () {
                    _selectFromGallery();
                  },
                  child: Text('Galeriden resim seç'),
                ),
              ],
            ),
          ),

          Center(
            child: Column(
              children: [
                SizedBox(height: 48),
                Container(
                  width: 300,
                  height: 300,
                  decoration: BoxDecoration(
                    border: BoxBorder.all(color: Colors.red, width: 2),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: _selectedImage == null
                      ? const Center(child: Text('Resim Seçilmedi'))
                      : ClipRRect(
                          child: Image.file(_selectedImage!, fit: BoxFit.cover),
                          borderRadius: BorderRadiusGeometry.circular(16),
                        ),
                ),

                SizedBox(height: 16),

                ElevatedButton(
                  onPressed: () {
                    _selectFromGallery();
                  },
                  child: Text('Galeriden resim seç'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
