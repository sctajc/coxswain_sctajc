import 'package:coxswain/screens/about/about.dart';
import 'package:coxswain/screens/help/help.dart';
import 'package:coxswain/screens/import_export/importExport.dart';
import 'package:coxswain/screens/performance/performance_list.dart';
import 'package:coxswain/screens/programs/program_add_edit.dart';
import 'package:coxswain/screens/programs/program_list.dart';
import 'package:coxswain/screens/stretching/stretching.dart';
import 'package:coxswain/screens/user_Level/user_level.dart';
import 'package:coxswain/screens/user_settings/user_settings.dart';
import 'package:coxswain/screens/workouts/workouts_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:coxswain/shared/constants.dart';

class Wrapper extends StatefulWidget {
  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: 3,
      vsync: this,
      initialIndex: 0,
    );
    _tabController.addListener(_handleTabIndex);
  }

  @override
  void dispose() {
    _tabController.removeListener(_handleTabIndex);
    _tabController.dispose();
    super.dispose();
  }

  void _handleTabIndex() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: buildAppBar(),
        body: TabBarView(
          controller: _tabController,
          children: [
            ProgramList(),
            WorkoutList(),
            PerformanceList(),
          ],
        ),
        floatingActionButton: _programsFloatingActionButton(),
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      elevation: 10,
      actions: [
        IconButton(
          icon: Icon(Icons.bluetooth),
          onPressed: () => Get.snackbar(
            'Bluetooth',
            'do Bluetooth stuff',
            snackPosition: SnackPosition.BOTTOM,
          ),
        ),
        IconButton(
          icon: Icon(Icons.sort),
          onPressed: () => Get.snackbar(
            'Sort',
            'do sorting stuff',
            snackPosition: SnackPosition.BOTTOM,
          ),
        ),
        PopupMenuButton(
          color: kColorBlue,
          itemBuilder: (BuildContext context) {
            return [
              PopupMenuItem(
                child: TextButton.icon(
                  label: Text('Settings'),
                  icon: Icon(Icons.settings),
                  onPressed: () => Get.off(() => UserSettings()),
                ),
              ),
              PopupMenuItem(
                child: TextButton(
                  child: Text('Beginners'),
                  onPressed: () => Get.off(() => UserLevel()),
                ),
              ),
              PopupMenuItem(
                child: TextButton(
                  child: Text('Stretching'),
                  onPressed: () => Get.off(() => Stretching()),
                ),
              ),
              PopupMenuItem(
                child: TextButton(
                  child: Text('Import/Export'),
                  onPressed: () => Get.off(() => ImportExport()),
                ),
              ),
              PopupMenuItem(
                child: TextButton(
                  child: Text('Help'),
                  onPressed: () => Get.off(() => Help()),
                ),
              ),
              PopupMenuItem(
                child: TextButton(
                  child: Text('About'),
                  onPressed: () => Get.off(() => About()),
                ),
              ),
            ];
          },
        ),
      ],
      title: Text('Coxswain'),
      bottom: TabBar(
        controller: _tabController,
        tabs: [
          Tab(
            text: 'Programs',
          ),
          Tab(
            text: 'Workouts',
          ),
          Tab(
            text: 'Performance',
          ),
        ],
      ),
    );
  }

  Widget _programsFloatingActionButton() {
    return _tabController.index == 0
        ? FloatingActionButton(
            child: Icon(
              Icons.add,
            ),
            onPressed: () => Get.to(
              ProgramAddEdit(),
            ),
          )
        : SizedBox();
  }
}
