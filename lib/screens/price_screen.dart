import 'package:loader_overlay/loader_overlay.dart';
import 'package:flutter/material.dart';
import 'package:bitcoin_ticker/services/coin_data.dart';
import 'package:bitcoin_ticker/services/currency_equivalent.dart';

class PriceScreen extends StatefulWidget {
  const PriceScreen({Key? key}) : super(key: key);


  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {

  var selectedCurrency = 'Select';
  var fiat = 'data';
  double fiatValue =  0.0;
  var fiat2 = 'data';
  double fiatValue2 =  0.0;
  var fiat3 = 'data';
  double fiatValue3 =  0.0;

  ConversionBrain currencyData = ConversionBrain();

  List<DropdownMenuItem<String>> getDropdownItems(){
    List<DropdownMenuItem<String>>dropdownItems = [];
    //apply a looping mechanism to save the currency data in a new list
    for(int i = 0; i < currenciesList.length;  i++){
      String currency = currenciesList[i];
      var items = DropdownMenuItem(child: Text(currency), value: currency,);
      dropdownItems.add(items);
    }
    return dropdownItems;
  }
  //method that returns the actual crypto value for a currency

  void updateFiatUIValues(data, data2, data3){
    setState(() {
      if(data == null){
        fiat = 'none';
        fiatValue = 0.0;
        fiat2 = 'none';
        fiatValue2 = 0.0;
        fiat2 = 'none';
        fiatValue2 = 0.0;
        return;
      }
      fiat = data['asset_id_quote'];
      fiatValue = data['rate'];
      fiat2 = data2['asset_id_quote'];
      fiatValue2 = data2['rate'];
      fiat3 = data3['asset_id_quote'];
      fiatValue3 = data3['rate'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('🤑 Coin Ticker'),),
      ),
      body: LoaderOverlay(
        useDefaultLoading: LoaderOverlay.useDefaultLoadingValue,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
                child: Card(
                  color: Colors.lightBlueAccent,
                  elevation: 5.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                    child: Text(
                      '1 BTC = ${fiatValue.round()} $fiat',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 20.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
                child: Card(
                  color: Colors.lightBlueAccent,
                  elevation: 5.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                    child: Text(
                      '1 ETH = ${fiatValue2.round()} $fiat2',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 20.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
                child: Card(
                  color: Colors.lightBlueAccent,
                  elevation: 5.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                    child: Text(
                      '1 LTC = ${fiatValue3.round()} $fiat3',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 20.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],),
            Container(
              height: 150.0,
              alignment: Alignment.center,
              padding: const EdgeInsets.only(bottom: 30.0),
              color: Colors.lightBlue,
              child: DropdownButton<String>(
                  value: selectedCurrency ,
                  items: getDropdownItems(),
                  onChanged: (value){
                    setState(() async {
                selectedCurrency = value!;
                context.loaderOverlay.show();
                var currencyValue = await currencyData.getUSDValue(selectedCurrency);
                var currencyValue2 = await currencyData.getETHValue(selectedCurrency);
                var currencyValue3 = await currencyData.getLTCValue(selectedCurrency);
                updateFiatUIValues(currencyValue, currencyValue2, currencyValue3);
                context.loaderOverlay.hide();
              });
              }),
            ),
          ],
        ),
      ),
    );
  }
}
