import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

// ═══════════════════════════════════════════════════════════
// 📄 custom_text_field.dart
// ───────────────────────────────────────────────────────────
// Production seviyesinde, tip tabanlı akıllı metin alanı.
//
// FormBuilderTextField üzerine inşa edilmiştir.
// Tüm parametreler opsiyoneldir; yalnızca [name] zorunludur.
//
// Özellikler:
//   • CustomFieldType enum'u ile alan tipine göre otomatik
//     klavye, autofill, obscure ve validasyon davranışları.
//   • Şifre göster/gizle toggle ikonu.
//   • Temizle (clear) butonu (controller gerektirir).
//   • Kullanıcı suffixIcon'u ile toggle/clear birlikte çalışır.
//   • nextFocusNode ile submit'te otomatik focus geçişi.
//   • valueTransformer ile kayıt öncesi değer dönüştürme.
//   • Tüm hata mesajları Türkçe; override edilebilir.
//
// Kullanım:
//   ```dart
//   CustomTextField(
//     name: 'email',
//     type: CustomFieldType.email,
//     label: 'E-posta',
//     required: true,
//   )
//   ```
// ═══════════════════════════════════════════════════════════

// ─────────────────────────────────────────────────────────
// Varsayılan Türkçe hata mesajları
// ─────────────────────────────────────────────────────────

/// Merkezî Türkçe hata metinleri.
/// Her biri [CustomTextField] parametreleriyle override edilebilir.
abstract final class _ErrorMessages {
  static const required = 'Bu alan zorunludur';
  static const email = 'Geçerli bir e-posta adresi girin';
  static const phone = 'Geçerli bir telefon numarası girin';
  static const numeric = 'Sadece rakam girin';

  static String minLength(int len) => 'En az $len karakter olmalıdır';
  static String maxLength(int len) => 'En fazla $len karakter olmalıdır';
}

// ─────────────────────────────────────────────────────────
// CustomFieldType
// ─────────────────────────────────────────────────────────

/// Alan tipine göre varsayılan davranışları belirleyen enum.
///
/// | Tip             | Klavye          | Autofill          | Obscure | Min Uz. |
/// |-----------------|-----------------|-------------------|---------|---------|
/// | text            | text            | —                 | false   | —       |
/// | email           | emailAddress    | email             | false   | —       |
/// | phone           | phone           | telephoneNumber   | false   | —       |
/// | password        | visiblePassword | password          | true    | 6       |
/// | number          | number          | —                 | false   | —       |
/// | studentNumber   | number          | —                 | false   | 6       |
enum CustomFieldType {
  text,
  email,
  phone,
  password,
  number,
  studentNumber;

  /// Tip için varsayılan klavye tipi.
  TextInputType get defaultKeyboardType => switch (this) {
    text => TextInputType.text,
    email => TextInputType.emailAddress,
    phone => TextInputType.phone,
    password => TextInputType.visiblePassword,
    number => TextInputType.number,
    studentNumber => TextInputType.number,
  };

  /// Tip için varsayılan autofill ipuçları.
  Iterable<String> get defaultAutofillHints => switch (this) {
    email => const [AutofillHints.email],
    phone => const [AutofillHints.telephoneNumber],
    password => const [AutofillHints.password],
    _ => const [],
  };

  /// Password tipinde varsayılan olarak gizli yazılır.
  bool get defaultObscure => this == password;

  /// Tip için varsayılan minimum karakter uzunluğu.
  int? get defaultMinLength => switch (this) {
    password => 6,
    studentNumber => 6,
    _ => null,
  };
}

// ─────────────────────────────────────────────────────────
// CustomTextField Widget
// ─────────────────────────────────────────────────────────

