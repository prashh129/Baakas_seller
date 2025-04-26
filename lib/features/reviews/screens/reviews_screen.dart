import 'package:flutter/material.dart';
import '../widgets/review_list.dart';
import '../../../common/widgets/appbar/appbar.dart';

class ReviewsScreen extends StatelessWidget {
  const ReviewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(120),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const BaakasAppBar(
                  showBackArrow: true,
                  title: Text('Customer Reviews'),
                ),
                Material(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  child: TabBar(
                    labelColor: Theme.of(context).textTheme.bodyLarge?.color,
                    unselectedLabelColor: Theme.of(
                      context,
                    ).textTheme.bodyLarge?.color?.withOpacity(0.5),
                    indicatorColor: Theme.of(context).primaryColor,
                    tabs: const [
                      Tab(text: 'All Reviews'),
                      Tab(text: 'Unread'),
                      Tab(text: 'Responses'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        body: TabBarView(
          children: [
            ReviewList(),
            ReviewList(filter: ReviewFilter.unread),
            ReviewList(filter: ReviewFilter.responded),
          ],
        ),
      ),
    );
  }
}

enum ReviewFilter { all, unread, responded }
