import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:zeepalm_challenge_entry/components/animated_floating_action_button.dart';
import 'package:zeepalm_challenge_entry/components/text_widget.dart';
import 'package:zeepalm_challenge_entry/providers/todo_form_provider.dart';
import 'package:zeepalm_challenge_entry/providers/todos_list_provider.dart';
import 'package:zeepalm_challenge_entry/providers/ui_providers.dart';
import 'package:zeepalm_challenge_entry/utils/colors.dart';
import 'package:zeepalm_challenge_entry/utils/edge_insets_extensions.dart';

class TodoPageBody extends ConsumerStatefulWidget {
  const TodoPageBody({
    super.key,
  });
  @override
  ConsumerState<TodoPageBody> createState() => _TodoPageBodyState();
}

class _TodoPageBodyState extends ConsumerState<TodoPageBody>
    with SingleTickerProviderStateMixin {
  late AnimationController fabAnimationController;
  @override
  void initState() {
    super.initState();
    fabAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    fabAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final fabKey = ref.watch(todoPageFabProvider);
    final provider = ref.read(taskDialogProvider(ref).notifier);
    final isCategorized = ref.read(isCategorizedProvider);
    final category = ref.watch(selectedCategoryProvider);
    final todoList = isCategorized
        ? ref.watch(todoListProvider.notifier).getFilteredTodos(category)
        : ref.watch(todoListProvider);
    return Scaffold(
      // key: widget.scaffoldKey,
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsetsExtension.fromPercentage(
          lefthorizontalPercentage: 53,
          righthorizontalPercentage: 53,
          topverticalPercentage: 70,
          bottomverticalPercentage: 20,
          context: context,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextWidget(
              text: isCategorized ? category : 'All Tasks',
              fontWeight: FontWeight.bold,
              fontsize: 31,
            ),
            const Gap(30),
            if (todoList.isEmpty)
              const Center(
                child: TextWidget(
                  text:
                      'No todo entry yet\nClick the floating button to add entries',
                  fontWeight: FontWeight.w500,
                  fontsize: 25,
                  color: Colors.black,
                  textAlign: TextAlign.center,
                ),
              )
            else
              Expanded(
                child: ListView.builder(
                  itemCount: todoList.length,
                  itemBuilder: (context, index) {
                    var todo = todoList[index];
                    return Card(
                      elevation: 5,
                      shadowColor: Colors.grey,
                      margin: const EdgeInsets.only(
                        top: 20,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                const Gap(30),
                                Expanded(
                                  flex: 3,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      TextWidget(
                                        text: todo.title ?? '',
                                        fontWeight: FontWeight.normal,
                                        fontsize: 18,
                                      ),
                                      const Gap(5),
                                      TextWidget(
                                        text: todo.description ?? '',
                                        fontWeight: FontWeight.normal,
                                        fontsize: 18,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Row(
                            children: [
                              IconButton(
                                onPressed: () {
                                  ref
                                      .read(todoFormProvider.notifier)
                                      .load(todo);
                                  provider.showTaskDialog(isUpdate: true);
                                },
                                icon: const Icon(Icons.edit_document),
                              ),
                              const Gap(5),
                              IconButton(
                                icon: const Icon(Icons.delete),
                                color: AppColors.primaryColor,
                                onPressed: () {
                                  ref
                                      .read(todoListProvider.notifier)
                                      .removeTodoAt(todo);
                                  ref
                                      .read(todoListProvider.notifier)
                                      .handleCategoryTap(ref, 'all');
                                },
                              ),
                            ],
                          ),
                          const Gap(30),
                        ],
                      ),
                    );
                  },
                ),
              ),
          ],
        ),
      ),
      floatingActionButton: AnimatedFloatingActionButton(
        key: fabKey,
        icon: Icons.add,
        animationDuration: const Duration(milliseconds: 800),
        animationCurve: Curves.easeInOut,
        onPressed: () {
          provider.showTaskDialog();
        },
      ),
    );
  }
}
