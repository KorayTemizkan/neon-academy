import 'package:flutter/material.dart';

class MyTabBarView extends StatefulWidget {
  const MyTabBarView({super.key});

  @override
  State<MyTabBarView> createState() => _MyTabBarViewState();
}

// https://api.flutter.dev/flutter/material/TabBar-class.html
class _MyTabBarViewState extends State<MyTabBarView>
    with TickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Başlık rengi güncellendi
        title: const Text(
          'TabBar Sample',
          style: TextStyle(color: Colors.black),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(76),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                    'https://hips.hearstapps.com/hmg-prod/images/ferrari-e-suv-2-copy-680287cac36b2.jpg?crop=1.00xw:0.838xh;0,0.0673xh',
                  ),
                  opacity: 0.2,
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: TabBar(
                dividerColor: Colors.transparent,
                labelColor: Colors.black,
                unselectedLabelColor: const Color.fromARGB(255, 122, 112, 112),
                indicatorColor: Colors.black,
                controller: _tabController,
                tabs: const [
                  Tab(icon: Icon(Icons.security), text: "Savun"),
                  Tab(icon: Icon(Icons.bolt), text: "Güç"),
                  Tab(icon: Icon(Icons.cloud_outlined), text: "Bulut"),
                  Tab(icon: Icon(Icons.dangerous), text: "İmha"),
                ],
              ),
            ),
          ),
        ),
      ),

      body: TabBarView(
        controller: _tabController,
        children: const <Widget>[
          Center(child: Text('1. SAYFA')),
          Center(child: Text('2. SAYFA')),
          Center(child: Text('3. SAYFA')),
          Center(child: Text('4. SAYFA')),
        ],
      ),
    );
  }
}
