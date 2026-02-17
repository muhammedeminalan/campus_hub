# 📦 Core Utils — Kullanım Kılavuzu

> **CampusHub** projesinin `lib/core/utils` altındaki tüm yardımcı yapılar,
> extension'lar ve özel widget'lar bu dokümanda kategorize edilerek açıklanmıştır.

---

## 📑 İçindekiler

### Extensions
- [1. Context Extensions](#1-context-extensions)
- [2. Widget Extensions](#2-widget-extensions)
  - [2.1 Padding & Margin](#21-padding--margin)
  - [2.2 Size & Constraints](#22-size--constraints)
  - [2.3 Alignment & Center](#23-alignment--center)
  - [2.4 Expanded & Flexible](#24-expanded--flexible)
  - [2.5 Container](#25-container)
  - [2.6 Decoration & Interaction](#26-decoration--interaction)
  - [2.7 Image Extensions](#27-image-extensions)
- [3. Layout Extensions](#3-layout-extensions)
  - [3.1 Column Extensions](#31-column-extensions)
  - [3.2 Row Extensions](#32-row-extensions)
  - [3.3 Axis (Column & Row) Alignment](#33-axis-column--row-alignment)
- [4. Primitive Extensions](#4-primitive-extensions)
  - [4.1 String Extensions](#41-string-extensions)
  - [4.2 Num Extensions](#42-num-extensions)
  - [4.3 Text Builder](#43-text-builder)
- [5. Navigation Extensions](#5-navigation-extensions)
  - [5.1 Navigator Extensions](#51-navigator-extensions)
  - [5.2 Route Transitions](#52-route-transitions)
- [6. Utility Extensions](#6-utility-extensions)

### Widgets
- [7. CostumButton](#7-costumbutton)
- [8. CostumIconButton](#8-costumiconbutton)
- [9. CostumAppBar](#9-costumappbar)
- [10. CostumBottomSheet](#10-costumbottomsheet)

---

## Extensions

---

### 1. Context Extensions

📄 [`extensions/context/context_extensions.dart`](extensions/context/context_extensions.dart)

`BuildContext` üzerinden tema, renk, boyut ve metin stillerine kısa yoldan erişim sağlar.

#### Ekran Boyutları

| Property / Metot | Dönüş Tipi | Açıklama |
|---|---|---|
| `context.screenSize` | `Size` | Ekran boyutları |
| `context.height` | `double` | Ekran yüksekliği |
| `context.width` | `double` | Ekran genişliği |
| `context.screenHeight(0.5)` | `double` | Ekran yüksekliğinin %50'si |
| `context.scrennWidth(0.3)` | `double` | Ekran genişliğinin %30'u |
| `context.divider()` | `Divider` | Ayırıcı çizgi |

#### Tema & ColorScheme

| Property | Dönüş Tipi | Açıklama |
|---|---|---|
| `context.theme` | `ThemeData` | Ana tema verisi |
| `context.colorScheme` | `ColorScheme` | Renk şeması |
| `context.primaryColor` | `Color` | Primary renk |
| `context.secondaryColor` | `Color` | Secondary renk |
| `context.errorColor` | `Color` | Hata rengi |
| `context.surfaceColor` | `Color` | Surface renk |
| `context.onPrimaryColor` | `Color` | Primary üzeri renk |
| `context.onSecondaryColor` | `Color` | Secondary üzeri renk |
| `context.onSurfaceColor` | `Color` | Surface üzeri renk |
| `context.outlineColor` | `Color` | Outline renk |

#### Semantic Renkler (AppColors)

| Property | Açıklama |
|---|---|
| `context.successColor` | Başarı rengi |
| `context.warningColor` | Uyarı rengi |
| `context.infoColor` | Bilgi rengi |
| `context.dividerColor` | Ayırıcı rengi |
| `context.borderColor` | Kenarlık rengi |
| `context.borderFocusedColor` | Odaklı kenarlık |
| `context.shadowColor` | Gölge rengi |
| `context.shimmerBaseColor` | Shimmer taban |
| `context.shimmerHighlightColor` | Shimmer vurgu |

#### Text Renkleri

| Property | Açıklama |
|---|---|
| `context.textPrimaryColor` | Ana metin rengi |
| `context.textSecondaryColor` | İkincil metin rengi |
| `context.textHintColor` | İpucu metin rengi |
| `context.textDisabledColor` | Devre dışı metin rengi |

#### TextStyle Kısaltmaları

| Property | Material 3 Karşılığı |
|---|---|
| `context.displayLarge` | `textTheme.displayLarge` |
| `context.displayMedium` | `textTheme.displayMedium` |
| `context.displaySmall` | `textTheme.displaySmall` |
| `context.headlineLarge` | `textTheme.headlineLarge` |
| `context.headlineMedium` | `textTheme.headlineMedium` |
| `context.headlineSmall` | `textTheme.headlineSmall` |
| `context.titleLarge` | `textTheme.titleLarge` |
| `context.titleMedium` | `textTheme.titleMedium` |
| `context.titleSmall` | `textTheme.titleSmall` |
| `context.bodyLarge` | `textTheme.bodyLarge` |
| `context.bodyMedium` | `textTheme.bodyMedium` |
| `context.bodySmall` | `textTheme.bodySmall` |
| `context.labelLarge` | `textTheme.labelLarge` |
| `context.labelMedium` | `textTheme.labelMedium` |
| `context.labelSmall` | `textTheme.labelSmall` |

#### Widget Theme Kısaltmaları

| Property | Dönüş Tipi |
|---|---|
| `context.appBarTheme` | `AppBarThemeData` |
| `context.cardTheme` | `CardThemeData` |
| `context.inputTheme` | `InputDecorationThemeData` |
| `context.elevatedButtonTheme` | `ElevatedButtonThemeData` |
| `context.outlinedButtonTheme` | `OutlinedButtonThemeData` |
| `context.bottomNavTheme` | `BottomNavigationBarThemeData` |

```dart
// Kullanım
Text(
  'Merhaba',
  style: context.headlineMedium.copyWith(color: context.primaryColor),
);

Container(
  width: context.scrennWidth(0.8),
  height: context.screenHeight(0.3),
  color: context.surfaceColor,
);
```

---

### 2. Widget Extensions

---

#### 2.1 Padding & Margin

📄 [`extensions/widget/paddings_extensions.dart`](extensions/widget/paddings_extensions.dart)

| Metot | Açıklama | Örnek |
|---|---|---|
| `.paddingAll(16)` | Tüm kenarlara eşit padding | `Text('Hi').paddingAll(16)` |
| `.paddingHorizontal(12)` | Yatay padding | `Icon(Icons.star).paddingHorizontal(12)` |
| `.paddingVertical(8)` | Dikey padding | `Text('Hi').paddingVertical(8)` |
| `.paddingSymmetric(h: 16, v: 8)` | Simetrik padding | `child.paddingSymmetric(h: 16, v: 8)` |
| `.paddingOnly(left: 8, top: 4)` | Belirli kenarlar | `child.paddingOnly(left: 8)` |
| `.padding(EdgeInsets.all(10))` | EdgeInsets ile | `child.padding(EdgeInsets.all(10))` |
| `.marginAll(16)` | Tüm kenarlara margin | `child.marginAll(16)` |
| `.marginHorizontal(12)` | Yatay margin | `child.marginHorizontal(12)` |
| `.marginVertical(8)` | Dikey margin | `child.marginVertical(8)` |
| `.marginOnly(left: 8)` | Belirli kenarlar | `child.marginOnly(left: 8)` |

```dart
Text('CampusHub')
    .paddingSymmetric(h: 16, v: 8)
    .marginAll(12);
```

---

#### 2.2 Size & Constraints

📄 [`extensions/widget/sizebox_extensions.dart`](extensions/widget/sizebox_extensions.dart)

| Metot | Açıklama | Örnek |
|---|---|---|
| `.sized(width: 100, height: 50)` | Sabit boyut | `child.sized(width: 100)` |
| `.square(48)` | Kare boyut | `Icon(Icons.star).square(48)` |
| `.expandedWidth` | Sonsuz genişlik | `child.expandedWidth` |
| `.expandedHeight` | Sonsuz yükseklik | `child.expandedHeight` |
| `.constrained(...)` | Min/Max kısıtlama | `child.constrained(maxWidth: 300)` |

```dart
Image.asset('logo.png')
    .square(80)
    .center;
```

---

#### 2.3 Alignment & Center

📄 [`extensions/widget/center_extensions.dart`](extensions/widget/center_extensions.dart)

| Property / Metot | Açıklama |
|---|---|
| `.center` | Ortalar |
| `.alignLeft` | Sola hizalar |
| `.alignRight` | Sağa hizalar |
| `.alignTop` | Üste hizalar |
| `.alignBottom` | Alta hizalar |
| `.align(Alignment.topRight)` | Özel hizalama |

```dart
Text('Ortalandı').center;
Icon(Icons.arrow).alignRight;
```

---

#### 2.4 Expanded & Flexible

📄 [`extensions/widget/expanded_extensions.dart`](extensions/widget/expanded_extensions.dart)

| Metot | Açıklama |
|---|---|
| `.expanded(flex: 1)` | `Expanded` ile sarar |
| `.flexible(flex: 1, fit: FlexFit.loose)` | `Flexible` ile sarar |

```dart
Row(children: [
  Text('Sol').expanded(flex: 2),
  Text('Sağ').expanded(),
]);
```

---

#### 2.5 Container

📄 [`extensions/widget/container_extensions.dart`](extensions/widget/container_extensions.dart)

Widget'ı özelleştirilebilir `Container` ile sarar. Tüm parametreler opsiyoneldir.

| Parametre | Tip | Açıklama |
|---|---|---|
| `alignment` | `AlignmentGeometry?` | İçerik hizalama |
| `padding` | `EdgeInsetsGeometry?` | İç boşluk |
| `margin` | `EdgeInsetsGeometry?` | Dış boşluk |
| `width` / `height` | `double?` | Boyut |
| `color` | `Color?` | Arka plan rengi |
| `borderRadius` | `double?` | Köşe yuvarlama |
| `gradient` | `Gradient?` | Gradient arka plan |
| `border` | `BoxBorder?` | Kenarlık |
| `boxShadow` | `List<BoxShadow>?` | Gölge |
| `decoration` | `Decoration?` | Özel dekorasyon |
| `transform` | `Matrix4?` | Dönüşüm matrisi |
| `clipBehavior` | `Clip` | Kırpma davranışı |

```dart
Text('Kutu')
    .container(
      color: Colors.blue,
      padding: EdgeInsets.all(16),
      borderRadius: 12,
      boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 8)],
    );
```

---

#### 2.6 Decoration & Interaction

📄 [`extensions/widget/widget_extensions.dart`](extensions/widget/widget_extensions.dart)

**Extension adı:** `WidgetDecorationExtensions`

##### Dekorasyon

| Metot | Açıklama |
|---|---|
| `.roundedBox(...)` | Yuvarlak kutulama (radius, color, gradient, border, shadow, padding, margin) |
| `.withBackground(color, radius: 8)` | Arka plan rengi |
| `.withShadow(...)` | Gölge ekleme |
| `.asCard(elevation: 2, radius: 12)` | Card widget'ına dönüştürme |
| `.withBorder(color, width, radius)` | Kenarlık ekleme |

```dart
// Yuvarlak kapsül
Text('Tag').roundedBox(
  radius: 20,
  backgroundColor: Colors.blue.shade50,
  innerPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
);

// Kart görünümü
Column(children: [...]).asCard(elevation: 4, radius: 16);

// Gölge
Container(child: child).withShadow(blurRadius: 12, offset: Offset(0, 4));
```

##### Etkileşim

| Metot | Açıklama |
|---|---|
| `.onTap(() {})` | Dokunma (GestureDetector) |
| `.onInkTap(() {})` | Material ripple efekti (InkWell) |
| `.onLongPress(() {})` | Uzun basma |

```dart
Text('Tıkla').onTap(() => print('tap'));
ListTile(...).onInkTap(() => navigate(), borderRadius: 12.radius);
```

##### Görünürlük & Opacity

| Metot | Açıklama |
|---|---|
| `.withVisibility(bool)` | Göster/Gizle |
| `.withOpacity(0.5)` | Saydamlık (0.0 – 1.0) |

```dart
Text('Gizli').withVisibility(isLoggedIn);
Icon(Icons.lock).withOpacity(0.3);
```

##### Dönüştürme & Konum

| Metot | Açıklama |
|---|---|
| `.rotated(angle)` | Döndürme (radyan) |
| `.scaled(1.5)` | Ölçekleme |
| `.translated(Offset(10, 0))` | Kaydırma |

```dart
Icon(Icons.refresh).rotated(0.5);
Text('Büyük').scaled(1.2);
```

##### Yardımcı Sarımlayıcılar

| Metot | Açıklama |
|---|---|
| `.withTooltip('İpucu')` | Tooltip |
| `.asHero('tag')` | Hero animasyonu |
| `.withAspectRatio(16/9)` | En-boy oranı |
| `.safeArea()` | SafeArea |
| `.ignorePointer()` | Dokunmayı yok say |
| `.absorbPointer()` | Dokunmayı yut |

```dart
Image.network(url).asHero('profile_photo');
VideoPlayer().withAspectRatio(16 / 9);
```

##### Klip & Dairesel

| Metot | Açıklama |
|---|---|
| `.clipRect()` | Dikdörtgen kırpma |
| `.clipOval()` | Oval kırpma |
| `.clipRounded(12)` | Yuvarlak köşe kırpma |
| `.asCircle(size, backgroundColor, border, shadow)` | Dairesel container (avatar vb.) |

```dart
Image.network(url).asCircle(size: 80, backgroundColor: Colors.grey);

Image.asset('avatar.png').asCircle(
  size: 64,
  border: Border.all(color: Colors.white, width: 3),
  shadow: [BoxShadow(color: Colors.black26, blurRadius: 8)],
);

Image.file(photo).clipRounded(16);
```

---

#### 2.7 Image Extensions

📄 [`extensions/widget/images_extensions.dart`](extensions/widget/images_extensions.dart)

Image widget'larına şekil, filtre, overlay ve animasyon kısayolları;
String'den hızlıca Image oluşturma; ImageProvider'dan widget üretme.

##### `ImageExtensions` on `Image` — Şekil

| Metod | İmza | Açıklama |
|---|---|---|
| `rounded` | `Widget rounded(double radius, {Clip clip})` | Köşeleri yuvarlatılmış resim |
| `circular` | `Widget circular({double? size})` | Daire şeklinde kırpma |
| `bordered` | `Widget bordered({Color color, double width, double? radius, BoxShape shape})` | Kenarlık ekler |
| `circleAvatar` | `Widget circleAvatar({double size, Color? borderColor, double borderWidth, Color? backgroundColor, List<BoxShadow>? shadow})` | Avatar tarzı dairesel resim |

```dart
// Köşe yuvarlatma
Image.asset('photo.png').rounded(16)

// Daire kırpma
Image.network(url).circular(size: 80)

// Kenarlıklı
Image.asset('photo.png').bordered(color: Colors.white, width: 3, radius: 12)

// Avatar
Image.network(url).circleAvatar(
  size: 60,
  borderColor: Colors.white,
  borderWidth: 2,
  shadow: [BoxShadow(color: Colors.black26, blurRadius: 8)],
)
```

##### `ImageExtensions` on `Image` — Gölge & Filtre

| Metod | İmza | Açıklama |
|---|---|---|
| `shadow` | `Widget shadow({Color color, double blurRadius, Offset offset, double spreadRadius, double? borderRadius})` | Kutu gölgesi |
| `colorFiltered` | `Widget colorFiltered({required Color color, BlendMode blendMode})` | Renk filtresi |
| `grayscale` | `Widget grayscale()` | Siyah-beyaz |
| `sepia` | `Widget sepia()` | Sepya (antik) efekti |
| `opacity` | `Widget opacity(double value)` | Opaklık ayarı |
| `blurred` | `Widget blurred({double sigmaX, double sigmaY, TileMode tileMode})` | Bulanıklaştırma |

```dart
// Gölge + rounded
Image.asset('photo.png').rounded(12).shadow(blurRadius: 10)

// Siyah-beyaz
Image.network(url).grayscale()

// Sepya
Image.asset('old.png').sepia()

// Renk filtresi
Image.asset('photo.png').colorFiltered(
  color: Colors.red,
  blendMode: BlendMode.colorBurn,
)

// Bulanık
Image.asset('bg.png').blurred(sigmaX: 5, sigmaY: 5)

// Yarı saydam
Image.network(url).opacity(0.6)
```

##### `ImageExtensions` on `Image` — Boyut & Overlay & Animasyon

| Metod | İmza | Açıklama |
|---|---|---|
| `sized` | `Widget sized({double? width, double? height, BoxFit fit})` | Sabit boyut |
| `ratio` | `Widget ratio(double aspectRatio)` | En-boy oranı |
| `gradientOverlay` | `Widget gradientOverlay({required List<Color> colors, ...})` | Gradient kaplama |
| `colorOverlay` | `Widget colorOverlay(Color color, {double? borderRadius})` | Renk katmanı |
| `fadeIn` | `Widget fadeIn({Duration duration, Curve curve})` | Fade-in animasyonu |

```dart
// Sabit boyut
Image.network(url).sized(width: 200, height: 150, fit: BoxFit.cover)

// Gradient overlay (karanlık alt kısım)
Image.asset('banner.png').gradientOverlay(
  colors: [Colors.transparent, Colors.black87],
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
)

// Fade-in
Image.network(url).fadeIn(duration: Duration(milliseconds: 500))

// Zincirleme: rounded + shadow + gradient overlay
Image.asset('banner.png')
  .rounded(16)
  .shadow(blurRadius: 12)
```

##### `StringImageExtensions` on `String`

| Metod | Dönüş | Açıklama |
|---|---|---|
| `asAssetImage(...)` | `Image` | Asset path → `Image.asset` |
| `asNetworkImage(...)` | `Image` | URL → `Image.network` |
| `asSmartNetworkImage(...)` | `Widget` | URL → loading spinner + hata widget'ı |
| `toAssetImageProvider(...)` | `AssetImage` | → AssetImage provider |
| `toNetworkImageProvider(...)` | `NetworkImage` | → NetworkImage provider |
| `asDecorationImage(...)` | `DecorationImage` | Asset → Container arka planı |
| `asNetworkDecorationImage(...)` | `DecorationImage` | URL → Container arka planı |

```dart
// Asset'ten Image oluşturma
'assets/images/logo.png'.asAssetImage(width: 120, fit: BoxFit.contain)

// Network'ten Image — zincirleme ile
'https://example.com/photo.jpg'.asNetworkImage(
  width: 200,
  fit: BoxFit.cover,
).rounded(12).shadow()

// Akıllı network (loading + error handling)
'https://example.com/photo.jpg'.asSmartNetworkImage(
  width: 200,
  height: 200,
  fit: BoxFit.cover,
  borderRadius: 12,
)

// Container arka planı olarak
Container(
  decoration: BoxDecoration(
    image: 'assets/bg.png'.asDecorationImage(fit: BoxFit.cover),
  ),
)

// Provider'dan CircleAvatar
'https://example.com/avatar.jpg'
  .toNetworkImageProvider()
  .toCircleAvatar(radius: 30)
```

##### `ImageProviderExtensions` on `ImageProvider`

| Metod | Dönüş | Açıklama |
|---|---|---|
| `toImage(...)` | `Image` | Provider → Image widget |
| `toDecorationImage(...)` | `DecorationImage` | Provider → DecorationImage |
| `toCircleAvatar(...)` | `CircleAvatar` | Provider → CircleAvatar |
| `toInk(...)` | `Ink` | Provider → Ink (InkWell içi arka plan) |

```dart
// AssetImage'dan widget
const AssetImage('assets/logo.png').toImage(width: 100, fit: BoxFit.contain)

// NetworkImage'dan CircleAvatar
const NetworkImage('https://example.com/avatar.jpg').toCircleAvatar(radius: 30)

// Ink arka plan (Card / InkWell içinde)
const AssetImage('assets/card_bg.png').toInk(
  width: double.infinity,
  height: 200,
  fit: BoxFit.cover,
  child: Text('Üzerine yazı'),
)
```

---

### 3. Layout Extensions

---

#### 3.1 Column Extensions

📄 [`extensions/layout/colum_extensions.dart`](extensions/layout/colum_extensions.dart)

`List<Widget>` üzerinden Column oluşturma.

```dart
[
  Text('Satır 1'),
  Text('Satır 2'),
  Text('Satır 3'),
].column(
  spacing: 8,
  crossAxisAlignment: CrossAxisAlignment.start,
);
```

| Parametre | Varsayılan | Açıklama |
|---|---|---|
| `spacing` | `0` | Widget'lar arası boşluk |
| `mainAxisAlignment` | `start` | Ana eksen hizalama |
| `crossAxisAlignment` | `center` | Çapraz eksen hizalama |
| `mainAxisSize` | `max` | Ana eksen boyutu |

---

#### 3.2 Row Extensions

📄 [`extensions/layout/row_extensions.dart`](extensions/layout/row_extensions.dart)

`List<Widget>` üzerinden Row oluşturma.

```dart
[
  Icon(Icons.star),
  Text('Yıldız'),
].row(spacing: 8);
```

---

#### 3.3 Axis (Column & Row) Alignment

📄 [`extensions/layout/axis_extensions.dart`](extensions/layout/axis_extensions.dart)

Var olan `Column` ve `Row` widget'larının hizalamasını zincirleme (chainable) olarak değiştirme.

##### Column

| Property | Açıklama |
|---|---|
| `.crossStart` | `CrossAxisAlignment.start` |
| `.crossCenter` | `CrossAxisAlignment.center` |
| `.crossEnd` | `CrossAxisAlignment.end` |
| `.crossStretch` | `CrossAxisAlignment.stretch` |
| `.mainStart` | `MainAxisAlignment.start` |
| `.mainCenter` | `MainAxisAlignment.center` |
| `.mainEnd` | `MainAxisAlignment.end` |
| `.mainSpaceBetween` | `MainAxisAlignment.spaceBetween` |
| `.mainSpaceAround` | `MainAxisAlignment.spaceAround` |
| `.mainSpaceEvenly` | `MainAxisAlignment.spaceEvenly` |

##### Row

Aynı property'ler `Row` için de geçerlidir.

```dart
Column(children: [...]).crossStart.mainSpaceBetween;

Row(children: [...]).mainSpaceEvenly.crossCenter;
```

---

### 4. Primitive Extensions

---

#### 4.1 String Extensions

📄 [`extensions/primitive/string_extensions.dart`](extensions/primitive/string_extensions.dart)

##### Format Dönüşümleri

| Metot | Giriş → Çıkış |
|---|---|
| `.toTurkishPhoneFormat()` | `"5551234567"` → `"+90 0555 123 4567"` |
| `.toUsername()` | `"wonzy"` → `"@wonzy"` |
| `.toGmail()` | `"wonzy"` → `"wonzy@gmail.com"` |
| `.capitalize()` | `"merhaba"` → `"Merhaba"` |
| `.toTitleCase()` | `"merhaba dünya"` → `"Merhaba Dünya"` |
| `.toSnakeCase()` | `"Merhaba Dünya"` → `"merhaba_dünya"` |
| `.toKebabCase()` | `"Merhaba Dünya"` → `"merhaba-dünya"` |
| `.toCamelCase()` | `"merhaba dünya"` → `"merhabaDünya"` |

##### Kontrol & Doğrulama

| Property / Metot | Dönüş | Açıklama |
|---|---|---|
| `.isNumeric` | `bool` | Sadece rakam mı |
| `.isAlphabetic` | `bool` | Sadece harf mi |
| `.isAlphanumeric` | `bool` | Harf veya rakam mı |
| `.hasNumber` | `bool` | Rakam içeriyor mu |
| `.hasLetter` | `bool` | Harf içeriyor mu |
| `.containsIgnoreCase('ab')` | `bool` | Büyük/küçük harf duyarsız arama |
| `.toBool` | `bool` | `"true"` → `true` |

##### Metin İşleme

| Property / Metot | Açıklama |
|---|---|
| `.ellipsis(20)` | 20 karakterden sonra `...` ekler |
| `.reversed` | Metni ters çevirir |
| `.stripHtml` | HTML tag'lerini temizler |
| `.trimmed` | Baş/son boşlukları siler |

```dart
final phone = '5551234567'.toTurkishPhoneFormat(); // +90 0555 123 4567
final title = 'flutter projesi'.toTitleCase();     // Flutter Projesi
final safe  = longText.ellipsis(50);               // İlk 50 karakter...
```

---

#### 4.2 Num Extensions

📄 [`extensions/primitive/num_extensions.dart`](extensions/primitive/num_extensions.dart)

| Property | Dönüş Tipi | Açıklama | Örnek |
|---|---|---|---|
| `16.h` | `SizedBox` | Dikey boşluk | `16.h` |
| `16.w` | `SizedBox` | Yatay boşluk | `16.w` |
| `16.height` | `SizedBox` | Dikey boşluk (legacy) | `16.height` |
| `16.width` | `SizedBox` | Yatay boşluk (legacy) | `16.width` |
| `16.all` | `EdgeInsets` | Tüm kenarlar padding | `16.all` |
| `16.horizontal` | `EdgeInsets` | Yatay padding | `16.horizontal` |
| `16.vertical` | `EdgeInsets` | Dikey padding | `16.vertical` |
| `12.radius` | `BorderRadius` | Circular radius | `12.radius` |
| `300.ms` | `Duration` | Milisaniye | `300.ms` |
| `2.seconds` | `Duration` | Saniye | `2.seconds` |

```dart
Column(children: [
  Text('Başlık'),
  12.h,               // SizedBox(height: 12)
  Text('İçerik'),
  24.h,
]);

Container(
  padding: 16.all,    // EdgeInsets.all(16)
  child: child,
);

AnimationController(duration: 300.ms);
```

---

#### 4.3 Text Builder

📄 [`extensions/primitive/text_extensions.dart`](extensions/primitive/text_extensions.dart)

`String` üzerinden zincirleme (chainable) metin oluşturucu. `"text".text` ile başlatılır.

##### Font Weight

| Property | Karşılık |
|---|---|
| `.thin` | `w100` |
| `.extraLight` | `w200` |
| `.light` | `w300` |
| `.regular` | `w400` |
| `.medium` | `w500` |
| `.semiBold` | `w600` |
| `.bold` | `w700` |
| `.extraBold` | `w800` |
| `.black` | `w900` |

##### Font Style & Decoration

| Property | Açıklama |
|---|---|
| `.italic` | Eğik |
| `.normal` | Normal |
| `.underline` | Alt çizgi |
| `.lineThrough` | Üstü çizili |
| `.overline` | Üst çizgi |
| `.noDecoration` | Dekorasyon yok |

##### Text Align & Overflow

| Property | Açıklama |
|---|---|
| `.alignLeft` / `.alignRight` / `.alignCenter` / `.alignJustify` | Hizalama |
| `.ellipsis` / `.fade` / `.clip` / `.visible` | Taşma davranışı |

##### Tema Tabanlı Stiller

| Metot | Material 3 Karşılığı |
|---|---|
| `.displayLarge(context)` | `displayLarge` |
| `.headlineMedium(context)` | `headlineMedium` |
| `.titleLarge(context)` | `titleLarge` |
| `.bodyMedium(context)` | `bodyMedium` |
| `.labelSmall(context)` | `labelSmall` |
| ... | (tüm M3 stilleri) |

##### Parametre Metotları

| Metot | Açıklama |
|---|---|
| `.color(Colors.red)` | Renk |
| `.fontSize(18)` | Boyut |
| `.letterSpacing(1.2)` | Harf aralığı |
| `.wordSpacing(2)` | Kelime aralığı |
| `.height(1.5)` | Satır yüksekliği |
| `.maxLine(2)` | Maksimum satır |
| `.fontFamily('Roboto')` | Font ailesi |
| `.backgroundColor(color)` | Metin arka planı |

```dart
// Zincirleme kullanım
'CampusHub'.text
    .bold
    .headlineMedium(context)
    .color(Colors.blue)
    .alignCenter
    .maxLine(1)
    .ellipsis;

// Basit kullanım
'Açıklama'.text.bodySmall(context).color(Colors.grey);

// Dekorasyon
'Eski fiyat'.text.lineThrough.color(Colors.red);
```

---

### 5. Navigation Extensions

---

#### 5.1 Navigator Extensions

📄 [`extensions/navigation/navigator_extensions.dart`](extensions/navigation/navigator_extensions.dart)

| Metot | Açıklama |
|---|---|
| `context.pushPage(page)` | Sayfaya git |
| `context.pop()` | Geri dön |
| `context.pushReplacementPage(page)` | Sayfayı değiştir |
| `context.pushAndRemoveUntilPage(page)` | Tüm stack'i temizleyip git |
| `context.pushNamed('/route')` | Named route push |
| `context.pushReplacementNamed('/route')` | Named route replace |

Her metot opsiyonel `transitionBuilder` ve `transitionDuration` parametresi alır.

```dart
// Basit navigasyon
context.pushPage(ProfilePage());
context.pop();

// Geçiş animasyonu ile
context.pushPage(
  SettingsPage(),
  transitionBuilder: RouteTransitions.fadeSlide(),
  transitionDuration: Duration(milliseconds: 400),
);

// Stack temizleyerek
context.pushAndRemoveUntilPage(LoginPage());

// Named route
context.pushNamed('/student', arguments: {'id': 123});
```

---

#### 5.2 Route Transitions

📄 [`extensions/navigation/transitions/route_transitions.dart`](extensions/navigation/transitions/route_transitions.dart)

Hazır sayfa geçiş animasyonları. `RouteTransitions.xxx()` şeklinde kullanılır.

##### Temel Geçişler

| Metot | Açıklama |
|---|---|
| `RouteTransitions.fadeIn()` | Yavaşça belirme |
| `RouteTransitions.slide(begin: Offset(1, 0))` | Kayarak gelme |
| `RouteTransitions.slideFromTop()` | Yukarıdan |
| `RouteTransitions.slideFromBottom()` | Aşağıdan |
| `RouteTransitions.slideFromLeft()` | Soldan |
| `RouteTransitions.slideFromRight()` | Sağdan |
| `RouteTransitions.scale()` | Yaklaşma efekti |
| `RouteTransitions.rotation()` | Dönme efekti |
| `RouteTransitions.size()` | Boyut büyüme |

##### Kombinasyon Geçişler

| Metot | Açıklama |
|---|---|
| `RouteTransitions.fadeScale()` | Fade + Scale |
| `RouteTransitions.fadeSlide()` | Fade + Slide |
| `RouteTransitions.scaleRotate()` | Scale + Rotation |
| `RouteTransitions.flipX()` | X ekseninde çevirme |
| `RouteTransitions.flipY()` | Y ekseninde çevirme |

##### Hazır Presetler

| Metot | Açıklama |
|---|---|
| `RouteTransitions.zoomIn()` | Yakınlaşarak girme |
| `RouteTransitions.zoomOut()` | Uzaklaşarak girme |

```dart
context.pushPage(
  DetailPage(),
  transitionBuilder: RouteTransitions.fadeSlide(
    begin: Offset(0, 0.3),
    curve: Curves.easeOutCubic,
  ),
);

context.pushReplacementPage(
  HomePage(),
  transitionBuilder: RouteTransitions.fadeScale(),
);
```

---

### 6. Utility Extensions

---

📄 [`extensions/utility/log_extensions.dart`](extensions/utility/log_extensions.dart)

`String` üzerinden kolayca log yazdırma.

| Metot | Seviye | Açıklama |
|---|---|---|
| `.debugLog()` | Debug | `debugPrint` ile yazdırır |
| `.infoLog()` | Info (800) | Sarı renk |
| `.warningLog()` | Warning (900) | Turuncu renk |
| `.errorLog()` | Error (1000) | Kırmızı renk |

```dart
'Kullanıcı giriş yaptı'.infoLog();
'Bağlantı zaman aşımı'.warningLog();
'Null pointer exception'.errorLog(name: 'AuthBloc');
```

---

## Widgets

---

### 7. CostumButton

📄 [`widgets/buttons/costum_button.dart`](widgets/buttons/costum_button.dart)

Tamamen özelleştirilebilir genel amaçlı buton. **Tüm property'ler opsiyoneldir.**

#### Parametreler

| Kategori | Parametreler |
|---|---|
| **İçerik** | `child`, `text`, `icon`, `iconData`, `iconSize`, `iconColor`, `iconSpacing` |
| **Aksiyon** | `onPressed`, `onLongPress` |
| **Boyut** | `width`, `height`, `minWidth`, `maxWidth`, `minHeight`, `maxHeight`, `padding`, `margin` |
| **Renk** | `backgroundColor`, `foregroundColor`, `disabledBackgroundColor`, `disabledForegroundColor`, `overlayColor`, `shadowColor` |
| **Kenarlık** | `borderColor`, `borderWidth`, `borderRadius`, `borderSide`, `shape` |
| **Tipografi** | `textStyle`, `fontSize`, `fontWeight`, `letterSpacing`, `textAlign` |
| **Yükseklik** | `elevation`, `pressedElevation`, `disabledElevation` |
| **Durum** | `isExpanded`, `isLoading`, `isDisabled`, `loadingWidget`, `loadingSize`, `loadingColor`, `loadingStrokeWidth` |
| **Ekstra** | `gradient`, `tooltip`, `focusNode`, `autofocus`, `animationDuration`, `splashFactory`, `iconAlignment` |

#### Örnekler

```dart
// Basit buton
CostumButton(
  text: 'Giriş Yap',
  onPressed: () {},
)

// İkonlu + gradient
CostumButton(
  text: 'Devam Et',
  iconData: Icons.arrow_forward,
  iconAlignment: IconAlignment.end,
  gradient: LinearGradient(colors: [AppColors.primary, AppColors.primaryLight]),
  foregroundColor: Colors.white,
  borderRadius: 12,
  isExpanded: true,
  onPressed: () {},
)

// Outline tarzı
CostumButton(
  text: 'İptal',
  borderColor: AppColors.error,
  foregroundColor: AppColors.error,
  elevation: 0,
  onPressed: () {},
)

// Loading durumu
CostumButton(
  text: 'Kaydet',
  backgroundColor: AppColors.primary,
  foregroundColor: Colors.white,
  isLoading: true,
)
```

---

### 8. CostumIconButton

📄 [`widgets/buttons/costum_icon_button.dart`](widgets/buttons/costum_icon_button.dart)

Dairesel (circle) ikon buton. **Tüm property'ler opsiyoneldir.**

#### Parametreler

| Kategori | Parametreler |
|---|---|
| **İçerik** | `icon` (widget), `iconData`, `iconSize`, `iconColor` |
| **Aksiyon** | `onPressed`, `onLongPress` |
| **Boyut** | `size` (çap), `minSize`, `maxSize`, `padding`, `margin` |
| **Renk** | `backgroundColor`, `foregroundColor`, `disabledBackgroundColor`, `disabledForegroundColor`, `overlayColor`, `shadowColor` |
| **Kenarlık** | `borderColor`, `borderWidth`, `borderSide` |
| **Yükseklik** | `elevation`, `pressedElevation`, `disabledElevation` |
| **Durum** | `isLoading`, `isDisabled`, `loadingWidget`, `loadingSize`, `loadingColor`, `loadingStrokeWidth` |
| **Badge** | `badgeCount`, `badgeColor`, `badgeTextColor`, `showBadge` |
| **Ekstra** | `gradient`, `tooltip`, `focusNode`, `autofocus`, `splashFactory`, `splashRadius` |

#### Örnekler

```dart
// Basit
CostumIconButton(
  iconData: Icons.add,
  onPressed: () {},
)

// Bildirim ikonu + badge
CostumIconButton(
  iconData: Icons.notifications,
  size: 56,
  backgroundColor: AppColors.primary,
  iconColor: Colors.white,
  elevation: 4,
  badgeCount: 3,
  tooltip: 'Bildirimler',
  onPressed: () {},
)

// Outline + gradient
CostumIconButton(
  iconData: Icons.share,
  gradient: LinearGradient(colors: [AppColors.primary, AppColors.secondary]),
  foregroundColor: Colors.white,
  borderColor: AppColors.primaryLight,
  onPressed: () {},
)

// Loading durumu
CostumIconButton(
  iconData: Icons.sync,
  isLoading: true,
  backgroundColor: Colors.grey.shade200,
)
```

---

### 9. CostumAppBar

📄 [`widgets/app_bar/costum_app_bar.dart`](widgets/app_bar/costum_app_bar.dart)

`PreferredSizeWidget` implement eden, doğrudan `Scaffold.appBar`'a verilebilen özelleştirilebilir AppBar. **Tüm property'ler opsiyoneldir.**

#### Parametreler

| Kategori | Parametreler |
|---|---|
| **Başlık** | `title`, `titleWidget`, `titleStyle`, `titleColor`, `titleFontSize`, `titleFontWeight`, `titleSpacing`, `centerTitle` |
| **Leading** | `leading`, `leadingIcon`, `leadingIconColor`, `leadingIconSize`, `onLeadingPressed`, `automaticallyImplyLeading`, `leadingWidth` |
| **Actions** | `actions`, `actionsIconTheme`, `actionsPadding` |
| **Renk** | `backgroundColor`, `foregroundColor`, `surfaceTintColor`, `gradient`, `shadowColor` |
| **Yükseklik** | `elevation`, `scrolledUnderElevation` |
| **Boyut** | `toolbarHeight`, `toolbarOpacity` |
| **Şekil** | `shape`, `borderRadius` (alt köşe), `border` |
| **Bottom** | `bottom` (TabBar vb.), `bottomSeparator`, `bottomSeparatorColor`, `bottomSeparatorHeight` |
| **Status Bar** | `systemOverlayStyle`, `brightness` |
| **Ekstra** | `flexibleSpace`, `primary`, `excludeHeaderSemantics`, `forceMaterialTransparency`, `clipBehavior` |

#### Örnekler

```dart
// Basit
Scaffold(
  appBar: CostumAppBar(title: 'Ana Sayfa'),
)

// Gradient + yuvarlak alt köşe
CostumAppBar(
  title: 'Profil',
  centerTitle: true,
  gradient: LinearGradient(colors: [AppColors.primary, AppColors.primaryLight]),
  foregroundColor: Colors.white,
  borderRadius: 20,
  elevation: 0,
  brightness: Brightness.dark,
)

// TabBar ile
CostumAppBar(
  title: 'Dersler',
  bottom: TabBar(tabs: [Tab(text: 'Aktif'), Tab(text: 'Geçmiş')]),
  bottomSeparator: true,
  actions: [
    CostumIconButton(iconData: Icons.search, onPressed: () {}),
  ],
)

// Özel leading
CostumAppBar(
  title: 'Ayarlar',
  leadingIcon: Icons.menu,
  onLeadingPressed: () => scaffoldKey.currentState?.openDrawer(),
)
```

---

### 10. CostumBottomSheet

📄 [`widgets/bottom_sheet/costum_bottom_sheet.dart`](widgets/bottom_sheet/costum_bottom_sheet.dart)

Tamamen özelleştirilebilir BottomSheet. İki kullanım biçimi: **Widget** veya **static `show` metodu**. **Tüm property'ler opsiyoneldir.**

#### Parametreler

| Kategori | Parametreler |
|---|---|
| **İçerik** | `child`, `children`, `title`, `titleWidget`, `titleStyle`, `titleColor`, `titleFontSize`, `titleFontWeight`, `titleAlignment`, `subtitle`, `subtitleWidget`, `message`, `messageWidget`, `icon`, `iconData`, `iconSize`, `iconColor`, `image` |
| **Handle** | `showHandle`, `handleColor`, `handleWidth`, `handleHeight`, `handleMargin`, `handleDecoration` |
| **Kapatma** | `showCloseButton`, `closeIcon`, `closeIconColor`, `closeIconSize`, `onClose`, `closeButtonAlignment` |
| **Header** | `header`, `headerPadding`, `headerDecoration`, `headerSeparator`, `headerSeparatorColor`, `headerSeparatorHeight` |
| **Footer** | `footer`, `footerPadding`, `footerDecoration`, `footerSeparator`, `footerSeparatorColor`, `footerSeparatorHeight` |
| **Aksiyonlar** | `primaryAction`, `primaryActionText`, `onPrimaryAction`, `secondaryAction`, `secondaryActionText`, `onSecondaryAction`, `actionsAxis`, `actionsSpacing`, `actionsPadding` |
| **Renk** | `backgroundColor`, `barrierColor`, `surfaceTintColor`, `gradient`, `shadowColor` |
| **Boyut** | `height`, `minHeight`, `maxHeight`, `width`, `padding`, `contentPadding`, `margin` |
| **Şekil** | `borderRadius`, `topLeftRadius`, `topRightRadius`, `bottomLeftRadius`, `bottomRightRadius`, `border`, `borderColor`, `borderWidth`, `shape` |
| **Scroll** | `isScrollable`, `scrollController`, `scrollPhysics`, `scrollPadding`, `shrinkWrap` |
| **Draggable** | `isDraggable`, `initialChildSize`, `minChildSize`, `maxChildSize`, `snap`, `snapSizes`, `shouldCloseOnMinExtent` |
| **Davranış** | `isDismissible`, `enableDrag`, `isModal`, `useRootNavigator`, `useSafeArea` |
| **Animasyon** | `animationDuration`, `animationCurve`, `transitionAnimationController` |
| **Callback** | `onDismissed` |

#### Örnekler

```dart
// Basit açma
CostumBottomSheet.show(
  context,
  title: 'Filtre',
  child: FilterWidget(),
);

// Onay diyaloğu
final result = await CostumBottomSheet.show<bool>(
  context,
  iconData: Icons.warning_amber,
  iconColor: AppColors.warning,
  title: 'Emin misiniz?',
  message: 'Bu işlem geri alınamaz.',
  primaryActionText: 'Evet',
  secondaryActionText: 'Hayır',
  onPrimaryAction: () => Navigator.pop(context, true),
  onSecondaryAction: () => Navigator.pop(context, false),
);

// Draggable scroll edilebilir
CostumBottomSheet.show(
  context,
  isDraggable: true,
  initialChildSize: 0.4,
  maxChildSize: 0.9,
  snap: true,
  title: 'Yorumlar',
  isScrollable: true,
  showCloseButton: true,
  headerSeparator: true,
  children: commentWidgets,
);

// Gradient + tam özelleştirme
CostumBottomSheet.show(
  context,
  gradient: LinearGradient(
    colors: [AppColors.primary, AppColors.primaryDark],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  ),
  borderRadius: 24,
  showCloseButton: true,
  closeIconColor: Colors.white,
  title: 'Premium Özellikler',
  titleColor: Colors.white,
  subtitle: 'Tüm özelliklerin kilidini açın',
  subtitleStyle: TextStyle(color: Colors.white70),
  footerSeparator: true,
  primaryActionText: 'Satın Al',
  secondaryActionText: 'Daha Sonra',
);
```

---

## 📂 Dosya Yapısı

```
lib/core/utils/
├── index.dart                          # Barrel export
├── README.md                           # Bu dosya
├── extensions/
│   ├── context/
│   │   ├── context_extensions.dart     # BuildContext kısayolları
│   │   └── index.dart
│   ├── layout/
│   │   ├── axis_extensions.dart        # Column/Row hizalama
│   │   ├── colum_extensions.dart       # List → Column
│   │   ├── row_extensions.dart         # List → Row
│   │   └── index.dart
│   ├── navigation/
│   │   ├── navigator_extensions.dart   # Navigasyon kısayolları
│   │   └── transitions/
│   │       └── route_transitions.dart  # Sayfa geçiş animasyonları
│   ├── primitive/
│   │   ├── string_extensions.dart      # String işlemleri
│   │   ├── num_extensions.dart         # Sayısal kısayollar
│   │   ├── text_extensions.dart        # TextBuilder (chainable)
│   │   └── index.dart
│   ├── utility/
│   │   ├── log_extensions.dart         # Log kısayolları
│   │   └── index.dart
│   └── widget/
│       ├── center_extensions.dart      # Hizalama
│       ├── container_extensions.dart   # Container sarmalama
│       ├── expanded_extensions.dart    # Expanded/Flexible
│       ├── paddings_extensions.dart    # Padding/Margin
│       ├── sizebox_extensions.dart     # Boyut kısıtlama
│       ├── images_extensions.dart      # Image şekil/filtre/overlay
│       ├── widget_extensions.dart      # Dekorasyon/Etkileşim
│       └── index.dart
└── widgets/
    ├── app_bar/
    │   └── costum_app_bar.dart         # Özel AppBar
    ├── bottom_sheet/
    │   └── costum_bottom_sheet.dart    # Özel BottomSheet
    └── buttons/
        ├── costum_button.dart          # Genel buton
        └── costum_icon_button.dart     # Dairesel ikon buton
```

---

> **İpucu:** Tüm extension ve widget'lar `import 'package:campus_hub/core/utils/index.dart';` ile tek satırda import edilebilir.
