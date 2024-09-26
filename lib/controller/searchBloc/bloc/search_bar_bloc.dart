import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'search_bar_event.dart';
part 'search_bar_state.dart';

class SearchBarBloc extends Bloc<SearchBarEvent, SearchBarState> {
  SearchBarBloc() : super(SearchBarHidden()) {
    on<ToggleSearchBar>((event, emit) {
      if (state is SearchBarHidden) {
        emit(SearchBarVisible());
      } else {
        emit(SearchBarHidden());
      }
    });
  }
}