/// Production seviyesinde, tip tabanlı akıllı metin alanı.
///
/// [FormBuilderTextField] üzerine inşa edilmiştir.
/// [CustomFieldType] seçimine göre otomatik klavye, autofill,
/// obscure ve validasyon kuralları uygulanır.
///
/// ## Parametreler
///
/// ### Zorunlu
/// - [name]: FormBuilder alan adı.
///
/// ### Tip & Görünüm
/// - [type]: Alan tipi (varsayılan: [CustomFieldType.text]).
/// - [label], [hint], [helperText]: Etiket, ipucu ve yardım metni.
/// - [initialValue]: Başlangıç değeri.
/// - [prefixIcon], [suffixIcon]: Ön/son ikon.
///
/// ### Kontrol
/// - [controller]: Dışarıdan verilen TextEditingController.
/// - [focusNode]: Dışarıdan verilen FocusNode.
/// - [nextFocusNode]: Submit'te otomatik focus geçişi yapılacak node.
///
/// ### Bayraklar
/// - [enabled], [readOnly], [autofocus]: Alan durumu bayrakları.
/// - [obscureText]: Gizli yazı (null ise tip varsayılanı kullanılır).
/// - [showCounter]: Karakter sayacı (false ise gizli).
/// - [showClearButton]: Temizle butonu (controller gerektirir).
/// - [showPasswordToggle]: Şifre göster/gizle ikonu (sadece password).
///
/// ### Validasyon
/// - [required]: Zorunlu alan kuralı.
/// - [minLength], [maxLengthValidator]: Uzunluk kuralları.
/// - [customValidator]: Ek özel doğrulama fonksiyonu.
/// - Tüm hata mesajları Türkçe; parametrelerle override edilebilir.
///
/// ### Dekorasyon Override
/// - [decoration]: Verilirse tüm diğer dekorasyon parametreleri yok sayılır.
/// - [contentPadding], [border], [enabledBorder], [focusedBorder], [errorBorder].
/// - [style], [labelStyle], [hintStyle].
class CustomTextField extends StatefulWidget {
  const CustomTextField({
    super.key,
    required this.name,
    this.type = CustomFieldType.text,
    // Etiket / ipucu / yardım
    this.label,
    this.hint,
    this.helperText,
    this.initialValue,
    // Kontrolcüler & odak
    this.controller,
    this.focusNode,
    this.nextFocusNode,
    // Bayraklar
    this.enabled = true,
    this.readOnly = false,
    this.autofocus = false,
    this.obscureText,
    this.enableSuggestions = true,
    this.autocorrect = true,
    // Uzunluk & satır
    this.maxLength,
    this.maxLines = 1,
    this.minLines,
    // Giriş
    this.keyboardType,
    this.textInputAction,
    this.inputFormatters,
    this.autofillHints,
    // Arayüz eklentileri
    this.showCounter = false,
    this.showClearButton = false,
    this.showPasswordToggle = true,
    this.prefixIcon,
    this.suffixIcon,
    // Geri çağırmalar
    this.onTap,
    this.onChanged,
    this.onSubmitted,
    this.transform,
    // Doğrulama modu
    this.autovalidateMode = AutovalidateMode.onUserInteraction,
    // Doğrulama yapılandırması
    this.required = false,
    this.requiredMessage,
    this.minLength,
    this.maxLengthValidator,
    this.invalidEmailMessage,
    this.invalidPhoneMessage,
    this.minLengthMessage,
    this.maxLengthMessage,
    this.numericMessage,
    this.customValidator,
    // Dekorasyon override
    this.decoration,
    this.contentPadding,
    this.border,
    this.enabledBorder,
    this.focusedBorder,
    this.errorBorder,
    // Metin stilleri
    this.style,
    this.labelStyle,
    this.hintStyle,
  });

  // ── Zorunlu ──

  /// FormBuilder alan adı.
  final String name;

  // ── Tip ──

  /// Alan tipi — varsayılan davranışlar buradan türer.
  final CustomFieldType type;

  // ── Etiket / ipucu / yardım ──

  /// Alanın etiketi (label).
  final String? label;

  /// Boşken görünen ipucu metni (hint).
  final String? hint;

  /// Alanın altında görünen yardım metni.
  final String? helperText;

  /// Başlangıç değeri.
  final String? initialValue;

