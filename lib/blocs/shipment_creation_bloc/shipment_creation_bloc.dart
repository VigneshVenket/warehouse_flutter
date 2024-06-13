
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_kundol/blocs/shipment_creation_bloc/shipment_creation_event.dart';
import 'package:flutter_kundol/blocs/shipment_creation_bloc/shipment_creation_state.dart';
import 'package:flutter_kundol/repos/shipment_creation_repo.dart';

class ShipmentCreateBloc extends Bloc<ShipmentCreateEvent, ShipmentCreateState> {
  final ShipmentCreationRepo shipmentCreationRepo;

  ShipmentCreateBloc(this.shipmentCreationRepo) : super(ShipmentCreateInitialState());


  @override
  Stream<ShipmentCreateState> mapEventToState(ShipmentCreateEvent event) async* {
    if (event is PostShipmentCreateEvent) {
      yield ShipmentCreateLoadingState();
      try {
        final shipmentCreateResponse = await shipmentCreationRepo.shipmentCreation(event.shipmentCreateData);
        yield ShipmentCreateSuccessState(response:shipmentCreateResponse);
      } catch (error) {
        yield ShipmentCreateErrorState(error: 'Failed to post shipmentCreate');
      }
    }
  }

}