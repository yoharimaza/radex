import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:radex/components/status_components.dart';
import 'package:http/http.dart' as http;
import 'package:radex/constants/image_assets.dart';
import 'package:radex/dashboard/blocs/national_dex_bloc/national_dex_bloc.dart';
import 'package:radex/dashboard/pages/home_screen.dart';
import '../../utils/api_services/pokeapi_conection.dart';
import '../../utils/connectivity_status.dart';
import '../models/pokemon_national_dex.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  bool isLoading = true;
  bool isError = false;

  gettingContent() async {
    if (await ConnectivityStatus.getInstance().isDeviceOnline()) {
      try {

        http.Response serverResponse = await PokeapiConnection().getNationalDex();
        NationalDex nationalDex = nationalDexFromJson(serverResponse.body);

        var nationalDexBloc = BlocProvider.of<NationalDexBloc>(context);
        nationalDexBloc.add(InitNationalDex(nationalDex));

        setState(() {
          isLoading = false;
          isError = false;
        });

        Navigator.pushReplacement(
          context,
          MaterialPageRoute<void>(
            builder: (BuildContext context) => const HomeScreen(),
          ),
        );
      } catch (e) {
        setState(() {
          isLoading = false;
          isError = true;
        });
      }
    } else {
      setState(() {
        isLoading = false;
        isError = true;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    gettingContent();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage(WALLPAPER_KALOS_DEX),
              fit: BoxFit.cover),
        ),
        child: isLoading
            ? StatusComponents().gettingContent(context: context, loadingAsset: LOADING_ASSET)
            : isError
              ? StatusComponents().errorOcurred(context: context)
              : StatusComponents().gettingContent(context: context, loadingAsset: LOADING_ASSET)
      ),
      extendBody: true,
      extendBodyBehindAppBar: true,
    );
  }
}
