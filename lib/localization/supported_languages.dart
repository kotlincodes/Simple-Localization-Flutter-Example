import 'dart:ui';

const supportedLanguages = [
  const Locale.fromSubtags(languageCode: 'en'), // generic Chinese 'zh'
  const Locale.fromSubtags(
      languageCode: 'zh',
      scriptCode: 'Hant'), // generic traditional Chinese 'zh_Hant'
];
