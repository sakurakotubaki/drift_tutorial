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

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$routerHash() => r'da37d32f3c733ab8b6e2ce4bb1c5f2cf75658804';

/// See also [router].
@ProviderFor(router)
final routerProvider = AutoDisposeProvider<GoRouter>.internal(
  router,
  name: r'routerProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$routerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef RouterRef = AutoDisposeProviderRef<GoRouter>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
