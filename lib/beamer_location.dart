import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:testingapp/main.dart';

// Home Page Beam Location
class HomeBeamLocation extends BeamLocation<BeamState> {
  @override
  List<Pattern> get pathPatterns => ['/'];

  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) {
    return [
      const BeamPage(
        key: ValueKey('home'),
        title: 'Home',
        child: HomePage(),
      ),
    ];
  }
}

// About Page Beam Location with Tab Handling
class AboutBeamLocation extends BeamLocation<BeamState> {
  final String tab;

  AboutBeamLocation({required this.tab});

  @override
  List<Pattern> get pathPatterns => ['/about/:tab'];

  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) {
    print(tab);
    return [
      BeamPage(
        key: ValueKey('about-$tab'),
        title: 'About',
        child: AboutPage(tab: tab),
      ),
    ];
  }
}

// Contact Page Beam Location
class ContactBeamLocation extends BeamLocation<BeamState> {
  @override
  List<Pattern> get pathPatterns => ['/contact'];

  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) {
    return [
      const BeamPage(
        key: ValueKey('contact'),
        title: 'Contact',
        child: ContactPage(),
      ),
    ];
  }
}
