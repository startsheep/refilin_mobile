import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:refilin_mobile/app/common/buttons/x_Icon_button.dart';
import 'package:refilin_mobile/app/common/buttons/x_button.dart';
import 'package:refilin_mobile/app/common/input/x_field.dart';
import 'package:refilin_mobile/app/common/shape/rounded_container.dart';
import 'package:refilin_mobile/app/common/ui/xpicture.dart';
import 'package:refilin_mobile/app/models/product_model.dart';
import 'package:refilin_mobile/app/models/review_model.dart';
import 'package:refilin_mobile/app/modules/review/controllers/create_review_controller.dart';
import 'package:refilin_mobile/app/modules/review/controllers/form_review_controller.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class CreateReviewView extends GetView<CreateReviewController> {
  const CreateReviewView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Beri Ulasan',
            style: TextStyle(
              fontSize: 16,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: Colors.white,
          iconTheme: const IconThemeData(color: Colors.black),
          centerTitle: true,
        ),
        persistentFooterButtons: [
          XButton(
            text: "Kirim",
            onPressed: () {
              controller.createReview();
            },
          )
        ],
        body: RoundedContainer(
          constraints: BoxConstraints(maxHeight: Get.height),
          child: ListView.separated(
            padding: const EdgeInsets.all(10),
            separatorBuilder: (context, index) => const Divider(),
            itemCount: controller.products.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              final product = controller.products[index];
              return FormReview(
                product: product,
                key: ValueKey(product.id),
                onChange: (val) {
                  controller.reviews[index] = val;
                },
              );
            },
          ),
        ));
  }
}

class FormReview extends GetView<FormReviewController> {
  final ProductModel product;
  final Function(ReviewModel) onChange;
  const FormReview({
    super.key,
    required this.product,
    required this.onChange,
  });
  @override
  // TODO: implement tag
  String? get tag => product.id.toString();
  @override
  // TODO: implement controller
  FormReviewController get controller =>
      Get.put<FormReviewController>(FormReviewController(), tag: tag!);
  @override
  Widget build(BuildContext context) {
    return RoundedContainer(
      padding: const EdgeInsets.all(10),
      hasBorder: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: XPicture(
              imageUrl: product.image!,
              size: 40,
            ),
            title: Text(
              product.name!,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          const Text(
            " Komentar",
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 14,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            children: [
              Expanded(
                child: XTextField(
                  hintText: "Tulis ulasanmu disini",
                  maxLines: 5,
                  onChanged: (val) {
                    controller.review.value.message = val;
                    onChange(controller.review.value);
                  },
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              XIconButton(
                icon: MdiIcons.camera,
                onTap: () {},
                color: Theme.of(context).primaryColor,
                supportColor: Theme.of(context).primaryColor,
              )
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          const Text(
            " Nilai",
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 14,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          RatingBar.builder(
            allowHalfRating: true,
            itemCount: 5,
            initialRating: controller.review.value.point!.toDouble(),
            // glow: false,
            glowColor: Colors.amber,
            itemBuilder: (context, index) => const Icon(
              MdiIcons.starBox,
              color: Colors.amber,
            ),

            onRatingUpdate: (val) {
              controller.review.value.point = int.parse(val.toStringAsFixed(0));
              onChange(controller.review.value);
            },
          )
        ],
      ),
    );
  }
}
