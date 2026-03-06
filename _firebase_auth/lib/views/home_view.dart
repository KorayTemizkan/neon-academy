import 'dart:io';

import 'package:_firebase_auth/controllers/firebase_remote_config_service.dart';
import 'package:_firebase_auth/controllers/firebase_service.dart';
import 'package:_firebase_auth/models/post_model.dart';
import 'package:_firebase_auth/views/auth/register_view.dart';
import 'package:flutter/material.dart';
import 'package:gal/gal.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  // Görsel seçimi ve gösterimi bölümü
  File? _selectedImage;
  final ImagePicker _picker = ImagePicker();

  Future<void> _selectFromGallery() async {
    final XFile? image = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 75,
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
        title: Text('Main Page', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blue,
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Text('Login is succesful!'),

                  SizedBox(height: 16),

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

                  SizedBox(height: 16),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        context.read<FirebaseService>().logout();

                        Duration(seconds: 5);

                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => RegisterView(),
                          ),
                        );
                      },
                      child: Text('Logout'),
                    ),
                  ),

                  SizedBox(height: 16),
                  Divider(height: 2, color: Colors.grey),
                  SizedBox(height: 16),

                  // Firestore ve Firebase Storage KISIMLARI
                  /*

                    Sen Firebase Storage'ye bir fotoğraf yüklersin ve bu sana bir URL VERİR
                    Bu URL'yi de Firestore'ye bilgileriyle yüklersin.
                    */
                  Text('Firestore ve Firebase Storage Bölümü'),
                  SizedBox(height: 16),

                  Container(
                    width: 240,
                    height: 240,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.red, width: 2),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: _selectedImage == null
                        ? Center(child: Text('Görsel Seçilmedi'))
                        : ClipRRect(
                            child: Image.file(
                              _selectedImage!,
                              fit: BoxFit.cover,
                            ),
                            borderRadius: BorderRadiusGeometry.circular(16),
                          ),
                  ),

                  SizedBox(height: 16),

                  ElevatedButton(
                    onPressed: () async {
                      if (_selectedImage == null) {
                        _selectFromGallery();
                        return;
                      } else {
                        await context.read<FirebaseService>().uploadImage(
                          _selectedImage,
                        );
                      }
                    },
                    child: Text(
                      _selectedImage == null
                          ? 'Galeriden Görsel Seç'
                          : 'Firebase\'ye yükle',
                    ),
                  ),

                  ElevatedButton(
                    onPressed: () async {
                      if (_selectedImage != null) {
                        setState(() {
                          _selectedImage = null;
                        });
                      }
                    },
                    child: Text('Temizle'),
                  ),
                ],
              ),
            ),
          ),

          // ! Bu Consumer widgetini kendi projende de kullan Koray
          Consumer<FirebaseService>(
            builder: (context, firebaseService, child) {
              final allPosts = firebaseService.userPosts;

              if (allPosts.isEmpty) {
                return const SliverToBoxAdapter(
                  child: Center(child: CircularProgressIndicator()),
                );
              }

              return SliverList(
                delegate: SliverChildBuilderDelegate(
                  childCount: allPosts.length,
                  (context, index) {
                    final post = allPosts[index];

                    return myCard(post: post);
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class myCard extends StatelessWidget {
  myCard({super.key, required this.post});

  final PostModel post;
  TextEditingController commentController = TextEditingController();

  // share_plus paketinin kurulumu
  // https://pub.dev/packages/share_plus
  Future<void> _shareLink(String url) async {
    SharePlus.instance.share(ShareParams(text: 'check out my image: $url'));
  }

  // http ve gal paketlerini indir
  // Önce byte dizisi olarak http ile al
  // Sonra bu byte dizisini telefonda gizli bir cache dosyasında görsele çevir
  // Daha sonra bu görseli galeriye kaydet

  // Bu uzun ve karmaşık yöntem daha çok öneriliyor
  Future<void> _saveImage(String url) async {
    try {
      // Görseli internetten byte olarak çek -> http
      final response = await http.get(Uri.parse(url));

      // Telefonun geçici hafızasına bu byte dizisini görsele çevirip kaydet -> path_provider
      final tempDir = await getTemporaryDirectory();
      final path =
          '${tempDir.path}/firebase${DateTime.now().millisecondsSinceEpoch}.jpg';
      final file = File(path);
      await file.writeAsBytes(response.bodyBytes);

      // Bu gizli cache dosyasındaki görseli alıp galeriye dosyayı kaydet
      await Gal.putImage(path);
      print('OLUMLU');
    } catch (e) {
      print('Hata $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Kullanıcı ID: ${post.ownerId}'),
            Text('Gönderi Tarihi: ${post.createdAt}'),
            Wrap(
              children: [
                ElevatedButton(
                  onPressed: () {
                    _shareLink(post.imageUrl);
                  },
                  child: Text('Linki Paylaş'),
                ),

                ElevatedButton(
                  onPressed: () {
                    _saveImage(post.imageUrl);
                  },
                  child: Text('Görseli İndir'),
                ),
              ],
            ),

            ElevatedButton(
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return Column(
                      children: [
                        Expanded(
                          child: StreamBuilder(
                            stream: context
                                .read<FirebaseService>()
                                .getCommentsStream(post.id),
                            builder: (context, snapshot) {
                              if (!snapshot.hasData) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              }

                              final docs = snapshot.data!.docs;

                              return ListView.builder(
                                itemCount: docs.length,
                                itemBuilder: (context, index) {
                                  final data =
                                      docs[index].data()
                                          as Map<String, dynamic>;

                                  return ListTile(
                                    leading: const Icon(Icons.comment),
                                    title: Text(data['comment'] ?? ''),
                                    subtitle: Text(data['ownerId'] ?? ''),
                                  );
                                },
                              );
                            },
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: TextField(
                            controller: commentController,
                            decoration: InputDecoration(
                              labelText: 'Yorumun',
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
                        ),

                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                if (commentController.text.isNotEmpty) {
                                  context.read<FirebaseService>().addComment(
                                    post.id,
                                    commentController.text,
                                  );
                                }
                              },
                              child: Text('Yorum Yap'),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                );
              },
              child: Text('Yorumları Gör'),
            ),
          ],
        ),
      ),
    );
  }
}
