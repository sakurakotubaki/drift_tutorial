// import 'package:drift_tutorial/presentation/pages/delete_todo_page.dart';
// import 'package:drift_tutorial/presentation/pages/todo_list_page.dart';
// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';

// part 'bottom_navigation_widget.g.dart';

// @TypedStatefulShellRoute<MyShellRouteData>(
//   branches: <TypedStatefulShellBranch<StatefulShellBranchData>>[
//     TypedStatefulShellBranch<BranchAData>(
//       routes: <TypedRoute<RouteData>>[
//         TypedGoRoute<DetailsARouteData>(path: '/todo'),
//       ],
//     ),
//     TypedStatefulShellBranch<BranchBData>(
//       routes: <TypedRoute<RouteData>>[
//         TypedGoRoute<DetailsBRouteData>(path: '/delete'),
//       ],
//     ),
//   ],
// )
// class MyShellRouteData extends StatefulShellRouteData {
//   const MyShellRouteData();

//   @override
//   Widget builder(
//     BuildContext context,
//     GoRouterState state,
//     StatefulNavigationShell navigationShell,
//   ) {
//     return navigationShell;
//   }

//   static const String $restorationScopeId = 'restorationScopeId';

//   static Widget $navigatorContainerBuilder(BuildContext context,
//       StatefulNavigationShell navigationShell, List<Widget> children) {
//     return ScaffoldWithBottomNavigationBar(
//       child: navigationShell,
//       tabs: const [
//         ScaffoldWithNavigationBarTabItem(
//           initialLocation: '/todo',
//           icon: Icon(Icons.home),
//           label: 'Todo List',
//         ),
//         ScaffoldWithNavigationBarTabItem(
//           initialLocation: '/delete',
//           icon: Icon(Icons.work),
//           label: 'Delete Todo',
//         ),
//       ],
//     );
//   }
// }

// class BranchAData extends StatefulShellBranchData {
//   const BranchAData();
// }

// class BranchBData extends StatefulShellBranchData {
//   const BranchBData();

//   static final GlobalKey<NavigatorState> $navigatorKey = _sectionANavigatorKey;
//   static const String $restorationScopeId = 'restorationScopeId';
// }

// class TodoListPageRouteData extends GoRouteData {
//   const TodoListPageRouteData();

//   @override
//   Widget build(BuildContext context, GoRouterState state) {
//     return const TodoListPage();
//   }
// }

// class DeleteTodoPageRouteData extends GoRouteData {
//   const DeleteTodoPageRouteData();

//   @override
//   Widget build(BuildContext context, GoRouterState state) {
//     return const DeleteTodoPage();
//   }
// }

// class ScaffoldWithBottomNavigationBar extends StatelessWidget {
//   const ScaffoldWithBottomNavigationBar({
//     required this.child,
//     required this.tabs,
//     super.key,
//   });

//   final Widget child;
//   final List<ScaffoldWithNavigationBarTabItem> tabs;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: child,
//       bottomNavigationBar: BottomNavigationBar(
//         items: tabs
//             .map(
//               (tab) => BottomNavigationBarItem(
//                 icon: tab.icon,
//                 label: tab.label,
//               ),
//             )
//             .toList(),
//         currentIndex: _calculateSelectedIndex(context),
//         onTap: (int idx) => _onItemTapped(idx, context),
//         selectedItemColor: Colors.blue[800],
//       ),
//     );
//   }

//   int _calculateSelectedIndex(BuildContext context) {
//     final String location = GoRouterState.of(context).location;
//     final int index =
//         tabs.indexWhere((tab) => location.startsWith(tab.initialLocation));
//     return index < 0 ? 0 : index;
//   }

//   void _onItemTapped(int index, BuildContext context) {
//     if (index != _calculateSelectedIndex(context)) {
//       context.go(tabs[index].initialLocation);
//     }
//   }
// }

// class ScaffoldWithNavigationBarTabItem {
//   const ScaffoldWithNavigationBarTabItem({
//     required this.initialLocation,
//     required this.icon,
//     required this.label,
//   });

//   final String initialLocation;
//   final Icon icon;
//   final String label;
// }
