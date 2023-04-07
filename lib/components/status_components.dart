import 'package:flutter/material.dart';
import 'package:radex/constants/image_assets.dart';

class StatusComponents{
  Widget errorOcurred({required BuildContext context, void Function()? tryAgainButton}){
    return Center(
      child: SingleChildScrollView(
        physics: const RangeMaintainingScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width/2,
              height: MediaQuery.of(context).size.width/2,
              child: Image.asset(
                ERROR_ASSET,
                fit: BoxFit.contain,
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 10, bottom: 20),
              child: Text(
                'Error Ocurred!',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            tryAgainButton != null
                ? Container(
              width: MediaQuery.of(context).size.width/2,
              child: ElevatedButton(
                onPressed: tryAgainButton,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red.shade800,
                  shape: StadiumBorder(),
                ),
                child: const Text('Try again'),
            )
            )
                : Container(),
          ],
        ),
      ),
    );
  }

  Widget gettingContent({required BuildContext context, Text? loadingText, String? loadingAsset}){
    return Center(
      child: SingleChildScrollView(
        physics: const RangeMaintainingScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width/2,
              height: MediaQuery.of(context).size.width/2,
              child: Image.asset(
                loadingAsset ?? LOADING_ASSET,
                fit: BoxFit.contain,
              ),
            ),
            loadingText != null
                ? loadingText
                : Container(),
          ],
        ),
      ),
    );
  }

  Widget missingPokemon(BuildContext context){
    return Center(
      child: SingleChildScrollView(
        physics: const RangeMaintainingScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width/2,
              height: MediaQuery.of(context).size.width/2,
              child: Image.asset(
                EMPTY_ASSET,
                fit: BoxFit.contain,
              ),
            ),
            Text(
              'Couldn\'t find that Pokemon',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget searchingPokemon(BuildContext context){
    return Center(
      child: SingleChildScrollView(
        physics: const RangeMaintainingScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: MediaQuery.of(context).size.width/2,
              height: MediaQuery.of(context).size.width/2,
              child: Image.asset(
                ICON_SEARCHING,
                fit: BoxFit.contain,
              ),
            ),
            Text(
              'Who\'s that Pokemon?!',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 30,
              ),
            ),
          ],
        ),
      ),
    );
  }
}