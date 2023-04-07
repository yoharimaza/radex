part of 'national_dex_bloc.dart';

@immutable
abstract class NationalDexEvent{}

class InitNationalDex extends NationalDexEvent{
  final NationalDex nationalDex;
  InitNationalDex(this.nationalDex);
}

class DeleteNationalDex extends NationalDexEvent{

}