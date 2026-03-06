import 'package:_object_box/coral_fragment_model.dart';
import 'package:_object_box/main.dart';
import 'package:flutter/material.dart';

class ObjectBoxView extends StatefulWidget {
  const ObjectBoxView({super.key});

  @override
  State<ObjectBoxView> createState() => _ObjectBoxViewState();
}

class _ObjectBoxViewState extends State<ObjectBoxView> {
  TextEditingController _titleController = TextEditingController();
  TextEditingController _speciesController = TextEditingController();
  TextEditingController _contentController = TextEditingController();
  DateTime myTime = DateTime(2025);
  int number = 0;

  // Bize güncel listeyi getirecek streami tanımladık
  late Stream<List<CoralFragmentModel>> _fragmentStream;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fragmentStream = objectBox.coralBox
        .query() // tüm kayıtları seç
        .watch(triggerImmediately: true) // hemen başlat ve izle
        .map((event) => event.find()); // her değişimde ara ve listeyi ver
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _titleController.dispose();
    _speciesController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Object Box', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blue,
      ),

      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  TextField(
                    controller: _titleController,
                    decoration: InputDecoration(labelText: 'Başlık'),
                  ),
                  TextField(
                    controller: _speciesController,
                    decoration: InputDecoration(labelText: 'Tür'),
                  ),
                  TextField(
                    controller: _contentController,
                    decoration: InputDecoration(labelText: 'İçerik'),
                  ),

                  SizedBox(height: 16),

                  ElevatedButton(
                    onPressed: () {
                      if (_titleController.text.isEmpty ||
                          _contentController.text.isEmpty ||
                          _speciesController.text.isEmpty) {
                        return;
                      }

                      final newFragment = CoralFragmentModel(
                        title: _titleController.text,
                        species: _speciesController.text,
                        content: _contentController.text,
                        fragmentDate: myTime,
                      );

                      objectBox.saveFragment(newFragment);

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Ekleme Başarılı!')),
                      );
                    },
                    child: Text('Yeni Parça Ekle'),
                  ),

                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        number = objectBox
                            .searchFragments(_titleController.text)
                            .length;
                      });
                    },
                    child: Text(
                      'Bu katarı barındıran kaç fragment var: $number',
                    ),
                  ),
                ],
              ),
            ),
          ),

          /* Bunu yapamayız çünkü bu hive'e özel. Biz Stream kullanacağız
             ValueListenableBuilder(valueListenable: valueListenable, builder: builder)

             ObjectBox'un yapısına en uygunun bu olduğunu söyledi Gemini

          */
          StreamBuilder(
            stream: _fragmentStream,
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const SliverToBoxAdapter(
                  child: Center(child: CircularProgressIndicator()),
                );
              }

              final fragments = snapshot.data!;

              // Burayı ListView.builder gibi hayal et, kalanı aynı zaten
              return SliverList(
                delegate: SliverChildBuilderDelegate(
                  childCount: fragments.length,
                  (context, index) {
                    final item = fragments[index];

                    return Card(
                      child: ListTile(
                        onTap: () {
                          _titleController.text = item.title;
                          _contentController.text = item.content;
                          _speciesController.text = item.species;
                        },

                        title: Text(item.title),
                        subtitle: Text("${item.species} - ${item.content}"),

                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () =>
                                  objectBox.deleteFragment(item.id),
                            ),
                            IconButton(
                              icon: const Icon(Icons.edit, color: Colors.blue),
                              onPressed: () {
                                if (_titleController.text.isEmpty ||
                                    _contentController.text.isEmpty ||
                                    _speciesController.text.isEmpty) {
                                  return;
                                }

                                final newFragment = CoralFragmentModel(
                                  id: item
                                      .id, // Burayı eklemeyi unutursan güncelleme yapmaz
                                  title: _titleController.text,
                                  species: _speciesController.text,
                                  content: _contentController.text,
                                  fragmentDate: myTime,
                                );

                                objectBox.saveFragment(newFragment);

                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Güncelleme Başarılı!'),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    );
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
