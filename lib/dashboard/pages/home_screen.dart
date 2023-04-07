import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:radex/components/cards.dart';
import 'package:radex/components/system_bars.dart';
import 'package:radex/constants/image_assets.dart';
import 'package:radex/dashboard/blocs/national_dex_bloc/national_dex_bloc.dart';
import 'package:radex/dashboard/models/pokemon_species_model.dart';
import 'package:radex/components/status_components.dart';
import 'package:radex/dashboard/models/pokemon_national_dex.dart';
import 'package:radex/dashboard/pages/loading_screen.dart';
import 'package:radex/utils/api_services/pokeapi_conection.dart';
import 'package:http/http.dart' as http;
import 'package:radex/utils/format_functions.dart';
import '../models/pokemon_info_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {

  late TextEditingController searchBarController;

  late List<PokemonEntry> pokemonListCustom;
  late NationalDex pokemonListFull;

  int initialRangeDex = 0;
  int limitRandeDex = 30;

  bool isErrorOcurred = false;
  bool isGettingContent = true;

  bool isSearchActive = false;
  bool isSearching = false;
  bool isEnableSearch = false;

  bool isBuildingRows = false;
  List<Widget> similiarSearchedPokemon = [];
  List<Widget> rangeListPokemon = [];
  List<PokemonInfo> pokemonInfoList = [];

  late PreferredSizeWidget appBar;

  @override
  void initState() {
    searchBarController = TextEditingController();
    super.initState();
    getNationalPokemonList();

  }

  @override
  void dispose() {
    super.dispose();
  }

  getNationalPokemonList() async {
    setState(() {
      isErrorOcurred = false;
      isGettingContent = true;
    });
    try{
      NationalDex nationalDex = await BlocProvider.of<NationalDexBloc>(context).state.nationalDex!;
      setState(() {
        pokemonListFull = nationalDex;
        isEnableSearch = true;
      });
      await getRangePokemonList(initialDexSearch: 0, limitDexSearch: 30);
    }catch(e){
      print('getNationalPokemonList e $e');
      setState(() {
        isErrorOcurred = true;
        isEnableSearch = false;
      });
    }


  }

  getRangePokemonList({required int initialDexSearch, required int limitDexSearch}) async {
    try{
      List<PokemonEntry> customRangePokedex = pokemonListFull.pokemonEntries.sublist(initialDexSearch, limitDexSearch);
      List<Widget> pokemonItems = await buildItemRow(customRangePokedex);
      setState(() {
        pokemonListCustom = customRangePokedex;
        rangeListPokemon = pokemonItems;
        isErrorOcurred = false;
        isGettingContent = false;
      });
    }catch(e){
      print('getRangePokemonList e $e');
      setState(() {
        isErrorOcurred = true;
        isGettingContent = false;
      });
    }
  }

  buildItemRow(List<PokemonEntry> pokemonList) async {
    List<Widget> itemList = [];

    setState(() {
      isBuildingRows = true;
      isSearching = false;
    });
    try{
      List<PokemonSpecie> pokemonSpecieList= [];
      List<PokemonInfo> pokemonInfoList = [];

      for (var pokemonItem in pokemonList) {
        http.Response serverResponse = await PokeapiConnection().getPokemonInfo(pokemonInfoUri: pokemonItem.pokemonSpecies.url);
        PokemonSpecie pokemonInfo = pokemonSpecieFromJson(serverResponse.body);
        pokemonSpecieList.add(pokemonInfo);
      }

      for (var pokemonSpecie in pokemonSpecieList) {
        http.Response serverResponse = await PokeapiConnection().getPokemonInfo(pokemonInfoUri: pokemonSpecie.varieties.first.pokemon.url);
        PokemonInfo pokemonInfo = pokemonInfoFromJson(serverResponse.body);
        pokemonInfoList.add(pokemonInfo);
      }

      for (int index=0; index<pokemonSpecieList.length;index++) {
        itemList.add(
            PokemonCards().pokemonCardInfo(context, pokemonList[index], pokemonSpecieList[index], pokemonInfoList[index])
        );
      }

      setState(() {
        isBuildingRows = false;
      });
      return itemList;
    }catch(e){
      print('buildItemRow e $e');
      setState(() {
        isBuildingRows = false;
      });
      return itemList;
    }
  }

  searchPokemon(String searchText) async {
    searchText = searchText.trim();
    setState(() {
      similiarSearchedPokemon = [];
    });
    if(!isGettingContent){
      List<PokemonEntry> similarPokemon = pokemonListFull.pokemonEntries.where((pokemonEntry) => pokemonEntry.pokemonSpecies.name.contains(searchText)).toList();
      List<Widget> cardList = await buildItemRow(similarPokemon);
      setState(() {
        similiarSearchedPokemon = cardList;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SystemBars().getAppBar(pageTitle: Padding(
        padding: EdgeInsets.only(top: 10),
        child: TextFormField(
          style: TextStyle(
              color: Colors.white
          ),
          controller: searchBarController,
          decoration: InputDecoration(
            labelStyle: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold
            ),
            enabled: (isEnableSearch && !isGettingContent),
            border: const OutlineInputBorder(),
            labelText: 'Search Pokémon',
            icon: const Icon(Icons.search, color: Colors.white,),
            fillColor: Colors.white,
            focusColor: Colors.white,
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white, width: 2.0),
            ),
            suffixIcon: IconButton(
              onPressed: (){
                FocusScope.of(context).unfocus();
                searchBarController.clear();
                searchBarController.text = '';
                setState(() {
                  isSearchActive = false;
                  similiarSearchedPokemon.clear();
                });
              },
              icon: const Icon(Icons.clear, color: Colors.white,),
            ),
          ),
          maxLines: 1,
          onTap: (){
            searchBarController.clear();
            searchBarController.text = '';
            setState(() {
              isSearchActive = true;
              isSearching = true;
              similiarSearchedPokemon.clear();
            });
          },
          onFieldSubmitted: !isGettingContent
              ? searchPokemon
              : null,
        ),
      )),
      extendBodyBehindAppBar: true,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        alignment: Alignment.topCenter,
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage(WALLPAPER_DEX),
              fit: BoxFit.cover),
        ),
        child: (isGettingContent || isBuildingRows)
            ? StatusComponents().gettingContent(context: context, loadingAsset: LOADING_MEW, loadingText: Text('Catching Pokemon', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 30),))
            : isErrorOcurred
              ? StatusComponents().errorOcurred(context: context, tryAgainButton: () async {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute<void>(
                      builder: (BuildContext context) => const LoadingScreen(),
                    ),
                  );
                 })
              : getListView(),
      ),
      bottomNavigationBar: (!isSearchActive)
         ? BottomNavigationBar(
            currentIndex: 1,
            fixedColor: Colors.red,
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.navigate_before),
                label: 'Previous',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.catching_pokemon),
                label: '#${FormatFunction().normalizeNumberFormat(initialRangeDex+1)} - #${FormatFunction().normalizeNumberFormat(limitRandeDex)}',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.navigate_next),
                label: 'Next',
              ),
            ],
            onTap: (index){
              if(!isBuildingRows){
                switch(index){
                  case 0:
                    if(initialRangeDex > 0){
                      setState(() {
                        limitRandeDex = initialRangeDex;
                        initialRangeDex = initialRangeDex - 30;
                      });
                      getRangePokemonList(initialDexSearch: initialRangeDex, limitDexSearch: limitRandeDex);
                    }
                    break;
                  case 2:
                    if(initialRangeDex < pokemonListFull.pokemonEntries.last.entryNumber){
                      setState(() {
                        initialRangeDex = limitRandeDex;
                        limitRandeDex = limitRandeDex + 30;
                      });
                      getRangePokemonList(initialDexSearch: initialRangeDex, limitDexSearch: limitRandeDex);
                    }
                    break;
                }
              }
            },
          )
          : null,
    );
  }

  Widget getListView() {
    if(isSearchActive){
      if(similiarSearchedPokemon.isNotEmpty){
        return gridViewList(similiarSearchedPokemon);
      }else{
        if(isSearching){
          return StatusComponents().searchingPokemon(context);
        }else{
          return StatusComponents().missingPokemon(context);
        }
      }
    }else{
      return isBuildingRows
          ? StatusComponents().gettingContent(context: context, loadingAsset: LOADING_MEW)
          : gridViewList(rangeListPokemon);
    }
  }

  Widget gridViewList(List<Widget> listWidgets){
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: GridView.count(
        physics: NeverScrollableScrollPhysics(),
        primary: false,
        shrinkWrap: true,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        crossAxisCount: 3,
        children: listWidgets,
      ),
    );
  }
}