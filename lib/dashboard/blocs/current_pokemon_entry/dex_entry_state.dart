part of 'dex_entry_bloc.dart';

class DexEntryState{

  final PokemonEntry? pokemonEntry;
  final PokemonSpecie? pokemonSpecie;
  final PokemonInfo? pokemonInfo;

  DexEntryState({PokemonEntry? entryPokemon, PokemonSpecie? speciePokemon, PokemonInfo? infoPokemon})
      : pokemonEntry = entryPokemon,
        pokemonSpecie = speciePokemon,
        pokemonInfo = infoPokemon;

  DexEntryState copyWith({PokemonEntry? pokemonEntry, PokemonSpecie? pokemonSpecie, PokemonInfo? pokemonInfo}) => DexEntryState(
    entryPokemon: pokemonEntry ?? this.pokemonEntry,
    speciePokemon: pokemonSpecie ?? this.pokemonSpecie,
    infoPokemon: pokemonInfo ??  this.pokemonInfo,
  );

  DexEntryState initPokedexEntry() => DexEntryState();
}