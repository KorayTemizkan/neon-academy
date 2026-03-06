import 'package:_hive/task_model.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HiveView extends StatefulWidget {
  const HiveView({super.key});

  @override
  State<HiveView> createState() => _HiveViewState();
}

class _HiveViewState extends State<HiveView> {
  late Box<TaskModel> _taskBox;
  TextEditingController _titleController = TextEditingController();
  TextEditingController _contentController = TextEditingController();
  List<String> myColors = ['kırmızı', 'yeşil'];
  int length = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // Açtığımız kutuyu maindeki referansa bağladık gibi düşün
    _taskBox = Hive.box<TaskModel>('tasks');
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  // CREATE, her yeni elemanı otomatik olarak 0,1,2,3 diye otomatik arttırır
  void _addTask(String title, String content, List<String> colors) async {
    if (_titleController.text.isEmpty) return;
    if (_contentController.text.isEmpty) return;

    var newTask = TaskModel(
      title: _titleController.text,
      content: _contentController.text,
      colors: myColors,
    );

    await _taskBox.add(newTask);

    _titleController.clear();
    _contentController.clear();
  }

  // UPDATE
  void _putTask(
    int index,
    String title,
    String content,
    List<String> colors,
  ) async {
    if (_titleController.text.isEmpty) return;
    if (_contentController.text.isEmpty) return;

    var newTask = TaskModel(
      title: _titleController.text,
      content: _contentController.text,
      colors: myColors,
    );

    await _taskBox.putAt(index, newTask);

    _titleController.clear();
    _contentController.clear();
  }

  // FİND
  int _findTask(String title) {
    return _taskBox.values.where((element) => element.title.toLowerCase().contains(title.toLowerCase())).length; 
  }

  // DELETE
  void _deleteTask(int index) async {
    await _taskBox.deleteAt(index);
  }

  // DELETE ALL
  void _deleteEveryone() async {
    await _taskBox.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Task Master', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blue,
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Text('Görev Yönetimi Uygulamamıza Hoş Geldiniz'),

                  TextField(
                    controller: _titleController,
                    decoration: InputDecoration(labelText: 'Başlık'),
                  ),
                  TextField(
                    controller: _contentController,
                    decoration: InputDecoration(labelText: 'Alt Başlık'),
                  ),

                  SizedBox(height: 16),

                  ElevatedButton(
                    onPressed: () async {
                      _addTask(
                        _titleController.text,
                        _contentController.text,
                        myColors,
                      );
                    },
                    child: Text('Yeni Kişi Ekle'),
                  ),

                  ElevatedButton(
                    onPressed: () async {
                      _deleteEveryone();
                    },
                    child: Text('Herkesi Sil'),
                  ),

                  ElevatedButton(
                    onPressed: () {
                      if (_titleController.text.isNotEmpty) {
                        setState(() {
                          length = _findTask(_titleController.text);
                        });
                      }
                    },
                    child: Text('Bu katarı barındıran kaç görev var: $length'),
                  ),
                ],
              ),
            ),
          ),

          // GET
          ValueListenableBuilder(
            valueListenable: _taskBox.listenable(),
            builder: (context, Box<TaskModel> box, child) {
              return SliverList(
                delegate: SliverChildBuilderDelegate(childCount: box.length, (
                  context,
                  index,
                ) {
                  final task = box.getAt(index);

                  return Card(
                    child: ListTile(
                      onTap: () {
                        _titleController.text = task?.title ?? '';
                        _contentController.text = task?.content ?? '';
                      },

                      title: Text(task?.title ?? ' '),
                      subtitle: Text(task?.content ?? ' '),

                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            onPressed: () {
                              _deleteTask(index);
                            },
                            icon: Icon(Icons.delete),
                          ),

                          IconButton(
                            onPressed: () {
                              _putTask(
                                index,
                                _titleController.text,
                                _contentController.text,
                                myColors,
                              );
                            },
                            icon: Icon(Icons.edit),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              );
            },
          ),
        ],
      ),
    );
  }
}
