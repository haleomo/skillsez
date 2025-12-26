import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:jaspr_router/jaspr_router.dart';

import '../constants/theme.dart';

class Header extends StatelessComponent {
  const Header({super.key});

  @override
  Component build(BuildContext context) {
    var activePath = context.url;

    return header([
      nav([
        div(classes: 'brand', [
          span([.text('Skills Ez')]),
          small([.text('AI-crafted learning plans')]),
        ]),
        for (var route in [
          (label: 'Home', path: '/'),
          (label: 'About', path: '/about'),
        ])
          div(classes: activePath == route.path ? 'active' : null, [
            Link(to: route.path, child: .text(route.label)),
          ]),
      ]),
    ]);
  }

  @css
  static List<StyleRule> get styles => [
    css('header', [
      css('&').styles(
        display: .flex,
        padding: .all(1.em),
        justifyContent: .center,
      ),
      css('nav', [
        css('&').styles(
          display: .flex,
          height: 3.em,
          radius: .all(.circular(10.px)), 
          overflow: .clip,
          alignItems: .center,
          gap: 0.25.em,
          justifyContent: .center,
          backgroundColor: primaryColor,
        ),
        css('.brand').styles(
          display: .flex,
          alignItems: .center,
          gap: 0.5.em,
          padding: EdgeInsets.symmetric(horizontal: 1.5.em),
          color: Colors.white,
          fontWeight: .w800,
          letterSpacing: 0.2.px,
        ),
        css('.brand small').styles(
          fontSize: 0.8.rem,
          opacity: 0.8,
          fontWeight: .w600,
        ),
        css('a', [
          css('&').styles(
            display: .flex,
            height: 100.percent,
            padding: .symmetric(horizontal: 2.em),
            alignItems: .center,
            color: Colors.white,
            fontWeight: .w700,
            textDecoration: TextDecoration(line: .none),
          ),
          css('&:hover').styles(
            backgroundColor: const Color('#0005'),
          ),
        ]),
        css('div.active', [
          css('&').styles(position: .relative()),
          css('&::before').styles(
            content: '',
            display: .block,
            position: .absolute(bottom: 0.5.em, left: 20.px, right: 20.px),
            height: 2.px,
            radius: .circular(1.px),
            backgroundColor: Colors.white,
          ),
        ])
      ]),
    ]),
  ];
}
