import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';

part 'login_state.g.dart';

@CopyWith()
class LoginState extends Equatable {
  final bool isLoading;
  final String? errorMessage;
  final bool completed;

  const LoginState({
    this.isLoading = false,
    this.errorMessage,
    this.completed = false,
  });

  @override
  List<Object?> get props => [isLoading, completed, errorMessage];
}
