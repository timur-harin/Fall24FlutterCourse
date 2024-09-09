import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

@RoutePage()
class CatPage extends StatelessWidget {
  const CatPage({super.key, required this.statusCode});

  final String statusCode;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CachedNetworkImage(
          imageUrl: 'https://http.cat/$statusCode',
          placeholder: (context, url) => const CircularProgressIndicator(),
        )
      ),
    );
  }
}
