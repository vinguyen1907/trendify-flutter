import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_app/constants/app_colors.dart';
import 'package:ecommerce_app/extensions/date_time_extension.dart';
import 'package:ecommerce_app/extensions/string_extensions.dart';
import 'package:ecommerce_app/models/review.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ReviewItem extends StatefulWidget {
  const ReviewItem({super.key, required this.review});
  final Review review;

  @override
  State<ReviewItem> createState() => _ReviewItemState();
}

class _ReviewItemState extends State<ReviewItem> {
  final int maxLength = 20;
  late List<String> content;
  late bool isExpanded;

  @override
  void initState() {
    content = widget.review.content.split(' ');
    isExpanded = content.length <= maxLength;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    List<Widget> stars = List.generate(
        widget.review.rate,
        (index) => const Icon(
              Icons.star,
              color: Colors.orange,
              size: 18,
            ));
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: AppColors.whiteColor,
            boxShadow: [
              BoxShadow(
                  color: AppColors.primaryColor.withOpacity(0.2),
                  blurRadius: 7,
                  spreadRadius: 1,
                  offset: const Offset(0, 6))
            ]),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: SizedBox(
                height: size.height * 0.1,
                width: size.height * 0.1,
                child: CachedNetworkImage(
                  imageUrl: widget.review.avaUrl,
                  imageBuilder: (context, imageProvider) => Container(
                    height: size.height * 0.1,
                    width: size.height * 0.1,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  placeholder: (context, url) => Shimmer.fromColors(
                    baseColor: const Color(0xFFE0E0E0),
                    highlightColor: const Color(0xFFF5F5F5),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.white,
                      ),
                    ),
                  ), // Loading placeholder
                  errorWidget: (context, url, error) =>
                      const Center(child: Icon(Icons.error)),
                ),
              ),
            ),
            Expanded(
                child: Padding(
              padding: const EdgeInsets.only(top: 12.0, bottom: 12, right: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.review.nameUser.formatName(),
                              style: Theme.of(context).textTheme.labelLarge,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              widget.review.createdAt.formattedDate(),
                              style: Theme.of(context).textTheme.bodyMedium,
                            )
                          ],
                        ),
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: stars,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  GestureDetector(
                      onTap: () => _showMore(),
                      child: !isExpanded
                          ? RichText(
                              text: TextSpan(children: [
                              TextSpan(
                                  text: content.sublist(0, maxLength).join(' '),
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(
                                          fontSize: 15,
                                          color: AppColors.primaryColor)),
                              TextSpan(
                                  text: '...See more',
                                  style: Theme.of(context).textTheme.bodyLarge)
                            ]))
                          : RichText(
                              text: TextSpan(children: [
                              TextSpan(
                                  text: content.join(' '),
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(
                                          fontSize: 15,
                                          color: AppColors.primaryColor)),
                            ]))),
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }

  void _showMore() {
    setState(() {
      if (!isExpanded) {
        isExpanded = !isExpanded;
      }
    });
  }
}
