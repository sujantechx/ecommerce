import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/remote/repository/order_repository.dart';
import 'order_event.dart';
import 'order_state.dart';


class OrderBloc extends Bloc<OrderEvent, OrderState> {
  final OrderRepository orderRepository;

  OrderBloc({required this.orderRepository}) : super(OrderInitial()) {
    on<PlaceOrderEvent>((event, emit) async {
      emit(OrderPlacing()); // Notify UI that we are starting
      try {
        final response = await orderRepository.createOrder(
          userId: event.userId,
          productIds: event.productIds,
        );

        if (response['status'] == true) {
          emit(OrderPlacedSuccess());
        } else {
          emit(OrderPlacedFailure(errorMessage: response['message'] ?? 'Failed to place order.'));
        }
      } catch (e) {
        emit(OrderPlacedFailure(errorMessage: e.toString()));
      }
    });
  }
}