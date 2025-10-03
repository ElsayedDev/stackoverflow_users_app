/// {@template create_test_without_params_use_case}
/// A use case that performs an asynchronous operation without any input parameters,
/// returning a [String] result after a simulated delay.
///
/// ### Example
/// ```dart
/// final useCase = CreateTestWithoutParamsUseCase();
/// final result = await useCase();
/// print(result); // Output: Test Result
/// ```
/// {@endtemplate}
///
/// {@template create_test_with_params_use_case}
/// A use case that performs an asynchronous operation with a [String] parameter,
/// returning a [String] result after a simulated delay.
///
/// ### Example
/// ```dart
/// final useCase = CreateTestWithParamsUseCase();
///
/// // first way to call the use case
/// // final result = await useCase('example');
///
/// // // second way to call the use case
/// final result = await useCase.call('example');
///
/// // third way to call the use case
/// final useCase2 = CreateTestWithParamsUseCase()("example");
/// print(result); // Output: Test Result with params: example
/// ```
/// {@endtemplate}
///
/// {@template model_x}
/// A placeholder model class used for demonstration purposes in use cases.
/// {@endtemplate}
///
/// {@template create_test_with_model_use_case}
/// A use case that performs an asynchronous operation with a [ModelX] parameter,
/// returning a [String] result after a simulated delay.
///
/// ### Example1
/// ```dart
/// final useCase = CreateTestWithModelUseCase();
/// final model = ModelX();
/// final result = await useCase(model);
/// print(result); // Output: Test Result with model: Instance of 'ModelX'
/// ```
/// {@endtemplate}
///
/// {@template create_new_use_case}
/// ## How to create a new use case
///
/// 1. Extend the [UseCase] class, specifying the output and parameter types.
/// 2. Implement the [call] method with your business logic.
///
/// ### Example
/// ```dart
/// class MyCustomUseCase extends UseCase<int, double> {
///   @override
///   Future<int> call(double params) async {
///     // Your custom logic here
///     await Future.delayed(Duration(milliseconds: 500));
///     return params.toInt();
///   }
/// }
///
/// // Usage:
/// final useCase = MyCustomUseCase();
/// final result = await useCase(42.7);
/// print(result); // Output: 42
/// ```
/// ### Example2
/// ```dart
/// class MyCustomUseCase extends UseCase<String, NoParams> {
///  @override
/// Future<String> call([NoParams params]) async {
///    // Your custom logic here
///   await Future.delayed(Duration(milliseconds: 500));
///   return 'Hello, World!';
/// /// }
/// /// // Usage:
/// final useCase = MyCustomUseCase();
/// final result = await useCase();
/// print(result); // Output: Hello, World!
/// ```
/// {@endtemplate}
abstract interface class UseCase<Output extends Object?, Params> {
  Output call(Params params);
}
