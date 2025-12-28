import 'dart:ui';

import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';

import '../constants/theme.dart';

// By using the @client annotation this component will be automatically compiled to javascript and mounted
// on the client. Therefore:
// - this file and any imported file must be compilable for both server and client environments.
// - this component and any child components will be built once on the server during pre-rendering and then
//   again on the client during normal rendering.
@client
class Home extends StatefulComponent {
  const Home({super.key});

  @override
  State<Home> createState() => HomeState();

  @css
  static List<StyleRule> get styles => [
    css('section', [
      css('&').styles(
        display: .flex,
        padding: Padding.symmetric(vertical: 3.em, horizontal: 1.5.em),
        flexDirection: .column,
        alignItems: .center,
        gap: Gap.all(2.5.em),
        textAlign: .center,
      ),
    ]),
    css('.hero', [
      css('&').styles(
        display: .flex,
        flexDirection: .column,
        alignItems: .center,
        gap: Gap.all(1.em),
        maxWidth: 720.px,
      ),
      css('h1').styles(fontSize: 2.8.rem, letterSpacing: 0.5.px),
      css('p').styles(fontSize: 1.15.rem, lineHeight: 1.6.em, color: const Color('#1f2937')),
      css('.cta', [
        css('&').styles(
          display: .flex,
          gap: Gap.all(1.em),
          flexWrap: .wrap,
          justifyContent: .center,
        ),
        css('a').styles(
          display: .inlineFlex,
          padding: Padding.symmetric(vertical: 0.9.em, horizontal: 1.4.em),
          radius: BorderRadius.circular(10.px),
          shadow: BoxShadow(
            color: Color('#00000018'),
            blur: Unit.pixels(10),
            offsetX: Unit.pixels(8),
            offsetY: Unit.pixels(0),
          ),
          color: Colors.white,
          fontWeight: .w700,
          textDecoration: TextDecoration(line: .none),
          backgroundColor: primaryColor,
        ),
        css('a:last-child').styles(backgroundColor: const Color('#0f172a'), color: Colors.white),
        css('a:hover').styles(opacity: 0.9),
      ]),
    ]),
    css('.form-card', [
      css('&').styles(
        display: .flex,
        flexDirection: .column,
        gap: Gap.all(1.5.em),
        padding: Padding.all(1.5.em),
        radius: BorderRadius.circular(14.px),
        backgroundColor: Colors.white,
        shadow: BoxShadow(color: Color('#00000018'), blur: Unit.pixels(10), offsetX: Unit.pixels(8), offsetY: Unit.pixels(0)),
      ),
      css('.form-header').styles(
        display: .flex,
        flexDirection: .column,
        gap: Gap.all(0.4.em),
        textAlign: .left,
      ),
      css('h2').styles(
        color: const Color('#0f172a'),
        fontSize: 1.5.rem,
      ),
      css('p').styles(color: const Color('#475569')),
      css('form').styles(
        display: .grid,
        gridTemplate: GridTemplate(columns: [Flex(1)]),
        gap: Gap.all(1.em),
      ),
      css('label').styles(
        alignItems: .start,
        color: const Color('#0f172a'),
        display: .flex,
        flexDirection: .column,
        fontWeight: .w700,
        fontSize: 0.95.rem,
        gap: Gap.all(0.35.em),
      ),
      css('input').styles(
        backgroundColor: const Color('#f8fafc'),
        border: const Border.all(color: Color('#e2e8f0'), width: Unit.pixels(1)),
        fontSize: 1.rem,
        outline: Outline.unset,
        padding: Padding.all(0.9.em),
        radius: BorderRadius.circular(10.px),
      ),
      css('input:focus').styles(
        backgroundColor: Colors.white,
        border: const Border.all(color: primaryColor, width: Unit.pixels(0.15)),
      ),
      css('.submit-btn').styles(
        backgroundColor: primaryColor,
        border: Border.all(color: primaryColor),
        color: Colors.white,
        cursor: .pointer,
        fontWeight: .w800,
        padding: Padding.symmetric(vertical: 0.95.em),
        radius: BorderRadius.circular(10.px),
        shadow: BoxShadow(color: Color('#00000018'), blur: Unit.pixels(10), offsetX: Unit.pixels(8), offsetY: Unit.pixels(0)),
      ),
      css('.submit-btn:hover').styles(opacity: 0.92),
      css('@media (max-width: 780px)', [
        css('form').styles(
          gridTemplate: '1fr',
        ),
      ]),
    ]),
    css('.pillars').styles(
      display: .grid,
      gap: Gap.all(1.2.em),
      gridTemplate: GridTemplate(columns: [Flex(1), Flex(1), Flex(1)]),
      maxWidth: 960.px,
      width: 100.percent,
    ),
    css('@media (max-width: 900px)', [
      css('.pillars').styles(
        gridTemplate: GridTemplate(columns: [Flex(1)]),
      ),
    ]),
    css('.pillar').styles(
      backgroundColor: const Color('#f8fafc'),
      display: .flex,
      flexDirection: .column,
      gap: Gap.all(0.5.em),
      padding: Padding.all(1.4.em),
      radius: BorderRadius.circular(12.px),
      shadow: BoxShadow(color: Color('#00000018'), blur: Unit.pixels(10), offsetX: Unit.pixels(8), offsetY: Unit.pixels(0)),
      textAlign: .left,
    ),
    css('.pillar h3').styles(
      color: const Color('#0f172a'),
      fontSize: 1.3.rem,
    ),
    css('.pillar p').styles(
      color: const Color('#334155'),
      fontSize: 1.05.rem,
      lineHeight: 1.6.em,
    ),
  ];
}

class HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
    // Run code depending on the rendering environment.
    if (kIsWeb) {
      print("Hello client");
      // When using @client components there is no default `main()` function on the client where you would normally
      // run any client-side initialization logic. Instead you can put it here, considering this component is only
      // mounted once at the root of your client-side component tree.
    } else {
      print("Hello server");
    }
  }

  @override
  Component build(BuildContext context) {
    return section([
      div(classes: 'hero', [
        img(src: 'images/logo.svg', width: 96, height: 96, alt: 'Skills Ez logo'),
        h1([.text('Build skills with clarity')]),
        p([
          .text(
            'Skills Ez crafts AI-powered learning plans so you can focus on doing the work, not guessing the path.',
          ),
        ]),
        div(classes: 'cta', [
          a(href: '/about', [.text('How it works')]),
          a(href: 'https://github.com/robnelson/skills-ez', [.text('View source')]),
        ]),
      ]),
      div(classes: 'form-card', [
        div(classes: 'form-header', [
          h2([.text('Describe your learning profile')]),
          p([.text('We will use these details to craft an optimized AI prompt for your plan.')]),
        ]),
        form([
          _field(
            id: 'sourceExpertDiscipline',
            labelText: 'Source Expert Discipline',
            placeholder: 'Software Engineering',
          ),
          _field(
            id: 'subjectEducationLevel',
            labelText: 'Subject Education Level',
            placeholder: "Bachelor's",
          ),
          _field(
            id: 'subjectDiscipline',
            labelText: 'Subject Discipline',
            placeholder: 'Computer Science',
          ),
          _field(
            id: 'subjectWorkExperience',
            labelText: 'Subject Work Experience',
            placeholder: '2 years web development',
          ),
          _field(
            id: 'subjectExperienceTime',
            labelText: 'Subject Experience Time',
            placeholder: '2 years',
          ),
          _field(
            id: 'topic',
            labelText: 'Topic',
            placeholder: 'Flutter Development',
          ),
          _field(
            id: 'goal',
            labelText: 'Goal (e.g., work, general knowledge, hire)',
            placeholder: 'work',
          ),
          _field(
            id: 'role',
            labelText: 'Role (e.g., planner, engineer, coder)',
            placeholder: 'mobile developer',
          ),
          button(classes: 'submit-btn', type: ButtonType.button, [
            .text('Generate learning plan (coming soon)'),
          ]),
        ]),
      ]),
      div(classes: 'pillars', [
        _pillar('Tell us the skill', 'Describe what you want to learn—anything from TypeScript to watercolor.'),
        _pillar('We draft the plan', 'Skills Ez builds an optimized AI prompt that generates a sequenced roadmap.'),
        _pillar('You execute with focus', 'Follow milestones, stay accountable, and iterate as you grow.'),
      ]),
    ]);
  }
}

Component _pillar(String title, String body) {
  return div(classes: 'pillar', [
    h3([.text(title)]),
    p([.text(body)]),
  ]);
}

Component _field({required String id, required String labelText, String? placeholder}) {
  return label(id: id, [
    span([.text(labelText)]),
    input(
      id: id,
      name: id,
      type: InputType.text,
      attributes: {
        if (placeholder != null) 'placeholder': placeholder,
      },
    ),
  ]);
}
