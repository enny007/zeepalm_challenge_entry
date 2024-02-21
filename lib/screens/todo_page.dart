import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:zeepalm_challenge_entry/components/side_menu.dart';
import 'package:zeepalm_challenge_entry/components/text_widget.dart';
import 'package:zeepalm_challenge_entry/screens/todo_page_body.dart';
import 'package:zeepalm_challenge_entry/utils/colors.dart';
import 'package:zeepalm_challenge_entry/utils/responsive.dart';

class TodoPage extends ConsumerWidget {
  final GlobalKey<ScaffoldState> _todoScaffoldKey = GlobalKey<ScaffoldState>();
  TodoPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dimension = MediaQuery.sizeOf(context);
    return Scaffold(
      key: _todoScaffoldKey,
      drawer: const Drawer(
        elevation: 0,
        child: SideMenu(),
      ),
      body: Column(
        children: [
          Container(
            height: 60,
            width: dimension.width,
            padding: const EdgeInsets.symmetric(
              horizontal: 30,
            ),
            decoration: BoxDecoration(
              color: Theme.of(context).brightness == Brightness.light
                  ? AppColors.primaryColor
                  : AppColors.primaryColor,
            ),
            child: Row(
              children: [
                Responsive.isMobile(context)
                    ? Padding(
                        padding: const EdgeInsets.only(
                          right: 40,
                        ),
                        child: IconButton(
                          onPressed: () {
                            openDrawer();
                          },
                          icon: const Icon(
                            Icons.menu,
                            size: 32,
                            color: Colors.white,
                          ),
                        ),
                      )
                    : Responsive.isTablet(context)
                        ? Padding(
                            padding: const EdgeInsets.only(
                              right: 40,
                            ),
                            child: IconButton(
                              onPressed: () {
                                openDrawer();
                              },
                              icon: const Icon(
                                Icons.menu,
                                size: 32,
                                color: Colors.white,
                              ),
                            ),
                          )
                        : const SizedBox.shrink(),
                const Icon(
                  Icons.note_alt_sharp,
                  color: Colors.white,
                ),
                const Gap(5),
                const TextWidget(
                  text: 'Todo Daily',
                  fontWeight: FontWeight.w400,
                  fontsize: 25,
                  color: Colors.white,
                ),
              ],
            ),
          ),
          const Responsive(
            mobile: Expanded(
              flex: 3,
              child: TodoPageBody(),
            ),
            tablet: Expanded(
              flex: 3,
              child: TodoPageBody(),
            ),
            desktop: Expanded(
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: SideMenu(),
                  ),
                  Gap(10),
                  Expanded(
                    flex: 3,
                    child: TodoPageBody(),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void openDrawer() {
    if (!_todoScaffoldKey.currentState!.isDrawerOpen) {
      _todoScaffoldKey.currentState!.openDrawer();
    }
  }
}
