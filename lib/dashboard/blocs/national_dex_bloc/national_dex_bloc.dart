import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import '../../models/pokemon_national_dex.dart';

part 'national_dex_event.dart';
part 'national_dex_state.dart';

class NationalDexBloc extends Bloc<NationalDexEvent, NationalDexState> {
  NationalDexBloc() : super(NationalDexState()) {
    on<InitNationalDex>(
          (event, emit) {
        NationalDex dexNacional = event.nationalDex;
        return emit(state.copyWith(dexNacional: dexNacional));
      },
    );
    on<DeleteNationalDex>(
          (event, emit) {
        return emit(state.initNationalDex());
      },
    );
  }
}
