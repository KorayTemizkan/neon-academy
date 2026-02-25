import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grid_view/app_detail_view.dart';
import 'package:grid_view/app_list.dart';
import 'package:grid_view/app_model.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class MyGridView extends StatefulWidget {
  MyGridView({super.key});

  @override
  State<MyGridView> createState() => _MyGridViewState();
}

class _MyGridViewState extends State<MyGridView> {
  // JSON'dan çekmeyi de yapabilirdim ilk haftaki projelerde olduğu gibi ya da Tığcık projemde olduğu gibi ama asıl odak burası değil artık diye yapmadım
  final List<AppModel> myAppList = appList;
  List<AppModel> selectedApps = [];
  int mySize = 2;

  // url_launcher paketinin kurulumu
  // https://pub.dev/packages/url_launcher
  Future<void> _launchUrl(Uri url) async {
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }

  // share_plus paketinin kurulumu
  // https://pub.dev/packages/share_plus
  Future<void> _shareLink(String url) async {
    SharePlus.instance.share(ShareParams(text: 'check out my website $url'));
  }

  Future<void> _changeSize() async {
    setState(() {
      if (mySize == 2) {
        mySize = 3;
      } else {
        mySize = 2;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Grid View', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blue,
      ),

      body: RefreshIndicator(
        color: Colors.white,
        backgroundColor: Colors.blue,
        onRefresh: () async {
          await Future<void>.delayed(const Duration(seconds: 3));
        },

        // Tığcık projemde yapmıştım oradan aldım
        child: GridView.builder(
          shrinkWrap:
              true, // Normalde sonsuz uzunluk ister ama böyle yaparak içindeki çocukların boyutu kadar yer ayırdık.
          padding: const EdgeInsets.all(8),

          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: mySize, // Sütun sayımız sabit 2 olacak
            mainAxisExtent: 240, // Her bir kutunun yüksekliği sabit 120 olacak
            crossAxisSpacing:
                8, // Yan yana bulunan iki kutunun arasındaki boşluk sabit 8 olacak
            mainAxisSpacing:
                8, // Alt alta gelen iki kutunun arasındaki boşluk sabit 8 olacak
          ),

          itemCount: 6,
          itemBuilder: (context, index) {
            final app = myAppList[index];

            // https://api.flutter.dev/flutter/cupertino/CupertinoContextMenu-class.html
            return CupertinoContextMenu(
              actions: <Widget>[
                CupertinoContextMenuAction(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => AppDetailView(appModel: app),
                      ),
                    );
                  },
                  isDefaultAction: true,
                  trailingIcon: CupertinoIcons.arrow_right,
                  child: const Text('Ayrıntıları Gör'),
                ),

                CupertinoContextMenuAction(
                  onPressed: () {
                    final Uri _url = Uri.parse('${app.storeUrl}');
                    _launchUrl(_url);
                  },
                  isDefaultAction: true,
                  trailingIcon: CupertinoIcons.shopping_cart,
                  child: const Text('Mağazaya Git'),
                ),

                CupertinoContextMenuAction(
                  onPressed: () {
                    _shareLink(app.storeUrl);
                  },
                  isDefaultAction: true,
                  trailingIcon: CupertinoIcons.share,
                  child: const Text('Paylaş'),
                ),

                CupertinoContextMenuAction(
                  onPressed: () {
                    _changeSize();
                  },
                  isDefaultAction: true,
                  trailingIcon: CupertinoIcons.share,
                  child: const Text('Boyutu Değiştir'),
                ),

                CupertinoContextMenuAction(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  isDestructiveAction: true,
                  trailingIcon: CupertinoIcons.arrow_left,
                  child: const Text('Geri Dön'),
                ),
              ],
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    if (selectedApps.contains(app)) {
                      selectedApps.remove(app);
                    } else {
                      selectedApps.add(app);
                    }
                  });
                },
                child: Card(
                  color: selectedApps.contains(app) ? Colors.red : Colors.white,
                  elevation: 1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image(
                        image: NetworkImage(app.appCover),
                        fit: BoxFit.cover,
                        width: 160,
                      ),

                      SizedBox(height: 16),

                      Text(app.appName),
                      Text(app.appCategory),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
