import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_kundol/api/responses/product_detail_response.dart';
import 'package:flutter_kundol/api/responses/quantity_response.dart';
import 'package:flutter_kundol/constants/app_constants.dart';
import 'package:flutter_kundol/models/products/product.dart';
import 'package:flutter_kundol/models/quantity_data.dart';
import 'package:flutter_kundol/repos/cart_repo.dart';
import 'package:flutter_kundol/repos/products_repo.dart';

part 'detail_screen_event.dart';

part 'detail_screen_state.dart';

class DetailScreenBloc extends Bloc<DetailPageEvent, DetailPageState> {
  final CartRepo cartRepo;
  final ProductsRepo productsRepo;

  DetailScreenBloc(this.cartRepo, this.productsRepo)
      : super(DetailPageInitial());

  @override
  Stream<DetailPageState> mapEventToState(DetailPageEvent event) async* {
    if (event is GetQuantity) {
      try {
        final response = await cartRepo.checkQuantity(
            event.productId!, event.productType!, event.combinationId);
        if (response.status == AppConstants.STATUS_SUCCESS &&
            response.data != null) {
          yield GetQuantityLoaded(response.data!);
        } else {
          yield DetailPageError(response.message!);
        }
      }catch(error) {
        print('error caught: $error');
        yield DetailPageError("Some Error Occurred");
      }
    } else if (event is AddToCart) {
      try {
        final response = await cartRepo.addToCart(
            event.productId!, event.qty!, event.combinationId);
        if (response.status == AppConstants.STATUS_SUCCESS) {
          yield ItemCartAdded(response.message!, response.data!.session!);
        } else {
          yield DetailPageError(response.message!);
        }
      } catch(error) {
        print('error caught: $error');
        yield DetailPageError("Some Error Occurred");
      }
    } else if (event is GetProductById) {
      //try {
        final response = await productsRepo.fetchProductById(event.productId);
        print("detail page loaded ${response}");
        if (response.status == AppConstants.STATUS_SUCCESS &&
            response.data != null) {
          yield ProductDetailsLoaded(response.data!);
        } else {
          yield DetailPageError(response.message!);
        }
      } 
    //  on Error {
       // yield DetailPageError("Some Error Occurred -----error");
      }
    }
 // }
//}
