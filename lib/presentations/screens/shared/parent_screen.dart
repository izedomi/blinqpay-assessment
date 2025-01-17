import 'package:blinqpay/view_models/shared/tabs_view_model.dart';
import 'package:blinqpay/presentations/shared/utils/space.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ParentScreen extends StatefulWidget {
  const ParentScreen({super.key});

  @override
  State<ParentScreen> createState() => _ParentScreenState();
}

class _ParentScreenState extends State<ParentScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<TabsViewModel>(builder: (context, vm, _) {
      return Scaffold(
        // body: PopScope(
        //   canPop: false,
        //   onPopInvoked: (value) {
        //     dLog(value);
        //   },
        //   child: vm.screens[vm.currentIndex],
        // ),
        body: IndexedStack(
          index: vm.currentIndex,
          children: vm.screens,
        ),
        bottomNavigationBar: Container(
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(40)),
            color: Theme.of(context).bottomNavigationBarTheme.backgroundColor,
          ),
          child: BottomNavigationBar(
              elevation: 10,
              showUnselectedLabels: true,
              unselectedLabelStyle: TextStyle(
                fontSize: fs(12),
              ),
              selectedLabelStyle: TextStyle(
                fontSize: fs(12),
              ),
              currentIndex: vm.currentIndex,
              onTap: (index) => vm.updateIndex(
                    index,
                  ),
              type: BottomNavigationBarType.fixed,
              items: vm.bottomNav
                  .map((data) => BottomNavigationBarItem(
                      icon: data.icon, activeIcon: data.icon, label: data.name))
                  .toList()),
        ),
      );
    });
  }
}
