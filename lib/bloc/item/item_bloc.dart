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
    on<AddItem>((event, emit) async {
      emit(ItemLoading());
      try {
        await _itemRepo.addItem(
          event.name,
          event.productId,
          event.price,
          event.image,
        );
        emit(AddItemSuccess());
        add(GetItem(productId: event.productId));
      } catch (e) {
        emit(ItemError());
      }
    });
    on<EditItem>((event, emit) async {
      emit(ItemLoading());
      try {
        await _itemRepo.editItem(
          event.itemId,
          event.name,
          event.productId,
          event.price,
          event.image,
        );
        emit(EditItemSuccess());
        add(GetItem(productId: event.productId));
      } catch (e) {
        emit(ItemError());
      }
    });
    on<DeleteItem>((event, emit) async {
      emit(ItemLoading());
      try {
        await _itemRepo.deleteItem(event.itemId);
        emit(DeleteItemSuccess());
        add(GetItem(productId: event.productId));
      } catch (e) {
        emit(ItemError());
      }
    });
  }
}
