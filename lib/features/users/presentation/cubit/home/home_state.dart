part of 'home_cubit.dart';

class HomeState extends Equatable {
  final HomeFilterOption filterOption;

  const HomeState({this.filterOption = HomeFilterOption.all});

  // States

  factory HomeState.initial() => const HomeState();

  HomeState copyWith({
    HomeFilterOption? filterOption,
  }) =>
      HomeState(
        filterOption: filterOption ?? this.filterOption,
      );

  @override
  List<Object?> get props => [
        filterOption,
      ];
}