  // ── Kontrolcüler & odak ──

  /// Dışarıdan verilen metin kontrolcüsü.
  final TextEditingController? controller;

  /// Dışarıdan verilen odak düğümü.
  final FocusNode? focusNode;

  /// Verilirse onSubmitted'da bu düğüme odak geçer.
  final FocusNode? nextFocusNode;

  // ── Bayraklar ──

  /// Alanın aktif olup olmadığı.
  final bool enabled;

  /// Salt okunur mod.
  final bool readOnly;

  /// Otomatik odaklanma.
  final bool autofocus;

  /// Gizli yazı modu. null ise tip varsayılanı kullanılır.
  final bool? obscureText;

  /// Öneri desteği.
  final bool enableSuggestions;

  /// Otomatik düzeltme.
  final bool autocorrect;

  // ── Uzunluk & satır ──

  /// Maksimum karakter sayısı (counter ile).
  final int? maxLength;

  /// Maksimum satır sayısı.
  final int maxLines;

  /// Minimum satır sayısı.
  final int? minLines;

  // ── Giriş ──

  /// Klavye tipi. null ise tip varsayılanı kullanılır.
  final TextInputType? keyboardType;

  /// Klavye aksiyon butonu.
  final TextInputAction? textInputAction;

  /// Giriş biçimlendiricileri.
  final List<TextInputFormatter>? inputFormatters;

  /// Otomatik doldurma ipuçları. null ise tip varsayılanı kullanılır.
  final Iterable<String>? autofillHints;

  // ── Arayüz eklentileri ──

  /// false ise maxLength sayacı gizlenir.
  final bool showCounter;

  /// true ise metin doluyken temizle (×) ikonu gösterir.
  /// Çalışması için [controller] verilmelidir.
  final bool showClearButton;

  /// Sadece password tipinde geçerli — göz ikonu toggle.
  final bool showPasswordToggle;

  /// Sol taraftaki ikon.
  final Widget? prefixIcon;

  /// Sağ taraftaki ikon. Toggle/clear ile birlikte görüntülenir.
  final Widget? suffixIcon;

  // ── Geri çağırmalar ──

  /// Alana dokunulduğunda.
  final VoidCallback? onTap;

  /// Değer değiştiğinde.
  final ValueChanged<String?>? onChanged;

  /// Submit edildiğinde.
  final ValueChanged<String?>? onSubmitted;

  /// Kaydetmeden önce değer dönüştürme (trim, lowercase vb.).
  final String? Function(String?)? transform;

  // ── Doğrulama ──

  /// Otomatik doğrulama modu.
  final AutovalidateMode autovalidateMode;

  /// Zorunlu alan kuralı.
  final bool required;

  /// Zorunlu alan hata mesajı override.
  final String? requiredMessage;

  /// Minimum uzunluk. null ise tip varsayılanı kullanılır.
  final int? minLength;

  /// Maksimum uzunluk doğrulama.
  final int? maxLengthValidator;

  /// Geçersiz e-posta hata mesajı override.
  final String? invalidEmailMessage;

  /// Geçersiz telefon hata mesajı override.
  final String? invalidPhoneMessage;

  /// Minimum uzunluk hata mesajı override.
  final String? minLengthMessage;

  /// Maksimum uzunluk hata mesajı override.
  final String? maxLengthMessage;

  /// Sayısal doğrulama hata mesajı override.
  final String? numericMessage;

  /// Ek özel doğrulama fonksiyonu. compose listesine en sona eklenir.
  final FormFieldValidator<String>? customValidator;

  // ── Dekorasyon override ──

  /// Verilirse tüm diğer dekorasyon parametreleri yok sayılır.
  final InputDecoration? decoration;

  /// İçerik dolgusu.
  final EdgeInsetsGeometry? contentPadding;

  /// Varsayılan kenarlık.
  final InputBorder? border;

  /// Aktif olmayan kenarlık.
  final InputBorder? enabledBorder;

