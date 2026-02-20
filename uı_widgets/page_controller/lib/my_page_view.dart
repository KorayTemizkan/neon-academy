import 'package:flutter/material.dart';
import 'package:page_controller/card_view.dart';

class MyPageView extends StatefulWidget {
  const MyPageView({super.key});

  @override
  State<MyPageView> createState() => _MyPageViewState();
}

// https://api.flutter.dev/flutter/widgets/PageView-class.html
class _MyPageViewState extends State<MyPageView> with TickerProviderStateMixin {
  late PageController _pageController;
  late TabController _tabController;
  int _currentPageIndex = 0;
  late List<Color> colorList = [Colors.red, Colors.blue, Colors.yellow];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _pageController = PageController();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _pageController.dispose();
    _tabController.dispose();
  }

  void _handlePageViewChanged(int currentPageIndex) {
    setState(() {
      _tabController.index = currentPageIndex;
      _currentPageIndex = currentPageIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 48),

            Expanded(
              child: PageView(
                controller: _pageController,
                // Bak bunu bilmiyordum, fonksiyonun içerisine otomatik olarak 0,1,2 fırlatıyor
                onPageChanged: _handlePageViewChanged,

                children: [
                  Center(
                    child: CardView(
                      title: 'Birinci Sayfa',
                      subtitle: 'Birinci Sayfa',
                      imageUrl:
                          'https://www.totzee.com/cdn/shop/files/Totzee-Amigurumi-Doll-Green_0.jpg?v=1728817103',
                      color: colorList[_currentPageIndex],

                    ),
                    
                  ),
                  Center(
                    child: CardView(
                      title: 'İkinci Sayfa',
                      subtitle: 'İkinci Sayfa',
                      imageUrl:
                          'https://minihobievi.com/cdn/shop/products/AmigurumiTavsanOyuncakPembe_1200x1200.jpg?v=1738063525',
                      color: colorList[_currentPageIndex],
                    ),
                  ),
                  Center(
                    child: CardView(
                      title: 'Üçüncü Sayfa',
                      subtitle: 'Üçüncü Sayfa',
                      imageUrl:
                          'https://abcwools.com/wp-content/uploads/2023/07/How-To-Make-Amigurumi-Toys-For-Beginners-With-ABC-Wools.webp',
                      color: colorList[_currentPageIndex],

                    ),
                    
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TabPageSelector(
                controller: _tabController,
                selectedColor: colorList[_currentPageIndex],
                color: colorList[_currentPageIndex].withAlpha(10),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
