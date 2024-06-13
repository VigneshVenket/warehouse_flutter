
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_kundol/blocs/waybill/waybill_event.dart';
import 'package:flutter_kundol/blocs/waybill/waybill_state%20.dart';
import 'package:flutter_kundol/repos/waybill_repo.dart';

class WaybillBloc extends Bloc<WaybillEvent, WaybillState> {

  final WaybillRepo waybillRepo;

  WaybillBloc(this.waybillRepo):super(WaybillInitialState());


  @override
  WaybillState get initialState => WaybillInitialState();

  @override
  Stream<WaybillState> mapEventToState(WaybillEvent event) async* {
    if (event is FetchWaybillEvent) {
      yield WaybillInitialState();

      try {
        final waybillResponse= await waybillRepo.getWaybill();

        yield WaybillLoadedState(waybillResponse: waybillResponse);

      } catch (e) {
        yield WaybillErrorState(error: 'An error occurred');
      }
    }
  }
}