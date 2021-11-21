import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';

part 'cart_state.g.dart';

@CopyWith()
class CartState extends Equatable {
  final bool isLoading;
  final String? errorMessage;
  final String? successMessage;
  final String? orderReceiptPath;

  const CartState({
    this.isLoading = false,
    this.errorMessage,
    this.successMessage,
    this.orderReceiptPath,
  });

  @override
  List<Object?> get props => [
        isLoading,
        errorMessage,
        successMessage,
        orderReceiptPath,
      ];
}
