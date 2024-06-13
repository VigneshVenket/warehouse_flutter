
part of 'address_bloc.dart';

abstract class AddressEvent extends Equatable {
  const AddressEvent();
}

class GetAddress extends AddressEvent {
  const GetAddress();

  @override
  List<Object> get props => [];
}

class SetDefaultAddress extends AddressEvent {
  final int addressID;
  final String firstName;
  final String lastName;
  final String gender;
  final String company;
  final String streetAddress;
  final String suburb;
  final String postCode;
  final String dob;
//  final String city;
  final int countryId;
  final int state_id;
  final String city;
  final String lat;
  final String lng;
  final int isdefault;
  final String phone;

  const SetDefaultAddress(
      this.addressID,
      this.firstName,
      this.lastName,
      this.gender,
      this.company,
      this.streetAddress,
      this.suburb,
      this.postCode,
      this.dob,
      //  this.city,
      this.countryId,
      this.state_id,
      this.city,
      this.lat,
      this.lng,
      this.isdefault,
      this.phone);

  @override
  List<Object> get props => [
    addressID,
    firstName,
    lastName,
    gender,
    company,
    streetAddress,
    suburb,
    postCode,
    dob,
    city,
    countryId,
    state_id,
    lat,
    lng,
    isdefault,
    phone
  ];
}

class DeleteAddress extends AddressEvent {
  final int addressId;

  const DeleteAddress(this.addressId);

  @override
  List<Object> get props => [addressId];
}