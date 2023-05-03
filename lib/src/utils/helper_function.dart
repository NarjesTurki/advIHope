import 'package:html/parser.dart';

String parseHtmlString(String htmlString) {
  final document = parse(htmlString);
  final String parsedString = parse(document.body!.text).documentElement!.text;
  // parsedString.replaceAll(from, replace)
  return parsedString;
}
