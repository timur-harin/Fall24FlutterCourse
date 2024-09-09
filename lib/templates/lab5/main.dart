import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final GoRouter _router = GoRouter(
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => HomePage(),
        ),
        GoRoute(
          path: '/about',
          builder: (context, state) => AboutPage(),
        ),
        GoRoute(
          path: '/services',
          builder: (context, state) => ServicesPage(),
        ),
        GoRoute(
          path: '/contact',
          builder: (context, state) => ContactPage(),
        ),
        GoRoute(
          path: '/undefined',
          builder: (context, state) => UndefinedPage(),
        ),
      ],
      errorBuilder: (context, state) => UndefinedPage(),
    );

    return MaterialApp.router(
      routerDelegate: _router.routerDelegate,
      routeInformationParser: _router.routeInformationParser,
      routeInformationProvider: _router.routeInformationProvider,
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildNavigationButton(context, 'About', '/about'),
            _buildNavigationButton(context, 'Services', '/services'),
            _buildNavigationButton(context, 'Contact', '/contact'),
          ],
        ),
      ),
    );
  }

  Widget _buildNavigationButton(BuildContext context, String text, String route) {
    return ElevatedButton(
      onPressed: () {
        context.go(route);
      },
      child: Text(text),
    );
  }
}

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('About')),
      body: Center(child: Text('About Page')),
    );
  }
}

class ServicesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Services')),
      body: Center(child: Text('Services Page')),
    );
  }
}

class ContactPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Contact')),
      body: Center(child: Text('Contact Page')),
    );
  }
}

class UndefinedPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('404')),
      body: Center(
        child: Image.network(
          'https://http.cat/404',
          errorBuilder: (context, error, stackTrace) {
            return Text('Failed to load image');
          },
        ),
      ),
    );
  }
}
