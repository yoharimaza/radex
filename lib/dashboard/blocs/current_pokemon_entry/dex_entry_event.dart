part of 'dex_entry_bloc.dart';

@immutable
abstract class DexEntryEvent{}

class InitDexEntry extends DexEntryEvent{
  final PokemonEntry pokemonEntryNationalDex;
  final PokemonSpecie pokemonSpecie;
  final PokemonInfo pokemonInfo;
  InitDexEntry(this.pokemonEntryNationalDex, this.pokemonSpecie, this.pokemonInfo);
}

class DeleteDexEntry extends DexEntryEvent{

}