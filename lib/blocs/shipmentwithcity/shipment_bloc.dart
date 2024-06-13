import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_kundol/blocs/shipmentwithcity/shipment_event.dart';
import 'package:flutter_kundol/blocs/shipmentwithcity/shipment_state.dart';
import 'package:flutter_kundol/constants/app_constants.dart';
import 'package:flutter_kundol/constants/app_data.dart';
import 'package:flutter_kundol/models/user.dart';
import 'package:flutter_kundol/repos/auth_repo.dart';
import 'package:flutter_kundol/tweaks/shared_pref_service.dart';

import '../../repos/shipmentcity_repo.dart';

class ShipmentBloc extends Bloc<ShipmentEvent, ShipmentState> {
  final CityRepo shipmentRepo;

  ShipmentBloc(this.shipmentRepo) : super(const ShipmentInitial());

  @override
  Stream<ShipmentState> mapEventToState(ShipmentEvent event) async* {
    if (event is Shipments) {
      try {
        final shipmentResponse =
        await shipmentRepo.getShipment(event.city);
        if (shipmentResponse.status == AppConstants.STATUS_SUCCESS &&
            shipmentResponse.shippingCost != null)
          {  print("data isnfounf");
            yield ShipmentLoaded(shipmentResponse);}
          // ShipmentLoading(shipmentResponse.shippingCost);
        else
      //  yield null!;
          yield ShipmentLoaded(shipmentResponse);
      } on Error {
        yield ShipmentError("Some Error");
      }
    }
  }
}