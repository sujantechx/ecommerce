abstract class OrderState {}

class OrderInitial extends OrderState {}

class OrderPlacing extends OrderState {} // For showing a loading indicator

class OrderPlacedSuccess extends OrderState {} // On success

class OrderPlacedFailure extends OrderState {
  final String errorMessage;
  OrderPlacedFailure({required this.errorMessage});
}