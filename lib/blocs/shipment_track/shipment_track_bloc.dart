

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_kundol/blocs/shipment_track/shipment_track_event.dart';
import 'package:flutter_kundol/blocs/shipment_track/shipment_track_state.dart';
import 'package:flutter_kundol/repos/shipment_track_repo.dart';

class ShipmentTrackBloc extends Bloc<ShipmentTrackEvent, ShipmentTrackState> {

  final ShipmentTrackRepo shipmentTrackRepo;

  ShipmentTrackBloc(this.shipmentTrackRepo) : super(ShipmentTrackInitial());

  @override
  Stream<ShipmentTrackState> mapEventToState(ShipmentTrackEvent event) async* {
    if (event is FetchShipmentTrack) {
      yield ShipmentTrackLoading();
      try {
        final response = await shipmentTrackRepo.getShipmentTrack(event.waybill);
        yield ShipmentTrackLoaded(shipmentTrack: response.shipmentData!);
      } catch (e) {
        yield ShipmentTrackError(
            errorMessage: e.toString());
      }
    }
  }
  }