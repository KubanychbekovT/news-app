import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:news_app/domain/models/article/article.dart';
import 'package:news_app/infrastructure/configs/app.dart';
import 'package:news_app/infrastructure/configs/app_dimensions.dart';
import 'package:news_app/infrastructure/configs/app_theme.dart';
import 'package:news_app/infrastructure/configs/app_typography.dart';
import 'package:news_app/presentation/article_content/article_content.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:intl/intl.dart';
import '../../infrastructure/configs/space.dart';

class ArticleCard extends StatelessWidget {
  final Article article;
  const ArticleCard({Key? key, required this.article}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: Space.all(0, 0.5),
      padding: Space.all(0.5, 1),
      decoration: BoxDecoration(
        color: AppTheme.c!.background,
        borderRadius: BorderRadius.circular(
          AppDimensions.normalize(3),
        ),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            offset: Offset(0, 10),
            blurRadius: 12,
            spreadRadius: 6.0,
          )
        ],
      ),
      child: InkWell(
        onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
            builder: (_) => ArticleContentScreen(
                article: article
            ),
            ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                Container(
                  width: AppDimensions.normalize(45),
                  height: AppDimensions.normalize(45),
                  decoration: BoxDecoration(
                    image: article.urlToImage != null
                        ? DecorationImage(image: NetworkImage(article.urlToImage!),
                    fit: BoxFit.cover,
                    )
                        :null,
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(
                      AppDimensions.normalize(3),
                    ),
                  ),
                ),
                Space.y!,
                Text(
                  DateFormat('EE d, yyyy').format(
                    DateTime.parse(
                      article.publishedAt!,
                    ),
                  ),
                  style: AppText.b2,
                ),
              ],
            ),
            Space.x1!,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    article.title!,
                    style: AppText.h3b,
                    maxLines: 2,
                  ),
                  Space.y!,
                  Text(
                    article.source!.name!,
                    style: AppText.b2,
                  ),
                  Space.y!,
                  Text(
                    article.description!,
                    maxLines: 3,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
