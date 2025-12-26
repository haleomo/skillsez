import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';

// By using the @client annotation this component will be automatically compiled to javascript and mounted
// on the client. Therefore:
// - this file and any imported file must be compilable for both server and client environments.
// - this component and any child components will be built once on the server during pre-rendering and then
//   again on the client during normal rendering.
@client
class About extends StatelessComponent {
  const About({super.key});

  @override
  Component build(BuildContext context) {
    return const section([
      div(classes: 'about-hero', [
        h1([.text('About Skills Ez')]),
        p([
          .text(
              'Skills Ez is a tool that helps people develop new skills by creating a learning plan to help them acquire them.'),
        ]),
        p([
          .text(
              'The user simply tells the application which skill they want to build, and the application generates an optimized AI query that produces a step-by-step plan for learning the skill.'),
        ]),
      ]),
      ul([
        li([
          strong([.text('Why it matters: ')]),
          .text('Removes guesswork and gives you a structured path from day one.'),
        ]),
        li([
          strong([.text('How it works: ')]),
          .text('You choose the skill, Skills Ez crafts the AI prompt, and you get a sequenced learning plan with milestones.'),
        ]),
        li([
          strong([.text('Who it is for: ')]),
          .text('Anyone who wants a clear, personalized roadmap to learn faster and stay accountable.'),
        ]),
      ]),
    ]);
  }

  @css
  static List<StyleRule> get styles => [
    css('section').styles(maxWidth: 760.px, margin: EdgeInsets.symmetric(vertical: 2.em, horizontal: auto)),
    css('.about-hero', [
      css('&').styles(
        display: .flex,
        flexDirection: .column,
        gap: 0.75.em,
        textAlign: .center,
      ),
      css('h1').styles(fontSize: 2.4.rem),
      css('p').styles(fontSize: 1.1.rem, lineHeight: 1.6.em),
    ]),
    css('ul').styles(
      margin: EdgeInsets.only(top: 1.5.em),
      padding: EdgeInsets.symmetric(horizontal: 0),
      listStyleType: ListStyleType.none,
      display: .flex,
      flexDirection: .column,
      gap: 1.em,
    ),
    css('li').styles(
      padding: EdgeInsets.all(1.em),
      radius: BorderRadius.circular(8.px),
      backgroundColor: const Color('#f4f6fb'),
      boxShadow: const [BoxShadow(color: Color('#00000010'), blurRadius: 8.px, spreadRadius: 0.px, offset: Offset(0, 4))],
    ),
    css('strong').styles(color: primaryColor),
  ];
}
