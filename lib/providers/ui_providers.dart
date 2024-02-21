import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:zeepalm_challenge_entry/components/my_textfield.dart';
import 'package:zeepalm_challenge_entry/components/text_widget.dart';
import 'package:zeepalm_challenge_entry/providers/todo_form_provider.dart';
import 'package:zeepalm_challenge_entry/providers/todos_list_provider.dart';
import 'package:zeepalm_challenge_entry/utils/colors.dart';
import 'package:zeepalm_challenge_entry/utils/extensions.dart';

final fabKeyProvider = StateProvider<GlobalKey>((ref) {
  return GlobalKey();
});
final todoPageFabProvider = StateProvider<GlobalKey>((ref) {
  return GlobalKey();
});

//Dialog notifier
final taskDialogProvider =
    StateNotifierProvider.family<TaskDialogNotifier, bool, WidgetRef>(
        (ref, widgetRef) {
  return TaskDialogNotifier(widgetRef);
});

class TaskDialogNotifier extends StateNotifier<bool> {
  final WidgetRef ref;
  TaskDialogNotifier(
    this.ref,
  ) : super(false);

  Future<void> showTaskDialog({bool isUpdate = false}) async {
    final formProvider = ref.watch(todoFormProvider.notifier);
    final dimension = MediaQuery.sizeOf(ref.context);
    await showDialog(
      context: ref.context,
      builder: (context) {
        return Center(
          child: Material(
            borderRadius: BorderRadius.circular(7),
            child: Container(
              width: 638,
              height: 680,
              padding: const EdgeInsets.only(
                top: 50,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(7),
                color: AppColors.primaryColor.withOpacity(0.4),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 50,
                    spreadRadius: 0,
                    offset: const Offset(0, 4),
                    color: const Color(0xff9DB6CF).withOpacity(0.20),
                  ),
                ],
              ),
              child: Form(
                key: formProvider.formKey,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 30,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      MyTextField(
                        controller: formProvider.titleController,
                        hint: 'Grocery Shopping',
                        title: 'Name',
                        validator: formProvider.nameValidator,
                      ),
                      const Gap(20),
                      MyTextField(
                        controller: formProvider.descriptionController,
                        hint: 'Grocery Shopping with the family',
                        title: 'Description',
                        maxlines: 3,
                        validator: formProvider.descriptionValidator,
                      ),
                      const Gap(20),
                      MyTextField(
                        controller: formProvider.categoryController,
                        hint: 'Grocery',
                        title: 'Category',
                        isEnabled: !isUpdate,
                        validator: formProvider.categoryValidator,
                      ),
                      const Gap(20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const TextWidget(
                            text: 'Status',
                            fontWeight: FontWeight.w500,
                            fontsize: 20,
                          ),
                          const Gap(10),
                          Padding(
                            padding: EdgeInsets.only(
                              right: dimension.width * 0.25,
                            ),
                            child: DropdownButtonFormField<TodoStatus>(
                              value: formProvider.getTodoStatus(),
                              elevation: 0,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.zero,
                                fillColor: Colors.transparent,
                                focusColor: Colors.transparent,
                              ),
                              onChanged: (TodoStatus? newValue) {
                                formProvider.setTodoStatus(newValue);
                              },
                              items: TodoStatus.values.map((TodoStatus status) {
                                return DropdownMenuItem<TodoStatus>(
                                  value: status,
                                  child: Row(
                                    children: [
                                      // Add a colored circle to represent the status
                                      Container(
                                        width: 20,
                                        height: 20,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: status.displayColor,
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      Text(status.displayText),
                                    ],
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        ],
                      ),
                      const Gap(30),
                      Align(
                        alignment: Alignment.centerRight,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                AppColors.primaryColor.withOpacity(0.4),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 20,
                            ),
                          ),
                          onPressed: () {
                            formProvider.submit(ref, isUpdate: isUpdate);
                            state = false;
                            ref
                                .read(todoListProvider.notifier)
                                .handleCategoryTap(ref, 'all');
                          },
                          child: TextWidget(
                            text: isUpdate ? 'Update' : 'Submit',
                            fontWeight: FontWeight.w400,
                            fontsize: 20,
                            color: const Color(0xff313131),
                          ),
                        ),
                      ),
                      const Gap(10),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
    formProvider.clear();
  }
}

final isCategorizedProvider = StateProvider<bool>((ref) {
  return false;
});

final selectedCategoryProvider = StateProvider<String>((ref) {
  return '';
});

//Active color notifier in the sideMenu
final activeCategoriesProvider =
    StateNotifierProvider<ActiveCategoriesProvider, Map<String, bool>>(
        (ref) => ActiveCategoriesProvider({}));

class ActiveCategoriesProvider extends StateNotifier<Map<String, bool>> {
  ActiveCategoriesProvider(Map<String, bool> initialState)
      : super(initialState);

  void toggleCategory(String category) {
    state = Map<String, bool>.from(state)
      ..clear()
      ..[category] = true;
  }
}



