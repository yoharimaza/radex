part of 'national_dex_bloc.dart';

class NationalDexState{

  final bool existeUsuario;
  final NationalDex? nationalDex;

  NationalDexState({NationalDex? dexNacional})
      : nationalDex = dexNacional,
        existeUsuario = (dexNacional != null ) ? true : false;

  NationalDexState copyWith({NationalDex? dexNacional}) => NationalDexState(
      dexNacional: dexNacional ?? this.nationalDex
  );

  NationalDexState initNationalDex() => NationalDexState();
}