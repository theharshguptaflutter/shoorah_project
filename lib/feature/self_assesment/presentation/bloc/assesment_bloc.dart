import 'dart:async';

import 'package:bloc_test/core/usecase/usecase.dart';
import 'package:bloc_test/feature/self_assesment/data/model/category_model.dart';
import 'package:bloc_test/feature/self_assesment/domain/usecase/get_all_category.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'assesment_event.dart';
part 'assesment_state.dart';

class AssesmentBloc extends Bloc<AssesmentEvent, AssesmentState> {
  AssesmentBloc({required GetAllCategory getAllCategory})
      : _getImages = getAllCategory,
        super(AssesmentInitial()) {
    on<AssesmentEvent>((event, emit) {});
    on<GetCategory>(
      getCategory,
    );
  }

  FutureOr<void> getCategory(event, emit) async{
    emit(AssesmentLoading());

  try {
    final value = await _getImages(NoParams());
    emit(AssesmentLoaded(value));
  } catch (e) {
    emit(AssesmentErrorState(e.toString()));
  }
// try {
//    _getImages(NoParams()).then((value) {
//       emit(AssesmentLoaded(value));
//     });
// } catch (e) {
//   emit(AssesmentErrorState(e.toString()));
// }
   
  }

  final GetAllCategory _getImages;
}
