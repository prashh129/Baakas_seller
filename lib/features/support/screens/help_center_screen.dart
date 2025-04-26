import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../../common/widgets/appbar/appbar.dart';
import '../widgets/faq_list.dart';
import '../widgets/guide_list.dart';
import '../widgets/support_ticket_list.dart';
import '../controllers/support_controller.dart';
import '../widgets/create_ticket_dialog.dart';
import '../../../utils/constants/colors.dart';

class HelpCenterScreen extends StatefulWidget {
  const HelpCenterScreen({super.key});

  @override
  State<HelpCenterScreen> createState() => _HelpCenterScreenState();
}

class _HelpCenterScreenState extends State<HelpCenterScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final _selectedIndex = 0.obs;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(() {
      _selectedIndex.value = _tabController.index;
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Get.put(SupportController());
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(120),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const BaakasAppBar(
                showBackArrow: true,
                title: Text('Help Center'),
              ),
              Material(
                color: theme.scaffoldBackgroundColor,
                child: TabBar(
                  controller: _tabController,
                  labelColor: theme.colorScheme.onSurface,
                  unselectedLabelColor: theme.colorScheme.onSurface
                      .withOpacity(0.5),
                  indicatorColor: BaakasColors.primaryColor,
                  tabs: const [
                    Tab(icon: Icon(Iconsax.message_question), text: 'FAQs'),
                    Tab(icon: Icon(Iconsax.book), text: 'Guides'),
                    Tab(icon: Icon(Iconsax.message), text: 'Support'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [FAQList(), GuideList(), SupportTicketList()],
      ),
      floatingActionButton: Obx(() {
        if (_selectedIndex.value == 2) {
          return FloatingActionButton(
            onPressed:
                () => showDialog(
                  context: context,
                  builder: (context) => const CreateTicketDialog(),
                ),
            backgroundColor: BaakasColors.primaryColor,
            child: Icon(
              Iconsax.message_add,
              color: theme.colorScheme.onPrimary,
            ),
          );
        }
        return const SizedBox.shrink();
      }),
    );
  }
}
