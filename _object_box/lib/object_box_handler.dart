/*

ObjectBox mobil dünyadaki en hızlı NoSQL veritabanlarından biridir.
Sadece Flutter için değil; Android, iOS ve diğer platformlar için de geliştirilmiş, yüksek performanslı, ACID uyumlu bir nesne yönelimli veritabanıdır.

* ACID Uyumu: Uygulama aniden kapansa bile verilerin bozulmayacağını garanti eder.
* İlişkisel Veri(Relation): Hive'de ürün ve kategori arasında bağ kurmak zordur ama burada bire bir çoka çok gibi ilişkiler kurulabilir
* Daha büyük verileri daha düzenli yazar, takılma olmaz.

Burayı yazdıktan sonra terminale şunu yaz : flutter pub run build_runner build --delete-conflicting-outputs
*/

import 'package:_object_box/coral_fragment_model.dart';
import 'package:_object_box/objectbox.g.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart'
    as p; // Buradaki 'as p' takma isimdir. Bu kullanım da hoşmuş
// / \ sorun olmasın diye path paketini kullanıyoruz

class ObjectBoxHandler {
  late final Store store; // Ana yapıdır.
  late final Box<CoralFragmentModel> coralBox; // Açılan bir kutudur.

  // Private Constructor böyle yazılıyormuş. Kontrolün sadece burada olması için yazılır
  ObjectBoxHandler._create(this.store) {
    coralBox = Box<CoralFragmentModel>(store);
  }

  static Future<ObjectBoxHandler> create() async {
    // Uygun bir dosya konumu bulunur.
    final docsDir = await getApplicationDocumentsDirectory();
    // İlgili konuma veritabanı açılışı yapılır.
    final store = await openStore(
      directory: p.join(docsDir.path, 'aqualis_db'),
    );
    return ObjectBoxHandler._create(store);
  }

  // GET, stream varken pek işimize yaramaz ama dışa aktarma gibi durumlarda yarar
  List<CoralFragmentModel> getAllFragments() {
    return coralBox.getAll();
  }

  // CREATE ve UPDATE, eğer fragment.id = 0 ise yeni ekler, id varsa o kaydı günceller
  int saveFragment(CoralFragmentModel fragment) {
    return coralBox.put(fragment);
  }

  // CREATE, toplu veri ekleme
  List<int> saveManyFragment(List<CoralFragmentModel> fragments) {
    return coralBox.putMany(fragments);
  }

  // DELETE
  bool deleteFragment(int id) {
    return coralBox.remove(id);
  }

  // SEARCH
  List<CoralFragmentModel> searchFragments(String text) {
    // caseSensitive = büyük, küçük harf ayrımı yapma
    // CoralFragmentModel_ bu oluşturduğumuz .g dart dosyasındaki sınıfmış
    final query = coralBox
        .query(
          CoralFragmentModel_.title
              .contains(text, caseSensitive: false)
              .or(
                CoralFragmentModel_.content.contains(
                  text,
                  caseSensitive: false,
                ),
              ),
        )
        .build();
    // query kısmı bir tarif, build kısmı ise bir motordur.

    // Çok katmanlıymış bu ObjectBox beğendim.
    final results = query.find();
    query.close(); // Bellek yönetimi için gerekliymiş
    return results;
  }
}
