import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';

import '../../domain/domain.dart';

part 'app_state.g.dart';

@CopyWith()
class AppState extends Equatable {
  final UserEntity? currentUser;
  final List<ProductEntity>? products;
  final CartEntity? cart;
  final bool isLoading;
  final String? errorMessage;

  const AppState({
    this.isLoading = false,
    this.errorMessage,
    this.currentUser,
    this.products,
    this.cart,
  });

  @override
  List<Object?> get props => [
        isLoading,
        errorMessage,
        currentUser,
        products,
        cart,
      ];
}
