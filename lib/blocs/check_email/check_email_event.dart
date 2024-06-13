


abstract class EmailEvent {}

class CheckEmail extends EmailEvent {
  final String email;

  CheckEmail({required this.email});
}
