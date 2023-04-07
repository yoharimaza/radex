import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:radex/components/status_components.dart';
import 'package:radex/components/system_bars.dart';
import 'package:radex/dashboard/blocs/current_pokemon_entry/dex_entry_bloc.dart';
import 'package:radex/dashboard/models/pokemon_national_dex.dart';
import 'package:radex/dashboard/models/pokemon_species_model.dart';

import '../../constants/image_assets.dart';
import '../../utils/format_functions.dart';
import '../models/pokemon_info_model.dart';

class PokemonEntryScreen extends StatefulWidget {
  const PokemonEntryScreen({Key? key}) : super(key: key);

  @override
  PokemonEntryScreenState createState() => PokemonEntryScreenState();
}

class PokemonEntryScreenState extends State<PokemonEntryScreen> {
  late PokemonEntry? pokemonEntry;
  late PokemonSpecie? pokemonSpecie;
  late PokemonInfo? pokemonInfo;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  bool isCorrectEntry(){
    return (pokemonEntry != null && pokemonSpecie!=null && pokemonInfo!=null);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DexEntryBloc, DexEntryState>(
      builder: (_, state) {
        pokemonEntry = state.pokemonEntry;
        pokemonSpecie = state.pokemonSpecie;
        pokemonInfo = state.pokemonInfo;
        return Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage(WALLPAPER_DEX),
                fit: BoxFit.cover),
          ),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: SystemBars().getNormalAppBar(
                pageTitle: Text(
                  FormatFunction().replaceLinedName(pokemonSpecie!.name),
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.5
                  ),
                ),
                colorAppBar: Colors.transparent
            ),
            body: isCorrectEntry() ? dexEntryInfo() : StatusComponents().errorOcurred(context:context, tryAgainButton: (){Navigator.of(context).pop();}),
          ),
        );
      },
    );
  }

  Widget dexEntryInfo(){
    return Container(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            pokemonEntryBasicInfo(),
            abilitiesList(),
            moveList(),
          ],
        ),
      ),
    );
  }

  Widget pokemonEntryBasicInfo(){
    double containerWidth = MediaQuery.of(context).size.width/2;
    double containerHeight = MediaQuery.of(context).size.width/2;
    List<Widget> pokemonTypes = [];
    pokemonInfo!.types.forEach((pokemonType) {
      pokemonTypes.add(
        Container(
          height: 30,
          width: containerWidth * (1/3),
          child: Image.asset(
            typeIcon(pokemonType.type.name),
            fit: BoxFit.contain,
          ),
        )
      );
    });
    return Row(
      children: [
        Container(
          width: containerWidth,
          height: containerHeight,
          child: Column(
            children: [
              showInfoSection('Name', FormatFunction().replaceLinedName(pokemonSpecie!.name), true),
              showInfoSection('Entry Description', FormatFunction().replaceLinedName(pokemonSpecie!.flavorTextEntries.first.flavorText), true),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.all(20),
          width: containerWidth,
          height: containerHeight+30,
          alignment: Alignment.center,
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage(POKEMON_BACKGROUND),
                alignment: Alignment.center,
                fit: BoxFit.cover,
              opacity: 0.5
            ),
          ),
          child: Column(
            children: [
              FadeInImage.assetNetwork(
                placeholderFit: BoxFit.contain,
                placeholder: ICON_POKEBALL,
                image: pokemonInfo!.sprites.other!.officialArtwork.frontDefault!,
                fit: BoxFit.contain,
                placeholderErrorBuilder: (BuildContext context, Object exception,
                    StackTrace? stackTrace) {
                  return Image.asset(ICON_POKEBALL, fit: BoxFit.contain,);
                },
              ),
              Container(
                height: 20,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: pokemonTypes,
                ),
              )
            ],
          ),
        )
      ],
    );
  }

  Widget showInfoSection(String category, String description, bool autoSizeText){
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
          alignment: Alignment.centerLeft,
          width: MediaQuery.of(context).size.width,
          height: 30,
          decoration: BoxDecoration(
            color: Colors.purple.shade500,
            borderRadius: const BorderRadius.only(bottomRight: Radius.circular(20), topRight: Radius.circular(20)),
          ),
          child: Text(
            category,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.5,
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
          alignment: Alignment.centerLeft,
          width: MediaQuery.of(context).size.width,
          height: autoSizeText ? null : 30,
          decoration: BoxDecoration(
            color: Colors.transparent,
          ),
          child: Text(
            description,
            softWrap: false,
            overflow: TextOverflow.fade,
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.5,
            ),
          ),
        )
      ],
    );
  }

  Widget abilitiesList(){
    List<Widget> commonAbilities = [];
    List<Widget> hiddenAbilities = [];
    pokemonInfo!.abilities.forEach((ability) {
      if(ability.isHidden){
        hiddenAbilities.add(
          Padding(
            padding: EdgeInsets.all(5),
            child: GestureDetector(
              child: Text(FormatFunction().replaceLinedName(ability.ability.name),),
              onTap: (){},
            ),
          ),
        );
      }else{
        commonAbilities.add(
          Padding(
            padding: EdgeInsets.all(5),
            child: GestureDetector(
              child: Text(FormatFunction().replaceLinedName(ability.ability.name),),
              onTap: (){},
            ),
          ),
        );
      }
    });

    if(hiddenAbilities.isEmpty){
      hiddenAbilities.add(Text('-'));
    }

    return Column(
      children: [
        Container(
          padding: const EdgeInsets.only(left: 10, right: 50, top: 5, bottom: 5),
          alignment: Alignment.centerLeft,
          width: MediaQuery.of(context).size.width,
          height: 30,
          decoration: BoxDecoration(
            color: Colors.purple.shade500,
            borderRadius: const BorderRadius.only(bottomRight: Radius.circular(20), topRight: Radius.circular(20)),
          ),
          child: Text(
            'Abilities: ${pokemonInfo!.abilities.length}',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.5,
            ),
          ),
        ),
        Container(
          height: commonAbilities.length*40,
          child: Row(
            children: [
              Container(
                width: MediaQuery.of(context).size.width/3,
                alignment: Alignment.center,
                height: commonAbilities.length*40,
                padding: EdgeInsets.all(5),
                child: Text(
                  'Abilities',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black54,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.5,
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * (2/3),
                height: commonAbilities.length*40,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: commonAbilities,
                ),
              ),
            ],
          ),
        ),
        Container(
          height: commonAbilities.length*40,
          child: Row(
            children: [
              Container(
                width: MediaQuery.of(context).size.width/3,
                alignment: Alignment.center,
                height: commonAbilities.length*40,
                padding: EdgeInsets.all(5),
                child: Text(
                  'Hidden Abilities',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black54,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.5,
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * (2/3),
                height: commonAbilities.length*40,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: hiddenAbilities,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget moveList(){
    List<Widget> moves = [];
    moves.add(
        Padding(
          padding: EdgeInsets.only(top: 20, bottom: 10),
          child: Row(
            children: [
              Container(
                width: MediaQuery.of(context).size.width/2,
                alignment: Alignment.center,
                child: Text(
                  'NAME'.toUpperCase(),
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.5,
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width/2,
                alignment: Alignment.center,
                child: Text(
                  'LEARN METHOD'.toUpperCase(),
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.5,
                  ),
                ),
              ),
            ],
          ),
        )
    );
    pokemonInfo!.moves.forEach((move) {
      String moveLearnMethod = '';
      if(move.versionGroupDetails.first.moveLearnMethod.name == 'level-up'){
        moveLearnMethod = '${FormatFunction().replaceLinedName(move.versionGroupDetails.first.moveLearnMethod.name)} AT LVL ${move.versionGroupDetails.first.levelLearnedAt}';
      }else{
        moveLearnMethod = move.versionGroupDetails.first.moveLearnMethod.name.toUpperCase();
      }
      moves.add(
        Container(
          height: 30,
          padding: EdgeInsets.only(top: 10),
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width/2,
                    padding: EdgeInsets.only(left: 20),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      FormatFunction().replaceLinedName(move.move.name),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width/2,
                    padding: EdgeInsets.only(left: 20),
                    alignment: Alignment.centerLeft,
                    child: Text(
                        moveLearnMethod.toUpperCase()
                    ),
                  ),
                ],
              ),
              Container(
                width: MediaQuery.of(context).size.width * (9/10),
                height: 1,
                color: Colors.black,
                child: Text(''),
              )
            ],
          )
        )
      );
    });

    return Column(
      children: [
        SizedBox(
          height: 10,
        ),
        Container(
          padding: const EdgeInsets.only(left: 10, right: 50, top: 5, bottom: 5),
          alignment: Alignment.centerLeft,
          width: MediaQuery.of(context).size.width,
          height: 30,
          decoration: BoxDecoration(
            color: Colors.purple.shade500,
            borderRadius: const BorderRadius.only(bottomRight: Radius.circular(20), topRight: Radius.circular(20)),
          ),
          child: Text(
            'Moves: ${pokemonInfo!.moves.length}',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.5,
            ),
          ),
        ),
        Column(
          children: moves,
        ),
      ],
    );
  }
}