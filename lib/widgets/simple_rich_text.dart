import 'package:bank_sathi/Helpers/style_util.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

const Map<String, int> colorMap = {
  'aqua': 0x00FFFF,
  'black': 0x000000,
  'blue': 0x4356B6,
  'brown': 0x9A6324,
  'cream': 0xFFFDD0,
  'cyan': 0x46f0f0,
  'green': 0x00FF00,
  'gray': 0x808080,
  'grey': 0x808080,
  'mint': 0xAAFFC3,
  'lavender': 0xE6BEFF,
  'new': 0xFFFF00,
  'olive': 0x808000,
  'orange': 0xD66431,
  'pink': 0xFFE1E6,
  'purple': 0x800080,
  'red': 0xFF0000,
  'silver': 0xC0C0C0,
  'white': 0xFFFFFF,
  'yellow': 0xFFFF00
};

Color parseColor(String color) {
//  print("parseColor: $color");
  var v = colorMap[color];
  if (v == null) {
    return Colors.red;
  } else {
//    return Color(v);
//    return Colors.green;
//    int n = Color(v);
    Color out = Color((0xff << 24) | v);
//    print("parseColor: $color => $out");
    return out;
  }
}

/// Widget that renders a string with sub-string highlighting.
class SimpleRichText extends StatefulWidget {
  int? maxLines;

  SimpleRichText(
      {required this.text,
      this.chars,
      this.context,
      Key? key,
      this.textAlign,
      this.maxLines,
      this.fussy,
      this.style})
      : super(key: key);

//  final int clsInst = ++clsInst;
  final TextAlign? textAlign;
  final bool? fussy;

  final String? chars;

  /// The String to be displayed using rich text.
  final String? text;

  /// For navigation
  final BuildContext? context;

  /// The {TextStyle} of the {SimpleRichText.text} that isn't highlighted.
  final TextStyle? style;

  @override
  _SimpleRichText createState() {
    return _SimpleRichText();
  }

  /// The {TextStyle} of the {SimpleRichText.term}s found.
//  final TextStyle textStyleHighlight;
}

class _SimpleRichText extends State<SimpleRichText> {
  @override
  Widget build(BuildContext context) {
    if (widget.text == null) {
      return Text('');
    } else if (widget.text!.isEmpty) {
      return Text(widget.text!);
    } else {
      //print('text: $text');
      List<InlineSpan> children = [];

      Set set = Set();

      // split into array
      List<String> spanList =
          widget.text!.split(RegExp(widget.chars ?? r"[*~_\\]"));
      //print("len=${spanList.length}: $spanList");

      if (spanList.length == 1) {
        //print("trivial");
        return Text(widget.text!.replaceAll("<s>", '*'));
      } else {
        int i = 0;
        bool acceptNext = true;
        String? cmd;

        void wrap(String v) {
          //print("wrap: $v set=$set");
//          TextStyle xxx = textStyle.;

//          TextStyle ts = TextStyle(
//              decoration: set.contains('_')
//                  ? TextDecoration.underline
//                  : TextDecoration.none,
//              fontStyle:
//                  set.contains('/') ? FontStyle.italic : FontStyle.normal,
//              fontWeight:
//                  set.contains('*') ? FontWeight.bold : FontWeight.normal);

//          var map = Map<String, String>{};
          Map<String, String> map = {};

          if (cmd != null) {
            var pairs = cmd.split(';');
            for (var pair in pairs) {
              var a = pair.split(':');
              map[a[0]] = a[1];
            }
          }

          TextStyle ts = (widget.style ?? StyleUtils.textStyleNormalPoppins())
              .copyWith(
                  decoration:
                      set.contains('_')
                          ? TextDecoration.underline
                          : TextDecoration.none,
                  fontStyle:
                      set.contains('/') ? FontStyle.italic : FontStyle.normal,
                  fontWeight:
                      set.contains('*') ? FontWeight.w600 : FontWeight.normal);

//        TextSpan span = TextSpan(text: v, style: ts);
          if (map.containsKey('pop') ||
              map.containsKey('push') ||
              map.containsKey('repl')) {
//            print("[$clsInst] cmd=$cmd");
//            print("BBB cmd=$cmd");
//          GestureDetector
//        children.add(WidgetSpan(child: Text('****')));
//          children.add(WidgetSpan(
//              child: GestureDetector(
//            child: Text('CLICK'),
//            onTap: () async {
//              //print("TAPPED");
//            },
//          )));

            onTapNew(String caption, Map m) {
//              var a = cmd.split(':');
//              assert(a.length == 2);
//              String route;
//              if (a[0] == 'push') {
//                route = a[1];
//              }

              if (map.containsKey('push')) {
                String? v = map['push'];
                return () {
                  assert(v != null);
                  Navigator.pushNamed(context, '/$v');
                };
              } else if (map.containsKey('repl')) {
                String? v = map['repl'];
                return () {
                  assert(v != null);
                  Navigator.popAndPushNamed(context, '/$v');
                };
              } else {
                return () {
                  Navigator.pop(context);
                };
              }
            }

            //ISSUE: need each onTap to remember state at that point
            children.add(TextSpan(
                text: v.replaceAll("<s>", '*'),
                // Beware!  This class is only safe because the TapGestureRecognizer is not given a deadline and therefore never allocates any resources.
                // In any other situation -- setting a deadline, using any of the less trivial recognizers, etc -- you would have to manage the gesture recognizer's lifetime
                // and call dispose() when the TextSpan was no longer being rendered.
                // Since TextSpan itself is @immutable, this means that you would have to manage the recognizer from outside
                // the TextSpan, e.g. in the State of a stateful widget that then hands the recognizer to the TextSpan.
                recognizer: TapGestureRecognizer()..onTap = onTapNew(v, map),
                style: ts));
          } else {
//          children.add(span);
            children.add(TextSpan(text: v.replaceAll("<s>", '*'), style: ts));
          }
        }

        void toggle(String m) {
          if (m == r'\') {
            String c = widget.text!.substring(i + 1, i + 2);
            //print("quote: i=$i: $c");
            wrap(c);
            acceptNext = false;
          } else {
            if (acceptNext) {
              if (set.contains(m)) {
                //print("REM: $m");
                set.remove(m);
              } else {
                //print("ADD: $m");
                set.add(m);
              }
            }

            acceptNext = true;
          }
        }

        for (var v in spanList) {
//          print("========== $v ==========");
          cmd = null; //TRY
          if (v.isEmpty) {
            if (i < widget.text!.length) {
              String m = widget.text!.substring(i, i + 1);
//          //print("e: $m");
              toggle(m);
              i++;
            }
          } else {
            int adv = v.length;
            if (v[0] == '{') {
              int close = v.indexOf('}');
              if (close > 0) {
                cmd = v.substring(1, close);
                v = v.substring(close + 1);
//                print("remaining: $v");
              }
            }
            wrap(v);
            i += adv;
            if (i < widget.text!.length) {
              String m = widget.text!.substring(i, i + 1);
              toggle(m);
              i++;
            }
          }
        }

        if ((widget.fussy ?? false) && set.isNotEmpty) {
          throw 'simple_rich_text: not closed: $set'; //TODO: throw real error?
        }

        return RichText(
          text: TextSpan(children: children),
          maxLines: widget.maxLines,
          textAlign: widget.textAlign ?? TextAlign.justify,
        );
      }
    }
  }
}
