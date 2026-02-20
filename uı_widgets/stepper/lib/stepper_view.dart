import 'package:flutter/material.dart';

class StepperView extends StatefulWidget {
  const StepperView({super.key});

  @override
  State<StepperView> createState() => _StepperViewState();
}

int bulundugumAdim = 0;
int sayi = 0;

// https://dogukancaglakpinar.medium.com/flutterda-stepper-widget-temel-%C3%B6zellikleri-ve-kullan%C4%B1m%C4%B1-4f28329953e3
class _StepperViewState extends State<StepperView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 48),
              Text('test'),

              /*
              Stepper(
                physics: const ScrollPhysics(),
                currentStep: bulundugumAdim,
                onStepTapped: (value) {
                  setState(() {
                    bulundugumAdim = value;
                  });
                },
                controlsBuilder: (context, _) {
                  return Row(
                    children: [
                      bulundugumAdim == 2
                          ? const SizedBox()
                          : TextButton(
                              onPressed: () {
                                bulundugumAdim < 2
                                    ? setState(() {
                                        bulundugumAdim += 1;
                                      })
                                    : null;
                              },
                              child: const Text('İleri'),
                            ),

                      bulundugumAdim == 0
                          ? const SizedBox()
                          : TextButton(
                              onPressed: () {
                                bulundugumAdim > 0
                                    ? setState(() => bulundugumAdim -= 1)
                                    : null;
                              },
                              child: const Text('Geri'),
                            ),
                    ],
                  );
                },
                steps: [
                  Step(
                    title: Text('Hoş Geldiniz'),
                    content: Column(
                      children: [
                        Text('Stepper Widgeti Öğreniyorum'),
                        Text('abc'),
                      ],
                    ),
                    isActive: bulundugumAdim >= 0,
                    state: bulundugumAdim >= 0
                        ? StepState.complete
                        : StepState.disabled,
                  ),

                  Step(
                    title: Text('Giriş Yap'),
                    content: Column(
                      children: [
                        TextField(
                          decoration: InputDecoration(
                            labelText: 'E-Posta Giriniz',
                          ),
                        ),

                        TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Şifre Giriniz',
                          ),
                        ),
                      ],
                    ),
                    isActive: bulundugumAdim >= 1,
                    state: bulundugumAdim >= 0
                        ? StepState.complete
                        : StepState.disabled,
                  ),

                  Step(
                    title: Text('İşlem Tamamlandı'),
                    content: Column(
                      children: [Text('Stepper Widgeti Kullanımı Öğrenildi')],
                    ),
                    isActive: bulundugumAdim >= 2,
                    state: bulundugumAdim >= 0
                        ? StepState.complete
                        : StepState.disabled,
                  ),
                ],
              ),
              */
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.pinkAccent,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Stepper(
                    connectorColor: WidgetStatePropertyAll(Colors.white),
                    physics: const ScrollPhysics(),
                    currentStep: bulundugumAdim,
                    onStepTapped: (value) {
                      setState(() {
                        sayi = value * 25;
                        bulundugumAdim = value;
                      });
                    },
                    controlsBuilder: (context, _) {
                      return Row(
                        children: [
                          // İlk ve son adımlarda soldaki ve sağdaki butonların gözükmemesini sağlar
                          bulundugumAdim == 2
                              ? const SizedBox()
                              : GestureDetector(
                                  onTap: () {
                                    bulundugumAdim < 2
                                        ? setState(() {
                                            bulundugumAdim += 1;
                                            sayi += 25;
                                          })
                                        : null;
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(16),

                                      image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: NetworkImage(
                                          'https://i.ebayimg.com/images/g/kZoAAOSw34ZkVNKM/s-l1200.jpg',
                                        ),
                                        opacity: 0.2,
                                      ),
                                    ),
                                    child: Row(
                                      children: [
                                        Icon(Icons.favorite),
                                        Text(
                                          'İleri',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),

                          SizedBox(width: 8),

                          bulundugumAdim == 0
                              ? const SizedBox()
                              : GestureDetector(
                                  onTap: () {
                                    bulundugumAdim > 0
                                        ? setState(() {
                                            bulundugumAdim -= 1;
                                            sayi -= 25;
                                          })
                                        : null;
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(16),
                                      image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: NetworkImage(
                                          'https://wallpapercave.com/wp/wp2190018.jpg',
                                        ),
                                        opacity: 0.2,
                                      ),
                                    ),
                                    child: Row(
                                      children: [
                                        Icon(Icons.heart_broken),
                                        Text(
                                          'Geri  ',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                        ],
                      );
                    },

                    steps: [
                      Step(
                        title: Text('1. adım, Sayı $sayi'),
                        content: Column(children: [Text('Merhaba')]),
                      ),

                      Step(
                        title: Text('2. adım, Sayı $sayi'),
                        content: Column(children: [Text('Naber')]),
                      ),

                      Step(
                        title: Text('3. adım, Sayı $sayi'),
                        content: Column(children: [Text('Nasılsın')]),
                      ),
                    ],

                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/*
TextButton.icon(
                                      style: ButtonStyle(
                                    backgroundColor: WidgetStatePropertyAll(
                                      Colors.white,
                                    ),
                                  ),
                                icon: Icon(Icons.heart_broken),
                                  onPressed: () {
                                    bulundugumAdim < 2
                                        ? setState(() {
                                            bulundugumAdim += 1;
                                          })
                                        : null;
                                  },
                                  label: const Text('İleri'),
                                ),
*/
