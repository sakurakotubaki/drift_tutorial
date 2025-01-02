import 'package:collection/collection.dart';
import 'package:drift_tutorial/presentation/pages/create_todo_page.dart';
import 'package:drift_tutorial/presentation/pages/delete_todo_page.dart';
import 'package:drift_tutorial/presentation/pages/todo_list_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

part 'router.g.dart';

final GoRouter router = GoRouter(
  routes: $appRoutes,
  initialLocation: '/todo',
);

final GlobalKey<NavigatorState> _sectionANavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'sectionANav');

@TypedStatefulShellRoute<MyShellRouteData>(
  branches: <TypedStatefulShellBranch<StatefulShellBranchData>>[
    TypedStatefulShellBranch<BranchAData>(
      routes: <TypedRoute<RouteData>>[
        TypedGoRoute<TodoListRoute>(
          path: '/todo',
          name: 'TodoList',
          routes: <TypedGoRoute<GoRouteData>>[
            TypedGoRoute<CreateTodoRoute>(
              path: 'create',
              name: 'CreateTodo',
            ),
          ],
        ),
      ],
    ),
    TypedStatefulShellBranch<BranchBData>(
      routes: <TypedRoute<RouteData>>[
        TypedGoRoute<DeleteTodoRoute>(
          path: '/delete',
          name: 'DeleteTodo',
        ),
      ],
    ),
  ],
)
class MyShellRouteData extends StatefulShellRouteData {
  const MyShellRouteData();

  @override
  Widget builder(
    BuildContext context,
    GoRouterState state,
    StatefulNavigationShell navigationShell,
  ) {
    return navigationShell;
  }

  static const String $restorationScopeId = 'restorationScopeId';

  static Widget $navigatorContainerBuilder(BuildContext context,
      StatefulNavigationShell navigationShell, List<Widget> children) {
    return ScaffoldWithNavBar(
      navigationShell: navigationShell,
      children: children,
    );
  }
}

class BranchAData extends StatefulShellBranchData {
  const BranchAData();
}

class BranchBData extends StatefulShellBranchData {
  const BranchBData();

  static final GlobalKey<NavigatorState> $navigatorKey = _sectionANavigatorKey;
  static const String $restorationScopeId = 'restorationScopeId';
}

class TodoListRoute extends GoRouteData {
  const TodoListRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const TodoListPage();
  }
}

// CreateTodoPageのルート定義
@TypedGoRoute<CreateTodoRoute>(
  path: '/todo/create',
)
class CreateTodoRoute extends GoRouteData {
  const CreateTodoRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) => const CreateTodoPage();
}

class DeleteTodoRoute extends GoRouteData {
  const DeleteTodoRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const DeleteTodoPage();
  }
}

class ScaffoldWithNavBar extends StatelessWidget {
  const ScaffoldWithNavBar({
    required this.navigationShell,
    required this.children,
    Key? key,
  }) : super(key: key ?? const ValueKey<String>('ScaffoldWithNavBar'));

  final StatefulNavigationShell navigationShell;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedBranchContainer(
        currentIndex: navigationShell.currentIndex,
        children: children,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.list), label: '表示'),
          BottomNavigationBarItem(icon: Icon(Icons.delete), label: '論理削除'),
        ],
        currentIndex: navigationShell.currentIndex,
        onTap: (int index) => _onTap(context, index),
      ),
    );
  }

  void _onTap(BuildContext context, int index) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }
}

class AnimatedBranchContainer extends StatelessWidget {
  const AnimatedBranchContainer(
      {super.key, required this.currentIndex, required this.children});

  final int currentIndex;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Stack(
        children: children.mapIndexed(
      (int index, Widget navigator) {
        return AnimatedScale(
          scale: index == currentIndex ? 1 : 1.5,
          duration: const Duration(milliseconds: 400),
          child: AnimatedOpacity(
            opacity: index == currentIndex ? 1 : 0,
            duration: const Duration(milliseconds: 400),
            child: _branchNavigatorWrapper(index, navigator),
          ),
        );
      },
    ).toList());
  }

  Widget _branchNavigatorWrapper(int index, Widget navigator) => IgnorePointer(
        ignoring: index != currentIndex,
        child: TickerMode(
          enabled: index == currentIndex,
          child: navigator,
        ),
      );
}
