// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'router.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [
      $myShellRouteData,
      $createTodoRoute,
    ];

RouteBase get $myShellRouteData => StatefulShellRouteData.$route(
      restorationScopeId: MyShellRouteData.$restorationScopeId,
      navigatorContainerBuilder: MyShellRouteData.$navigatorContainerBuilder,
      factory: $MyShellRouteDataExtension._fromState,
      branches: [
        StatefulShellBranchData.$branch(
          routes: [
            GoRouteData.$route(
              path: '/todo',
              name: 'TodoList',
              factory: $TodoListRouteExtension._fromState,
              routes: [
                GoRouteData.$route(
                  path: 'create',
                  name: 'CreateTodo',
                  factory: $CreateTodoRouteExtension._fromState,
                ),
              ],
            ),
          ],
        ),
        StatefulShellBranchData.$branch(
          navigatorKey: BranchBData.$navigatorKey,
          restorationScopeId: BranchBData.$restorationScopeId,
          routes: [
            GoRouteData.$route(
              path: '/delete',
              name: 'DeleteTodo',
              factory: $DeleteTodoRouteExtension._fromState,
            ),
          ],
        ),
      ],
    );

extension $MyShellRouteDataExtension on MyShellRouteData {
  static MyShellRouteData _fromState(GoRouterState state) =>
      const MyShellRouteData();
}

extension $TodoListRouteExtension on TodoListRoute {
  static TodoListRoute _fromState(GoRouterState state) => const TodoListRoute();

  String get location => GoRouteData.$location(
        '/todo',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $CreateTodoRouteExtension on CreateTodoRoute {
  static CreateTodoRoute _fromState(GoRouterState state) =>
      const CreateTodoRoute();

  String get location => GoRouteData.$location(
        '/todo/create',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $DeleteTodoRouteExtension on DeleteTodoRoute {
  static DeleteTodoRoute _fromState(GoRouterState state) =>
      const DeleteTodoRoute();

  String get location => GoRouteData.$location(
        '/delete',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $createTodoRoute => GoRouteData.$route(
      path: '/todo/create',
      factory: $CreateTodoRouteExtension._fromState,
    );
