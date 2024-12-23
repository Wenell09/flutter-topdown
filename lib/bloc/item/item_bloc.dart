import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:topdown_store/data/model/item_model.dart';
import 'package:topdown_store/repository/item_repo.dart';

part 'item_event.dart';
part 'item_state.dart';

class ItemBloc extends Bloc<ItemEvent, ItemState> {
  final ItemRepo _itemRepo;
  ItemBloc(this._itemRepo) : super(ItemInitial()) {
    on<GetItem>((event, emit) async {
      emit(ItemLoading());
      try {
        final item = await _itemRepo.getItem(event.productId);
        emit(ItemLoaded(item: item));
      } catch (e) {
        emit(ItemError());
      }
    });
  }
}
