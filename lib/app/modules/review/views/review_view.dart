import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:refilin_mobile/app/common/shape/rounded_container.dart';
import 'package:refilin_mobile/app/common/ui/xpicture.dart';
import 'package:refilin_mobile/app/common/utils.dart';

import '../controllers/review_controller.dart';

class ReviewView extends GetView<ReviewController> {
  const ReviewView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return controller.obx(
      (reviews) {
        return RefreshIndicator(
          onRefresh: () async {
            controller.getReviews();
          },
          child: RoundedContainer(
            padding: const EdgeInsets.all(10),
            constraints: const BoxConstraints(maxHeight: 200),
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: reviews!.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                final review = reviews[index];
                return ListTile(
                  leading: const XPicture(
                    imageUrl: "",
                    size: 40,
                    assetImage: "assets/images/avatar.png",
                  ),
                  title: Text(
                    review.user!.name!,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      ExpandableText(
                        review.message!,
                        expandText: "selengkapnya",
                        collapseText: "sembunyikan",
                        maxLines: 2,
                      ),
                      const SizedBox(height: 5),
                      Text(
                        Utils.getFormattedDate(review.createdAt!),
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.star,
                        color: Colors.amber,
                        size: 15,
                      ),
                      Text(
                        review.point.toString(),
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        );
      },
      onEmpty: const Center(
        child: Text("Belum ada ulasan"),
      ),
      onLoading: Center(
        child: Utils.loadingWidget(
          size: 20,
        ),
      ),
    );
  }
}
