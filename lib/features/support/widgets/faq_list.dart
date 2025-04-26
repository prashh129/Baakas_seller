import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../controllers/support_controller.dart';

class FAQList extends StatelessWidget {
  const FAQList({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<SupportController>();

    return Obx(() {
      if (controller.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }

      if (controller.faqs.isEmpty) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Iconsax.message_question, size: 64, color: Colors.grey[400]),
              const SizedBox(height: 16),
              Text(
                'No FAQs Available',
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

      // Group FAQs by category
      final groupedFaqs = <String, List<FAQ>>{};
      for (var faq in controller.faqs) {
        if (!groupedFaqs.containsKey(faq.category)) {
          groupedFaqs[faq.category] = [];
        }
        groupedFaqs[faq.category]!.add(faq);
      }

      return ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: groupedFaqs.length,
        itemBuilder: (context, index) {
          final category = groupedFaqs.keys.elementAt(index);
          final categoryFaqs = groupedFaqs[category]!;

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
              ...categoryFaqs.map(
                (faq) => Card(
                  color: const Color(0xFF404040),
                  margin: const EdgeInsets.only(bottom: 8),
                  child: ExpansionTile(
                    title: Text(
                      faq.question,
                      style: const TextStyle(color: Colors.white),
                    ),
                    iconColor: Colors.deepPurple,
                    collapsedIconColor: Colors.grey,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Text(
                          faq.answer,
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
