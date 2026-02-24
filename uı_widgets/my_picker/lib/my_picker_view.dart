import 'dart:io';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
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
  // Tab kontrolcüsü
  late final TabController _tabController;

  // Görsel seçimi bölümü
  File? _selectedImage;
  final ImagePicker _picker = ImagePicker();
  int _age = 22;

  // Font Seçimi Bölümü
  PickerFont _selectedFont = PickerFont(fontFamily: "Roboto");

  // Tarih seçimi bölümü
  TextEditingController _dateController = TextEditingController();

  // Renk seçimi bölümü
  Color pickerColor = Colors.white;
  Color currentColor = Colors.white;

  void changeColor(Color color) {
    setState(() {
      pickerColor = color;
    });
  }

  Future<void> _selectColor() async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Pick a color!'),
          content: SingleChildScrollView(
            child: ColorPicker(
              pickerColor: pickerColor,
              onColorChanged: changeColor,
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                setState(() {
                  currentColor = pickerColor;
                  Navigator.of(context).pop();
                });
              },
              child: Text('Tamam'),
            ),
          ],
        );
      },
    );
  }

  // Bu initState() ve dispose() metotlarını kullanmayı alışkanlık haline getir.
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
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

  // https://www.youtube.com/watch?v=UrZL8-DrtHM
  Future<void> _selectDate() async {
    // eğer seçilmezse diye her ihtimale karşı nullable yaptık
    DateTime? _picked = await showDatePicker(
      context: context,
      initialDate: DateTime(
        2026,
      ), // böyle yaparak o günü son seçim tarihi ayarladım ilginç
      firstDate: DateTime(1900),
      lastDate: DateTime(2026),
    );

    if (_picked != null) {
      setState(() {
        // split kısmını ekleyerek sadece tarih bölümünü aldık
        _dateController.text = _picked.toString().split(" ")[0];
        _age = DateTime.now().year - _picked.year;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: pickerColor,
      appBar: AppBar(
        title: const Text('Resim Seç', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blue,

        bottom: TabBar(
          labelColor: Colors.white,
          dividerColor: Colors.transparent,
          indicatorColor: Colors.white,
          unselectedLabelColor: Colors.black,
          
          controller: _tabController,
          tabs: const <Widget>[
            Tab(icon: Icon(Icons.photo)),
            Tab(icon: Icon(Icons.photo_album)),
            Tab(icon: Icon(Icons.font_download)),
            Tab(icon: Icon(Icons.calendar_month)),
            Tab(icon: Icon(Icons.color_lens)),
          ],
        ),
      ),

      body: TabBarView(
        controller: _tabController,
        children: [
          // 1. SAYFA
          Center(
            child: Column(
              children: [
                SizedBox(height: 48),
                Container(
                  width: 300,
                  height: 300,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.red, width: 2),
                  ),
                  child: Image(
                    image: NetworkImage(
                      'https://media.istockphoto.com/id/1682296067/photo/happy-studio-portrait-or-professional-man-real-estate-agent-or-asian-businessman-smile-for.jpg?s=612x612&w=0&k=20&c=9zbG2-9fl741fbTWw5fNgcEEe4ll-JegrGlQQ6m54rg=',
                    ),
                    fit: BoxFit.cover,
                  ),
                ),

                SizedBox(height: 16),

                Text('Koray Temizkan', style: _selectedFont.toTextStyle()),
                Text(
                  'Yaş: $_age',
                  style: _selectedFont.toTextStyle(),
                ),
              ],
            ),
          ),

          //********************************************************************************************************************

          // 2. SAYFA
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

          //********************************************************************************************************************

          //3. SAYFA
          Center(
            child: Column(
              children: [
                SizedBox(height: 48),

                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FontPicker(
                          onFontChanged: (PickerFont font) {
                            setState(() {
                              _selectedFont = font;
                            });
                          },
                        ),
                      ),
                    );
                  },
                  child: Text('Font seç ve ilk sayfadaki fontu değiştir'),
                ),
              ],
            ),
          ),

          //********************************************************************************************************************

          // 4. SAYFA
          Center(
            child: Column(
              children: [
                SizedBox(height: 48),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: TextField(
                    controller: _dateController,
                    decoration: InputDecoration(
                      labelText: 'Tarih seç ve ilk sayfadaki yaşı değiştir',
                      filled: true,
                      prefixIcon: Icon(Icons.calendar_today),

                      labelStyle: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.normal,
                      ),

                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide.none,
                      ),

                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue),
                      ),
                    ),
                    readOnly: true,
                    onTap: () {
                      _selectDate();
                    },
                  ),
                ),
              ],
            ),
          ),

          //********************************************************************************************************************

          // 5. SAYFA
          Center(
            child: Column(
              children: [
                SizedBox(height: 48),

                ElevatedButton(
                  onPressed: () => _selectColor(),
                  child: Text('Renk seç ve arka planı değiştir'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
