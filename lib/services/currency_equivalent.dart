import 'package:bitcoin_ticker/services/networking.dart';

const coinApiUrl = 'https://rest.coinapi.io/v1/exchangerate/BTC';
const coinApiUrl2 = 'https://rest.coinapi.io/v1/exchangerate/ETH';
const coinApiUrl3 = 'https://rest.coinapi.io/v1/exchangerate/LTC';
const apiKey = 'B9AD9F43-4A47-4840-B34C-2E296DD8B3E4';

class ConversionBrain{

  Future<dynamic> getUSDValue(String data) async{
    var url = '$coinApiUrl/$data?apiKey=$apiKey';
    NetworkHandler network = NetworkHandler(url);
    var currencyData = await network.getData();
    return currencyData;
  }

  Future<dynamic> getETHValue(String data) async{
    var url = '$coinApiUrl2/$data?apiKey=$apiKey';
    NetworkHandler network = NetworkHandler(url);
    var currencyData = await network.getData();
    return currencyData;
  }

  Future<dynamic> getLTCValue(String data) async{
    var url = '$coinApiUrl3/$data?apiKey=$apiKey';
    NetworkHandler network = NetworkHandler(url);
    var currencyData = await network.getData();
    return currencyData;
  }

}