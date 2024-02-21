import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:lottie/lottie.dart';
import 'package:zeepalm_challenge_entry/components/text_widget.dart';
import 'package:zeepalm_challenge_entry/providers/todos_list_provider.dart';
import 'package:zeepalm_challenge_entry/providers/ui_providers.dart';
import 'package:zeepalm_challenge_entry/utils/colors.dart';

class SideMenu extends ConsumerWidget {
  const SideMenu({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todoList = ref.watch(todoListProvider);
    final Set<String> categories = {};
    for (var element in todoList) {
      categories.add(element.category!);
    }
    return Container(
      color: Colors.white,
      alignment: Alignment.center,
      child: Column(
        children: [
          const Gap(20),
          Lottie.asset(
            'assets/animations/welcome.json',
          ),
          const Gap(50),
          InkWell(
            splashFactory: NoSplash.splashFactory,
            onTap: () {
              ref.read(todoListProvider.notifier).handleCategoryTap(ref, 'all');
            },
            child: TextWidget(
              text: 'View All Todos',
              fontWeight: FontWeight.bold,
              fontsize: 31,
              color: _getCategoryColor(ref, 'all'),
            ),
          ),
          const Gap(20),
          ListView.builder(
            shrinkWrap: true,
            itemCount: categories.length,
            itemBuilder: (context, index) {
              final uniqueCategory = categories.elementAt(index);
              return InkWell(
                splashFactory: NoSplash.splashFactory,
                onTap: () {
                  ref
                      .read(todoListProvider.notifier)
                      .handleCategoryTap(ref, uniqueCategory);
                },
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.only(
                      top: 20,
                    ),
                    child: TextWidget(
                      text: uniqueCategory,
                      fontWeight: FontWeight.bold,
                      fontsize: 31,
                      color: _getCategoryColor(ref, uniqueCategory),
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Color _getCategoryColor(
    WidgetRef ref,
    String category,
  ) {
    final activeCategories = ref.watch(activeCategoriesProvider);

    return activeCategories.containsKey(category) && activeCategories[category]!
        ? AppColors.primaryColor
        : Colors.black;
  }
}
