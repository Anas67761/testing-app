// ignore_for_file: deprecated_member_use

import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:testingapp/beamer_location.dart';

void main() {
  final routerDelegate = BeamerDelegate(
    locationBuilder: (state, _) => getLocation(state, _),
  );

  runApp(MyApp(routerDelegate: routerDelegate));
}

class MyApp extends StatelessWidget {
  final BeamerDelegate routerDelegate;

  const MyApp({super.key, required this.routerDelegate});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerDelegate: routerDelegate,
      routeInformationParser: BeamerParser(),
      title: 'Flutter Web Navigation',
    );
  }
}

BeamLocation getLocation(RouteInformation state, BeamParameters? parameters) {
  final uri = Uri.parse(state.location);
  if (uri.pathSegments.isEmpty) {
    return HomeBeamLocation();
  } else if (uri.pathSegments[0] == 'about') {
    final tab = uri.pathSegments.length > 1 ? uri.pathSegments[1] : 'overview';
    return AboutBeamLocation(tab: tab);
  } else if (uri.pathSegments[0] == 'contact') {
    return ContactBeamLocation();
  }
  return HomeBeamLocation();
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: const Center(child: Text('Home Page')),
    );
  }
}

class AboutPage extends StatefulWidget {
  final String tab;

  const AboutPage({super.key, required this.tab});
  @override
  AboutPageState createState() => AboutPageState();
}

class AboutPageState extends State<AboutPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    // Initialize TabController with default tab index
    _tabController = TabController(
      length: 3,
      vsync: this,
      initialIndex: _getTabIndex(widget.tab),
    );

    // Listen for changes in the TabController and update the URL accordingly
    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        final selectedTab = _tabController.index == 0
            ? 'overview'
            : _tabController.index == 1
                ? 'team'
                : 'history';
        context.beamToNamed('/about/$selectedTab');
      }
    });

    // Listen for route changes and update the tab controller accordingly
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _tabController.index = _getTabIndex(widget.tab);
    });
  }

  int _getTabIndex(String tab) {
    switch (tab) {
      case 'team':
        return 1;
      case 'history':
        return 2;
      default:
        return 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Overview'),
            Tab(text: 'Team'),
            Tab(text: 'History'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          Center(child: Text('Overview Content')),
          Center(child: Text('Team Content')),
          Center(child: Text('History Content')),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}

class ContactPage extends StatelessWidget {
  const ContactPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Contact')),
      body: const Center(child: Text('Contact Page')),
    );
  }
}
