import 'package:http/http.dart' as http;
import 'package:radex/constants/uris.dart';

class PokeapiConnection{
  Future<http.Response> getNationalDex() async {
    try{
      final response = await http.get(
        Uri.parse('$API_PATH/$NATIONAL_DEX_PATH/'),
      ).timeout(Duration(seconds: 5));
      return response;
    }catch(exception){
      return http.Response('detail: $exception', 404);
    }
  }

  Future<http.Response> getPokemonInfo({required String pokemonInfoUri}) async {
    try{
      final response = await http.get(
        Uri.parse(pokemonInfoUri),
      ).timeout(Duration(seconds: 20));
      return response;
    }catch(exception){
      return http.Response('detail: $exception', 404);
    }
  }
}