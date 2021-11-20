// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_state.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

extension AppStateCopyWith on AppState {
  AppState copyWith({
    CartEntity? cart,
    UserEntity? currentUser,
    String? errorMessage,
    bool? isLoading,
    List<ProductEntity>? products,
  }) {
    return AppState(
      cart: cart ?? this.cart,
      currentUser: currentUser ?? this.currentUser,
      errorMessage: errorMessage ?? this.errorMessage,
      isLoading: isLoading ?? this.isLoading,
      products: products ?? this.products,
    );
  }
}
