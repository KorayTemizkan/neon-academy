# neon_cubit

A new Flutter project. -> Her şeyi sıfırdan öğreniyormuşum gibi çalışıyorum

//////////////////////////////////////////////////
//////////////////////////////////////////////////

# Durum (State) Nedir?

*** Bir uygulamada state (durum), o an ekranda gördüğün her şeydir.

- Kullanıcı giriş yaptı mı? (isLoggedIn)
- Sepette kaç ürün var? (int cartCount)
- Veriler internetten yükleniyor mu? (bool isLoading)

# Durum Yönetimi (State Management) Nedir?

*** Bu verilerin uygulama içinde nasıl hareket edeceğini yönetme şeklidir.

- Listeye yeni ögeler geldi mi?
- Beğeni sayısı arttı mı?

# BLoC (Business Logic Component - İş Mantığı Parçacığı) Nedir?

* Müşteri fiş doldurur (event) -> Fiş sıraya girer ve işlenir -> Yemek gelir (state)

*** Google tarafından geliştirilen ve "İş Mantığını (Business Logic)" , "Arayüzden (UI)" tamamen ayırmayı hedefleyen bir MİMARİDİR.

- Olay temellidir. Kullanıcı bir düğmeye basmaz, bir event gönderir (AddProductEvent)

- Akış (Stream) kullanır, BLoc bu eventi alır, işler ve dışarıya bir state fırlatır

- Kural: UI sadece event gönderir ve gelen stateyi dinler, arada ne olup bittiğini bilmez. (Api çağrısı vb.)

# Cubit Nedir?

* Müşteriden sipariş sözlü olarak alınır -> Mutfaktan yemek getirilir

*** BLoC'un daha basit halidir. Kütüphanenin küçük bir parçasıdır

- Event sınıfları oluşturmak yerine doğruca fonksiyonları çağırırsın (increment())

- Daha az kod vardır, doğrudan emit komutuyla yeni state yayar mesela.

- BLoC'a göre öğrenmesi daha kolaydır. Providera daha çok benzer


//////////////////////////////////////////////////
//////////////////////////////////////////////////

# Yararlanılan Kaynaklar

https://bloclibrary.dev/tutorials/flutter-counter/
https://gemini.google.com/app