  /// Odaklanmış kenarlık.
  final InputBorder? focusedBorder;

  /// Hata kenarlığı.
  final InputBorder? errorBorder;

  // ── Metin stilleri ──

  /// Alan metin stili.
  final TextStyle? style;

  /// Etiket stili.
  final TextStyle? labelStyle;

  /// İpucu stili.
  final TextStyle? hintStyle;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

// ─────────────────────────────────────────────────────────
// _CustomTextFieldState
// ─────────────────────────────────────────────────────────

class _CustomTextFieldState extends State<CustomTextField> {
  late bool _obscure;
  bool _hasText = false;

  // ── Yaşam döngüsü ──

  @override
  void initState() {
    super.initState();
    _obscure = widget.obscureText ?? widget.type.defaultObscure;

    // Temizle butonu: controller değişimini dinle
    if (widget.showClearButton && widget.controller != null) {
      _hasText = widget.controller!.text.isNotEmpty;
      widget.controller!.addListener(_onControllerChanged);
    }
  }

  @override
  void dispose() {
    if (widget.showClearButton && widget.controller != null) {
      widget.controller!.removeListener(_onControllerChanged);
    }
    super.dispose();
  }

  void _onControllerChanged() {
    final notEmpty = widget.controller!.text.isNotEmpty;
    if (notEmpty != _hasText) setState(() => _hasText = notEmpty);
  }

  // ── Doğrulama Oluşturucu ──

  /// Tip ve parametrelere göre doğrulama kurallarını oluşturur.
  ///
  /// Sıralama:
  /// 1. required (zorunlu)
  /// 2. Tipe özgü kurallar (email, phone, numeric, minLength)
  /// 3. maxLength
  /// 4. customValidator
  FormFieldValidator<String>? _buildValidator() {
    final validators = <FormFieldValidator<String>>[];

    // Zorunlu alan
    if (widget.required) {
      validators.add(
        FormBuilderValidators.required(
          errorText: widget.requiredMessage ?? _ErrorMessages.required,
        ),
      );
    }

    final effectiveMinLen = widget.minLength ?? widget.type.defaultMinLength;

    // Tipe özgü kurallar
    switch (widget.type) {
      case CustomFieldType.email:
        validators.add(
          FormBuilderValidators.email(
            errorText: widget.invalidEmailMessage ?? _ErrorMessages.email,
          ),
        );

      case CustomFieldType.phone:
        validators.add(
          FormBuilderValidators.numeric(
            errorText: widget.invalidPhoneMessage ?? _ErrorMessages.phone,
          ),
        );
        if (effectiveMinLen != null) {
          validators.add(
            FormBuilderValidators.minLength(
              effectiveMinLen,
              errorText:
                  widget.minLengthMessage ??
                  _ErrorMessages.minLength(effectiveMinLen),
            ),
          );
        }

      case CustomFieldType.password:
        if (effectiveMinLen != null) {
          validators.add(
            FormBuilderValidators.minLength(
              effectiveMinLen,
              errorText:
                  widget.minLengthMessage ??
                  _ErrorMessages.minLength(effectiveMinLen),
            ),
          );
        }

      case CustomFieldType.number:
        validators.add(
          FormBuilderValidators.numeric(
            errorText: widget.numericMessage ?? _ErrorMessages.numeric,
          ),
        );

      case CustomFieldType.studentNumber:
        validators.add(
          FormBuilderValidators.numeric(
            errorText: widget.numericMessage ?? _ErrorMessages.numeric,
          ),
        );
        if (effectiveMinLen != null) {
          validators.add(
            FormBuilderValidators.minLength(
              effectiveMinLen,
              errorText:
                  widget.minLengthMessage ??
                  _ErrorMessages.minLength(effectiveMinLen),
            ),
          );
        }

      case CustomFieldType.text:
        break;
    }

    // Maksimum uzunluk doğrulama
    if (widget.maxLengthValidator != null) {
      validators.add(
        FormBuilderValidators.maxLength(
          widget.maxLengthValidator!,
          errorText:
              widget.maxLengthMessage ??
              _ErrorMessages.maxLength(widget.maxLengthValidator!),
        ),
      );
    }

    // Özel doğrulama
    if (widget.customValidator != null) {
      validators.add(widget.customValidator!);
    }

    return validators.isEmpty
        ? null
        : FormBuilderValidators.compose(validators);
  }

