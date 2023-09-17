import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:refilin_mobile/app/common/shape/rounded_container.dart';
import 'package:refilin_mobile/app/common/ui/xpicture.dart';
import 'package:refilin_mobile/app/common/utils.dart';
import 'package:refilin_mobile/app/models/product_model.dart';
import 'package:refilin_mobile/app/modules/store/controllers/store_detail_controlle.dart';
import 'package:refilin_mobile/app/themes/theme.dart';

class ProductGrid extends StatelessWidget {
  const ProductGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final StoreDetailController controller = Get.find();

    return RoundedContainer(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Produk Di ${controller.store.value.name!}",
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 5),
          RoundedContainer(
            constraints: const BoxConstraints(
              minHeight: 100,
              maxHeight: 300,
            ),
            child: FutureBuilder<List<ProductModel>>(
              future: controller.productsStore(),
              initialData: const [],
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: Utils.loadingWidget(
                      size: 40,
                    ),
                  );
                } else if (snapshot.hasError) {
                  return const Center(
                    child: Text("Error"),
                  );
                } else if (snapshot.hasData) {
                  return GridView.builder(
                    padding: const EdgeInsets.all(0),
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      childAspectRatio: 0.7,
                    ),
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      final ProductModel product = snapshot.data![index];

                      return RoundedContainer(
                        margin: const EdgeInsets.all(5),
                        hasBorder: true,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            XPicture(
                              imageUrl: product.image!,
                              sizeWidth: Get.width,
                              sizeHeight: 100,
                            ),
                            const SizedBox(height: 5),
                            Text(
                              product.name!,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 5),
                            RoundedContainer(
                              padding: const EdgeInsets.all(5),
                              radius: 5,
                              color: ThemeApp.primaryColor.withOpacity(0.1),
                              child: Text(
                                product.priceFormatted,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                } else {
                  return const Center(
                    child: Text("Data Kosong"),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
