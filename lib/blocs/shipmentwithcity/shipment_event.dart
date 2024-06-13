

import 'package:equatable/equatable.dart';

abstract class ShipmentEvent extends Equatable {
  const ShipmentEvent();
}

class Shipments extends ShipmentEvent {
  final String city;
  
  const Shipments(this.city, 
      );

  @override
  List<Object> get props => [
    this.city,
    
  ];
}