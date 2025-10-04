import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stackoverflow_users_app/features/users/presentation/models/home_filter_option.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeState.initial());

  void onFilterOptionChanged(HomeFilterOption option) {
    emit(state.copyWith(filterOption: option));
  }
}
