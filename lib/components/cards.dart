import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../constants/image_assets.dart';
import '../dashboard/blocs/current_pokemon_entry/dex_entry_bloc.dart';
import '../dashboard/models/pokemon_info_model.dart';
import '../dashboard/models/pokemon_national_dex.dart';
import '../dashboard/models/pokemon_species_model.dart';
import '../dashboard/pages/pokemon_entry_screen.dart';
import '../utils/format_functions.dart';

class PokemonCards{
  Widget pokemonCardInfo(BuildContext context, PokemonEntry pokemonEntry, PokemonSpecie pokemonSpecie, PokemonInfo pokemonInfo){
    double cardWidth = MediaQuery.of(context).size.width /3;
    double cardHeight = MediaQuery.of(context).size.width /3;
    return GestureDetector(
      onTap: () async {
        DexEntryBloc dexEntryBloc = BlocProvider.of<DexEntryBloc>(context);
        dexEntryBloc.add(InitDexEntry(pokemonEntry, pokemonSpecie, pokemonInfo));
        Navigator.push(
          context,
          MaterialPageRoute<void>(
            builder: (BuildContext context) => const PokemonEntryScreen(),
          ),
        );
      },
      child: Container(
        width: cardWidth,
        height: cardHeight,
        padding: EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.5),
          border: Border.all(color: Colors.white, width: 2)
        ),
        child: Column(
          children: [
            Text(
              '#${FormatFunction().normalizeNumberFormat(pokemonEntry.entryNumber)}',
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            Container(
              width: cardWidth,
              height: cardHeight / 2,
              alignment: Alignment.center,
              child: FadeInImage.assetNetwork(
                placeholderFit: BoxFit.contain,
                placeholder: ICON_POKEBALL,
                image: pokemonInfo.sprites.other!.officialArtwork.frontDefault!,
                fit: BoxFit.contain,
                placeholderErrorBuilder: (BuildContext context, Object exception,
                    StackTrace? stackTrace) {
                  return Image.asset(ICON_POKEBALL, fit: BoxFit.contain,);
                },
              ),
            ),
            Text(
              FormatFunction().replaceLinedName(pokemonSpecie.name),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}