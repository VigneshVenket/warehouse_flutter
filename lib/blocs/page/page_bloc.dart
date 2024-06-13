import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_kundol/api/responses/get_page_response.dart';
import 'package:flutter_kundol/constants/app_constants.dart';
import 'package:flutter_kundol/repos/pages_repo.dart';

part 'page_event.dart';

part 'page_state.dart';

class GetPageBloc extends Bloc<PageEvent, PageState> {

  PageRepo pageRepo;

  GetPageBloc(this.pageRepo) : super(GetPageInitial());

  @override
  Stream<PageState> mapEventToState(PageEvent event) async* {
    if (event is GetPage) {
      try {
        final pageResponse = await pageRepo.getPages(event.pageNo);
        if (pageResponse.status == AppConstants.STATUS_SUCCESS &&
            pageResponse.data != null) {
          yield GetPageLoaded(pageResponse);
        } else {
          yield GetPageError(pageResponse.message!);
        }
      } on Error {
        yield const GetPageError("Couldn't fetch weather. Is the device online?");
      }
    }
  }
}
