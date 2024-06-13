


import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_kundol/api/responses/nearest_warehouse_response.dart';
import 'package:flutter_kundol/blocs/nearest_warehouse/warehouse_event.dart';
import 'package:flutter_kundol/blocs/nearest_warehouse/warehouse_state.dart';
import 'package:flutter_kundol/constants/app_constants.dart';
import 'package:flutter_kundol/repos/nearest_warehouse_repo.dart';

import '../../api/api_provider.dart';

class WarehouseBloc extends Bloc<WarehouseEvent, WarehouseState> {

  final WarehouseRepo warehouseRepo;

  WarehouseBloc(this.warehouseRepo):super(WarehouseInitialState());

  // @override
  // WarehouseState get initialState => WarehouseInitialState();

  @override
  Stream<WarehouseState> mapEventToState(WarehouseEvent event) async* {
    if (event is FetchNearestWarehouseEvent) {
      // yield WarehouseInitialState();
      try {
        print("hello");
        final warehouseResponse = await warehouseRepo.getNearestWarehouse(event.address);

        if (warehouseResponse.status == AppConstants.STATUS_SUCCESS && warehouseResponse.data!=null) {
          yield WarehouseLoadedState(warehouse: warehouseResponse.data!);
        } else {
          yield WarehouseErrorState(error: warehouseResponse.message!);
        }
      } catch (e) {
        yield WarehouseErrorState(error: 'An error occurred');
      }
    }
  }
}