

import 'package:equatable/equatable.dart';

abstract class UserEvent extends Equatable {
  const  UserEvent();
}

class UpdateUser extends UserEvent {

  final String firstName;
  final String lastName;

  const UpdateUser(this.firstName, this.lastName);

  @override
  List<Object> get props => [firstName, lastName];
}