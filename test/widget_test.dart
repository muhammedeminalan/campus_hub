import 'package:campus_hub/config/theme/app_theme.dart';
import 'package:campus_hub/features/bottom_navigation/cubit/navigation_cubit.dart';
import 'package:campus_hub/features/bottom_navigation/enum/page_type.dart';
import 'package:campus_hub/features/bottom_navigation/widgets/custom_bottom_nav.dart';
import 'package:campus_hub/features/quick_menu/presentation/view/quick_menu_view.dart';
import 'package:campus_hub/shared/models/menu_item_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

// ─────────────────────────────────────────────────────────────────────────────
// Test yardımcıları
// ─────────────────────────────────────────────────────────────────────────────

/// Tema + NavigationCubit ile widget'ı saran minimal helper.
Widget _wrap(Widget child, {NavigationCubit? cubit}) {
  return MaterialApp(
    theme: AppTheme.light,
    home: BlocProvider(create: (_) => cubit ?? NavigationCubit(), child: child),
  );
}

// ─────────────────────────────────────────────────────────────────────────────
// NavigationCubit — birim testleri
// ─────────────────────────────────────────────────────────────────────────────

void main() {
  group('NavigationCubit', () {
    late NavigationCubit cubit;

    setUp(() => cubit = NavigationCubit());
    tearDown(() => cubit.close());

    // Başlangıçta home tab aktif olmalı
    test('başlangıç state NavigationTab.home', () {
      expect(cubit.state, NavigationTab.home);
    });

    // updateTab çağrıldığında state değişmeli
    test('updateTab → verilen tab state olur', () {
      cubit.updateTab(NavigationTab.quickMenu);
      expect(cubit.state, NavigationTab.quickMenu);
    });

    // Ardışık geçişler doğru sırayla çalışmalı
    test('updateTab → arka arkaya geçişler tutarlı', () {
      cubit.updateTab(NavigationTab.courses);
      expect(cubit.state, NavigationTab.courses);

      cubit.updateTab(NavigationTab.examResults);
      expect(cubit.state, NavigationTab.examResults);

      cubit.updateTab(NavigationTab.home);
      expect(cubit.state, NavigationTab.home);
    });

    // Her tab değeri farklı olmalı (enum bütünlüğü)
    test('NavigationTab değerleri birbirinden farklı', () {
      final values = NavigationTab.values;
      expect(values.toSet().length, values.length);
    });
  });

  // ─────────────────────────────────────────────────────────────────────────
  // QuickMenuView — widget testleri
  // ─────────────────────────────────────────────────────────────────────────

  group('QuickMenuView', () {
    // AppBar başlığı doğru olmalı
    testWidgets('AppBar başlığı "Hızlı Menü" gösterir', (tester) async {
      await tester.pumpWidget(_wrap(const QuickMenuView()));
      await tester.pumpAndSettle();

      expect(find.text('Hızlı Menü'), findsOneWidget);
    });

    // Arama çubuğu ("Menüde ara…") her zaman görünür olmalı
    testWidgets('arama çubuğu görünür', (tester) async {
      await tester.pumpWidget(_wrap(const QuickMenuView()));
      await tester.pumpAndSettle();

      expect(find.widgetWithText(TextField, 'Menüde ara…'), findsOneWidget);
    });

    // Görünür alandaki ilk kategori başlığı kontrol ediliyor
    testWidgets('ilk kategori başlığı render edilir', (tester) async {
      await tester.pumpWidget(_wrap(const QuickMenuView()));
      await tester.pumpAndSettle();

      expect(find.text('Yoklama & Takvimler'), findsOneWidget);
    });

    // İlk gruptaki öğeler scroll olmadan görünmeli
    testWidgets('ilk gruptaki öğe etiketleri render edilir', (tester) async {
      await tester.pumpWidget(_wrap(const QuickMenuView()));
      await tester.pumpAndSettle();

      // İlk 3 öğe (indices 0-2) ekranda olmalı
      for (final item in MenuItemModel.quickMenuItems.take(3)) {
        expect(find.text(item.label), findsAtLeastNWidgets(1));
      }
    });

    // Scroll edince aşağıdaki kategoriler de görünmeli
    testWidgets('scroll ile tüm kategorilere ulaşılabilir', (tester) async {
      await tester.pumpWidget(_wrap(const QuickMenuView()));
      await tester.pumpAndSettle();

      // "Diğer" kategorisi en altta, scroll ederek bul
      await tester.scrollUntilVisible(
        find.text('Diğer'),
        300,
        scrollable: find.byType(Scrollable).first,
      );
      await tester.pumpAndSettle();

      expect(find.text('Diğer'), findsOneWidget);
    });

    // Scroll ile "Transkript" öğesine ulaşılabilmeli
    testWidgets('scroll ile orta grup öğelerine ulaşılabilir', (tester) async {
      await tester.pumpWidget(_wrap(const QuickMenuView()));
      await tester.pumpAndSettle();

      await tester.scrollUntilVisible(
        find.text('Transkript'),
        300,
        scrollable: find.byType(Scrollable).first,
      );
      await tester.pumpAndSettle();

      expect(find.text('Transkript'), findsOneWidget);
    });

    // Var olmayan sorgu → "Sonuç bulunamadı" mesajı gösterilmeli
    testWidgets('boş arama sonucu mesajı gösterilir', (tester) async {
      await tester.pumpWidget(_wrap(const QuickMenuView()));
      await tester.pumpAndSettle();

      await tester.enterText(
        find.widgetWithText(TextField, 'Menüde ara…'),
        'xyzxyzxyz',
      );
      await tester.pumpAndSettle();

      expect(find.text('Sonuç bulunamadı'), findsOneWidget);
    });

    // Gerçek keyword → ilgili öğe görünür, ilgisiz öğe görünmez
    testWidgets('arama — eşleşen öğe filtrelenir', (tester) async {
      await tester.pumpWidget(_wrap(const QuickMenuView()));
      await tester.pumpAndSettle();

      await tester.enterText(
        find.widgetWithText(TextField, 'Menüde ara…'),
        'Yoklama',
      );
      await tester.pumpAndSettle();

      // Eşleşen öğe görünmeli
      expect(find.text('Yoklama'), findsAtLeastNWidgets(1));

      // Eşleşmeyen öğe görünmemeli
      expect(find.text('Transkript'), findsNothing);

      // Boş durum mesajı görünmemeli
      expect(find.text('Sonuç bulunamadı'), findsNothing);
    });

    // X butonuna basınca arama sıfırlanmalı, kategoriler geri gelmeli
    testWidgets('X butonu aramayı temizler', (tester) async {
      await tester.pumpWidget(_wrap(const QuickMenuView()));
      await tester.pumpAndSettle();

      await tester.enterText(
        find.widgetWithText(TextField, 'Menüde ara…'),
        'Yoklama',
      );
      await tester.pumpAndSettle();

      // X butonu görünmeli
      expect(find.byIcon(Icons.close_rounded), findsOneWidget);

      // X'e bas
      await tester.tap(find.byIcon(Icons.close_rounded));
      await tester.pumpAndSettle();

      // Boş durum mesajı kaybolmalı, ilk kategori geri gelmeli
      expect(find.text('Sonuç bulunamadı'), findsNothing);
      expect(find.text('Yoklama & Takvimler'), findsOneWidget);
    });
  });

  // ─────────────────────────────────────────────────────────────────────────
  // CustomBottomNav — widget testleri
  // ─────────────────────────────────────────────────────────────────────────

  group('CustomBottomNav', () {
    // Tüm tab etiketleri render edilmeli
    testWidgets('tab etiketleri görünür', (tester) async {
      await tester.pumpWidget(
        _wrap(const Scaffold(bottomNavigationBar: CustomBottomNav())),
      );
      await tester.pumpAndSettle();

      for (final tab in NavigationTab.values) {
        expect(find.text(tab.label), findsOneWidget);
      }
    });

    // Tab'a tap edilince cubit state güncellenmeli
    testWidgets('tab tıklanınca NavigationCubit güncellenir', (tester) async {
      final cubit = NavigationCubit();

      await tester.pumpWidget(
        _wrap(
          const Scaffold(bottomNavigationBar: CustomBottomNav()),
          cubit: cubit,
        ),
      );
      await tester.pumpAndSettle();

      // "Alınan Dersler" tab'ına bas
      await tester.tap(find.text(NavigationTab.courses.label));
      await tester.pump();

      expect(cubit.state, NavigationTab.courses);
    });

    // Aktif tab seçildiğinde state değişmemeli (aynı tab tekrar tıklanınca)
    testWidgets('aynı tab tekrar tıklanınca state aynı kalır', (tester) async {
      final cubit = NavigationCubit(); // başlangıç: home

      await tester.pumpWidget(
        _wrap(
          const Scaffold(bottomNavigationBar: CustomBottomNav()),
          cubit: cubit,
        ),
      );
      await tester.pumpAndSettle();

      // Home tab zaten aktif, tekrar bas
      await tester.tap(find.text(NavigationTab.home.label));
      await tester.pump();

      // Home state'de kalmalı
      expect(cubit.state, NavigationTab.home);
    });
  });

  // ─────────────────────────────────────────────────────────────────────────
  // MenuItemModel — birim testleri
  // ─────────────────────────────────────────────────────────────────────────

  group('MenuItemModel', () {
    // Toplam 15 öğe olmalı
    test('quickMenuItems 15 öğe içerir', () {
      expect(MenuItemModel.quickMenuItems.length, 15);
    });

    // Hiçbir label boş olmamalı
    test('tüm label\'lar dolu', () {
      for (final item in MenuItemModel.quickMenuItems) {
        expect(item.label.isNotEmpty, isTrue, reason: '${item.label} boş');
      }
    });

    // Her öğenin benzersiz bir route'u olmalı
    test('route değerleri tekrar etmez', () {
      final routes = MenuItemModel.quickMenuItems.map((e) => e.route).toList();
      expect(routes.toSet().length, routes.length);
    });
  });
}
