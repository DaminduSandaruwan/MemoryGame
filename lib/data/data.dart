import 'package:memory_game/model/tile_model.dart';

List<TileModel> getPairs(){
  List<TileModel> pairs = new List<TileModel>();
  TileModel tileModel = new TileModel();

  // 1
  tileModel.setImageAssetPath("assets/fox.png");
  tileModel.setIsSelected(false);
  pairs.add(tileModel);
  pairs.add(tileModel);

  tileModel = new TileModel();

  
}