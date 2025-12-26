import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';

class Footer extends StatelessComponent {
  const Footer({super.key});

  @override
  Component build(BuildContext context) {
    return footer([
      div(classes: 'footer-content', [
        span([.text('Skills Ez')]),
        span([.text('AI-crafted learning plans')]),
      ]),
    ]);
  }

  @css
  static List<StyleRule> get styles => [
    css('footer', [
      css('&').styles(
        display: .flex,
        justifyContent: .center,
        padding: EdgeInsets.symmetric(vertical: 1.25.em, horizontal: 1.em),
        backgroundColor: const Color('#0f172a'),
        color: Colors.white,
      ),
      css('.footer-content').styles(
        display: .flex,
        gap: 0.8.em,
        fontWeight: .w600,
        letterSpacing: 0.2.px,
        alignItems: .center,
      ),
      css('span:last-child').styles(opacity: 0.75),
    ]),
  ];
}
