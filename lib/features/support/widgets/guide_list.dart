import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../controllers/support_controller.dart';

class GuideList extends StatelessWidget {
  const GuideList({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<SupportController>();

    return Obx(() {
      if (controller.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }

      if (controller.guides.isEmpty) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Iconsax.book, size: 64, color: Colors.grey[400]),
              const SizedBox(height: 16),
              Text(
                'No Guides Available',
                style: Theme.of(
                  context,
                ).textTheme.titleLarge?.copyWith(color: Colors.grey[400]),
              ),
              const SizedBox(height: 8),
              Text(
                'Check back later for updates',
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(color: Colors.grey[400]),
              ),
            ],
          ),
        );
      }

      // Group guides by category
      final groupedGuides = <String, List<Guide>>{};
      for (var guide in controller.guides) {
        if (!groupedGuides.containsKey(guide.category)) {
          groupedGuides[guide.category] = [];
        }
        groupedGuides[guide.category]!.add(guide);
      }

      return ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: groupedGuides.length,
        itemBuilder: (context, index) {
          final category = groupedGuides.keys.elementAt(index);
          final categoryGuides = groupedGuides[category]!;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (index > 0) const SizedBox(height: 24),
              Text(
                category,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              ...categoryGuides.map(
                (guide) => Card(
                  color: const Color(0xFF404040),
                  margin: const EdgeInsets.only(bottom: 8),
                  child: ExpansionTile(
                    title: Text(
                      guide.title,
                      style: const TextStyle(color: Colors.white),
                    ),
                    iconColor: Colors.deepPurple,
                    collapsedIconColor: Colors.grey,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Text(
                          guide.content,
                          style: TextStyle(color: Colors.grey[300]),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      );
    });
  }
}