  // ── Suffix İkon Oluşturucu ──

  /// Şifre toggle, temizle butonu ve kullanıcı suffix ikonunu birleştirir.
  Widget? _buildSuffix() {
    final icons = <Widget>[];

    // Şifre göster/gizle toggle
    if (widget.type == CustomFieldType.password && widget.showPasswordToggle) {
      icons.add(
        GestureDetector(
          onTap: () => setState(() => _obscure = !_obscure),
          child: Icon(
            _obscure
                ? Icons.visibility_off_outlined
                : Icons.visibility_outlined,
            size: 22,
          ),
        ),
      );
    }

    // Temizle butonu
    if (widget.showClearButton && widget.controller != null && _hasText) {
      icons.add(
        GestureDetector(
          onTap: () {
            widget.controller!.clear();
            widget.onChanged?.call('');
          },
          child: const Icon(Icons.clear, size: 20),
        ),
      );
    }

    // Kullanıcının kendi suffix ikonu
    if (widget.suffixIcon != null) {
      icons.add(widget.suffixIcon!);
    }

    if (icons.isEmpty) return null;
    if (icons.length == 1) return icons.first;

    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.end,
      children: icons,
    );
  }

  // ── Dekorasyon Oluşturucu ──

  /// Parametrelerden InputDecoration üretir.
  /// [decoration] verilmişse doğrudan onu döndürür.
  InputDecoration _buildDecoration() {
    if (widget.decoration != null) return widget.decoration!;

    return InputDecoration(
      labelText: widget.label,
      hintText: widget.hint,
      helperText: widget.helperText,
      prefixIcon: widget.prefixIcon,
      suffixIcon: _buildSuffix(),
      contentPadding: widget.contentPadding,
      border: widget.border,
      enabledBorder: widget.enabledBorder,
      focusedBorder: widget.focusedBorder,
      errorBorder: widget.errorBorder,
      labelStyle: widget.labelStyle,
      hintStyle: widget.hintStyle,
      counterText: widget.showCounter ? null : '',
    );
  }

  // ── Build ──

  @override
  Widget build(BuildContext context) {
    final effectiveKeyboard =
        widget.keyboardType ?? widget.type.defaultKeyboardType;
    final effectiveAutofill =
        widget.autofillHints ?? widget.type.defaultAutofillHints;
    final effectiveAction =
        widget.textInputAction ??
        (widget.nextFocusNode != null
            ? TextInputAction.next
            : TextInputAction.done);

    return FormBuilderTextField(
      name: widget.name,
      initialValue: widget.initialValue,
      controller: widget.controller,
      focusNode: widget.focusNode,
      enabled: widget.enabled,
      readOnly: widget.readOnly,
      autofocus: widget.autofocus,
      obscureText: _obscure,
      enableSuggestions: widget.enableSuggestions,
      autocorrect: widget.autocorrect,
      maxLength: widget.maxLength,
      maxLines: widget.type == CustomFieldType.password ? 1 : widget.maxLines,
      minLines: widget.minLines,
      keyboardType: effectiveKeyboard,
      textInputAction: effectiveAction,
      inputFormatters: widget.inputFormatters,
      autofillHints: effectiveAutofill,
      style: widget.style,
      decoration: _buildDecoration(),
      autovalidateMode: widget.autovalidateMode,
      validator: _buildValidator(),
      valueTransformer: widget.transform,
      onTap: widget.onTap,
      onChanged: widget.onChanged,
      onSubmitted: (value) {
        if (widget.nextFocusNode != null) {
          widget.nextFocusNode!.requestFocus();
        }
        widget.onSubmitted?.call(value);
      },
    );
  }
}
