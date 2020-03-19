import 'package:scoped_model/scoped_model.dart';
import 'connectedProducts.dart';

class MainModel extends Model
    with ConnectedProductsModel, UserModel, ProductModel, UtilityModel {}
