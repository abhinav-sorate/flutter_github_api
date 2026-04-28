import 'dart:ui';

class LanguageColorUtil {
  static const Map<String, Color> _languageColors = {
    'javascript': Color(0xFFF1E05A),
    'typescript': Color(0xFF3178C6),
    'dart': Color(0xFF00B4AB),
    'python': Color(0xFF3572A5),
    'java': Color(0xFFB07219),
    'kotlin': Color(0xFFA97BFF),
    'swift': Color(0xFFFFAC45),
    'go': Color(0xFF00ADD8),
    'c': Color(0xFF555555),
    'c++': Color(0xFFF34B7D),
    'c#': Color(0xFF178600),
    'php': Color(0xFF4F5D95),
    'ruby': Color(0xFF701516),
    'rust': Color(0xFFDEA584),
    'scala': Color(0xFFC22D40),
    'shell': Color(0xFF89E051),
    'html': Color(0xFFE34C26),
    'css': Color(0xFF563D7C),
    'objective-c': Color(0xFF438EFF),
    'groovy': Color(0xFF4298B8),
    'powershell': Color(0xFF012456),
    'lua': Color(0xFF000080),
    'r': Color(0xFF198CE7),
    'elixir': Color(0xFF6E4A7E),
    'haskell': Color(0xFF5E5086),
  };

  static Color getColor(String? language) {
    if (language == null) return const Color(0xFFCCCCCC);

    return _languageColors[language.toLowerCase()] ?? const Color(0xFFCCCCCC);
  }
}
