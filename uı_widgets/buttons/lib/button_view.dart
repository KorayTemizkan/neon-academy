import 'package:flutter/material.dart';

class ButtonView extends StatefulWidget {
  const ButtonView({super.key});

  @override
  State<ButtonView> createState() => _ButtonViewState();
}

class _ButtonViewState extends State<ButtonView>
    with SingleTickerProviderStateMixin {
  String debug = 'debug';
  String debug2 = 'test';
  Color myColor = Colors.red;

  // Aynı 
  late AnimationController controller;
  bool isHighlighted = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = AnimationController(
      duration: const Duration(milliseconds: 100), // 100 milisaniye boyunca rastgele sayılar üretir
      vsync: this, // ekranın yenileme hızına ayak uydurur
    );
  }

  void triggerShake() {
    // Önce 0'dan x birim kadar ilerle sonra geri dön
    controller.forward(from: 0).then((_) {
      controller.reverse().then((_) {
        // ses çalma kodunu buraya koyabiliriz ama gerek yok gibi mantığı çözdüm
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // Tween, Controllerden gelen değeri 0-15 arası oranlayarak genişletir.
    // Curve, doğrusal bir artış sağlar, elasticIn yay gibi davrandırır
    final Animation<double> offsetAnimation = Tween(
      begin: 0.0,
      end: 15.0,
    ).chain(CurveTween(curve: Curves.elasticIn)).animate(controller);

    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: [
              SizedBox(height: 24),

              /*
              Task 1: As the sheriff of this small western town, you need to create a button that, when tapped,
              displays a drop-down menu with a list of options. Each option should be a separate button that,
              when tapped, performs a different action. For example, one option could be to call for backup,
              and another option could be to issue a warning to the townspeople.
              */
              Text(
                'Debug: $debug',
                style: TextStyle(fontSize: 48),
                textAlign: TextAlign.center,
              ),

              SizedBox(height: 16),
              Divider(height: 2, color: Colors.grey),
              SizedBox(height: 16),

              Text('1.görev: DropDownButton'),
              DropdownButton<String>(
                hint: Text('DropDownButton'),
                items: [
                  DropdownMenuItem<String>(
                    value: 'debug',
                    child: Text('debug'),
                  ),
                  DropdownMenuItem<String>(
                    value: 'backup',
                    child: Text('backup'),
                  ),
                  DropdownMenuItem<String>(value: 'warn', child: Text('warn')),
                ],
                value: debug,
                onChanged: (String? value) {
                  setState(() {
                    debug = value!;
                  });
                },
              ),

              SizedBox(height: 16),
              Divider(height: 2, color: Colors.grey),
              SizedBox(height: 16),

              /*
              Task 2: As the owner of the local saloon, you need to create a button that, when tapped, displays the daily specials.
              The button should have a background image, set the title alignment to center, set the font size to 20,
              and also add a drop shadow. You also want to set corner radius of 10, a border width of 2, a border color of blue,
              set the background color to red and also set the button's gradient to 0.5 to make it look more professional.
              */
              Text('2.görev: Elevated Button'),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    debug = 'backup';
                  });
                },
                child: Text(
                  'Test',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),

                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red, // Doğrudan renk
                  elevation: 5, // Doğrudan sayı
                  alignment: Alignment.center,
                  side: const BorderSide(width: 2, color: Colors.lightBlue),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),

              SizedBox(height: 16),
              Divider(height: 2, color: Colors.grey),
              SizedBox(height: 16),

              Text('3.görev: Container ile kendi butonum'),
              SizedBox(height: 16),
              GestureDetector(
                onTap: () {
                  setState(() {
                    debug = 'warn';
                  });
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  padding: const EdgeInsets.all(8),

                  height: 48,
                  width: 148,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(
                        'https://static.vecteezy.com/system/resources/thumbnails/055/065/087/small/vault-icon-3d-illustration-png.png',
                      ),
                      // Tint kısmı
                      colorFilter: ColorFilter.mode(
                        Colors.purple.withAlpha(70), BlendMode.srcATop /*resmin üstüne yerleştirir srcATop*/),
                      fit: BoxFit.cover,
                    ),
                    gradient: LinearGradient(
                      colors: [
                        Colors.red,
                        const Color.fromARGB(255, 234, 234, 234),
                        Colors.orange,
                      ],
                    ),
                    color: Colors.red,
                    border: BoxBorder.all(width: 2, color: Colors.blueAccent),
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black,
                        spreadRadius: 5,
                        blurRadius: 5,
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text('Buton', style: TextStyle(fontSize: 20)),
                  ),
                ),
              ),

              SizedBox(height: 16),
              Divider(height: 2, color: Colors.grey),
              SizedBox(height: 16),

              /*
              Task 3: As the leader of the town's vigilante group, you need to create a button that, when tapped,
              highlights by changing its background color to yellow, and when released, changes back to its original color.
              Also, set the tint color of the button's image to purple to make it stand out.
              */

              // Foreground color buton gibi bileşenlerde arka plan rengi dışında kalan her şeyin rengidir
              // Tint bir ögenin önüne belirli bir renkte cam koyup bakmış gibi hissettirir
              // İmage.network içine color koyarsan bunu sağlarsın
              Text('4.görev: Basılı tutunca rengi değişen Elevated Button'),
              ElevatedButton.icon(
                style: ButtonStyle(
                  // Koray bu yöntemi daha önce görmüştüm ama kullanmamıştım. Kullanışlıymış
                  // resolveWith bir fonksiyon bekliyor, biz de buna states ile durumları gönderiyoruz
                  backgroundColor: WidgetStateProperty.resolveWith<Color>((
                    states,
                  ) {
                    if (states.contains(WidgetState.pressed)) {
                      return Colors.yellow;
                    } else {
                      return Colors.blue;
                    }
                  }),

                  foregroundColor: WidgetStatePropertyAll(Colors.purple),
                
                ),
                icon: const Icon(Icons.search, size: 28),

                onPressed: () {},
                label: Text('Button'),
              ),

              SizedBox(height: 16),
              Divider(height: 2, color: Colors.grey),
              SizedBox(height: 16),

              /*
              Task 4: As the town's blacksmith, you need to create a button that, when tapped,
              enables or disables an additional button on the screen.
              Also, set the state of the button to disabled by default so that it's only available when the blacksmith is in the shop.
              */
              Text(
                '5.görev: debug=backup olmadığı sürece çalışmayan ikinci buton',
              ),
              Row(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        debug = 'backup';
                      });
                    },
                    child: Text('Birinci Buton'),
                  ),

                  // onPressed: null, değersen hep inaktif olur unutma
                  ElevatedButton(
                    onPressed: debug == 'backup'
                        ? () {
                            setState(() {
                              debug2 = 'sorun yok';
                            });
                          }
                        : null,
                    child: Text('İkinci Buton'),
                  ),
                ],
              ),

              SizedBox(height: 16),
              Divider(height: 2, color: Colors.grey),
              SizedBox(height: 16),

              /*
              Task 5: As the town's bank robber, you need to create a button that, when tapped,
              performs a shake animation and also play a sound to simulate the vault shaking.
              Also, set the button's image to change when the button is highlighted to show the progress of the robbery.
              */
              Text('6.görev: Tıklayınca sallanan animasyonlu buton, basılı tutunca animasyon değişiyor'),
              
              //Animated builder sadece bu kısmı yeniden çiz der, sayfayı yormaz
              AnimatedBuilder(
                animation: controller,
                builder: (context, child) {
                  // Widgetin kapladığı asıl alanı bozmadan çocuk nesneyi hareket ettirir.
                  return Transform.translate(
                    offset: Offset(offsetAnimation.value, 0),
                    child: GestureDetector(
                      onTapDown: (_) => setState(() {
                        isHighlighted = true;
                      }),
                      onTapUp: (_) {
                        setState(() {
                          isHighlighted = false;
                          triggerShake();
                        });
                      },
                      child: Image.network(
                        isHighlighted
                            ? 'https://www.shutterstock.com/image-vector/vector-cartoon-thief-running-stolen-600nw-2513337239.jpg'
                            : 'https://static.vecteezy.com/system/resources/thumbnails/055/065/087/small/vault-icon-3d-illustration-png.png',
                        width: 150,
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
