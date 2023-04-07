import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import '../../models/pokemon_info_model.dart';
import '../../models/pokemon_national_dex.dart';
import '../../models/pokemon_species_model.dart';

part 'dex_entry_event.dart';
part 'dex_entry_state.dart';

class DexEntryBloc extends Bloc<DexEntryEvent, DexEntryState> {
  DexEntryBloc() : super(DexEntryState()) {
    on<InitDexEntry>(
          (event, emit) {
        PokemonEntry pokemonEntry = event.pokemonEntryNationalDex;
        PokemonSpecie pokemonSpecie = event.pokemonSpecie;
        PokemonInfo pokemonInfo = event.pokemonInfo;
        return emit(state.copyWith(pokemonEntry: pokemonEntry, pokemonInfo: pokemonInfo, pokemonSpecie: pokemonSpecie));
      },
    );
    on<DeleteDexEntry>(
          (event, emit) {
        return emit(state.initPokedexEntry());
      },
    );
  }
}
