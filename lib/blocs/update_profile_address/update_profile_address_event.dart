

import 'package:equatable/equatable.dart';

abstract class UpdateProfileAddressEvent extends Equatable {
  const UpdateProfileAddressEvent();
}


class UpdateProfileAddress extends UpdateProfileAddressEvent {
  final int id;
  final String firstName;
  final String lastName;
  final String gender;
  final String dob;
  final String lat;
  final String long;
  final String phone;


  const UpdateProfileAddress(
      this.id,
      this.firstName,
      this.lastName,
      this.gender,
      this.dob,
      this.lat,
      this.long,
      this.phone);

  @override
  List<Object> get props => [
    id,
    firstName,
    lastName,
    gender,
    dob,
    lat,
    long,
    phone
  ];
}