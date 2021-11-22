import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';

import '../../domain/domain.dart';

part 'user_account_state.g.dart';

@CopyWith()
class UserAccountState extends Equatable {
  final bool isLoading;
  final String? errorMessage;
  final List<OrderEntity>? orders;

  const UserAccountState({
    this.isLoading = false,
    this.orders,
    this.errorMessage,
  });

  @override
  List<Object?> get props => [
        isLoading,
        orders,
        errorMessage,
      ];
}
