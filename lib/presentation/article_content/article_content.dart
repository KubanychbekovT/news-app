import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:news_app/domain/models/article/article.dart';
import 'package:news_app/infrastructure/configs/app_typography.dart';
import 'package:news_app/infrastructure/configs/space.dart';
import 'package:url_launcher/url_launcher.dart';

class ArticleContentScreen extends StatelessWidget {
  final Article article;
  const ArticleContentScreen({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            padding: Space.all(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: BackButton(
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
                Space.y!,
                Text(
                  article.title!,
                  style: AppText.h1b,
                ),
                Space.y!,
                Image.network(
                  article.urlToImage!,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(article.author!,
                    style: AppText.b2b,
                    ),
                    TextButton(
                        onPressed: () => launchUrl(Uri.parse(article.url!)),
                        child: Row(
                          children: [
                            Transform.rotate(
                                angle: math.pi * 0.70,
                            child:  const Icon(Icons.link_off_rounded),
                            ),
                            Space.xf(0.25),
                            Text(
                              article.source!.name!,
                            ),
                          ],
                        ),
                    ),
                  ],
                ),
                Space.y1!,
                Text(
                  article.content!,
                )
              ],
            ),
          ),
        ),
    );
  }
}
