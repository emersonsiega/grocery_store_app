import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';

part 'home_state.g.dart';

@CopyWith()
class HomeState extends Equatable {
  final bool isLoading;
  final String? errorMessage;
  final String? successMessage;

  const HomeState({
    this.isLoading = false,
    this.errorMessage,
    this.successMessage,
  });

  @override
  List<Object?> get props => [
        isLoading,
        errorMessage,
        successMessage,
      ];
}
