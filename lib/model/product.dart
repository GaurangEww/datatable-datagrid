import 'package:syncfusion_flutter_datagrid/datagrid.dart';

/// Custom business object class which contains properties to hold the detailed
/// information about the product which will be rendered in datagrid.
class Product {
  /// Creates the product class with required details.
  Product(this.id, this.productId, this.product, this.quantity, this.unitPrice,
      this.city, this.orderDate, this.name);

  /// Id of product.
  double id;

  /// ProductId of product.
  double productId;

  /// ProductName of product.
  double product;

  /// Quantity of product.
  double quantity;

  /// Unit price of product.
  double unitPrice;

  /// City of product.
  double city;

  /// Order date of product.
  double orderDate;

  /// Name of product.
  double name;

  /// Get datagrid row of the dealer.
  DataGridRow getDataGridRow() {
    return DataGridRow(cells: <DataGridCell>[
      DataGridCell<double>(columnName: 'Id', value: id),
      DataGridCell<double>(columnName: '-85.0', value: productId),
      DataGridCell<double>(columnName: '-75.0', value: name),
      DataGridCell<double>(columnName: '-60.0', value: product),
      DataGridCell<double>(columnName: '-55.0', value: orderDate),
      DataGridCell<double>(columnName: '-45.0', value: quantity),
      DataGridCell<double>(columnName: '-30.0', value: city),
      DataGridCell<double>(columnName: '-20.0', value: unitPrice),
    ]);
  }
}
