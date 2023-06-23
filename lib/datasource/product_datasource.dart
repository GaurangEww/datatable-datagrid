import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:collection/collection.dart';

import '../main.dart';
import '../model/product.dart';

class ProductDataGridSource extends DataGridSource {
  /// Creates the product data source class with required details.


  ProductDataGridSource() {
    products = getProducts(30);
    dataGridRows = products
        .map<DataGridRow>((dataGridRow) => dataGridRow.getDataGridRow())
        .toList();
  }

  List<Product> products = [];

  List<DataGridRow> dataGridRows = [];

  /// Helps to hold the new value of all editable widget.
  /// Based on the new value we will commit the new value into the corresponding
  /// [DataGridCell] on [onSubmitCell] method.
  dynamic newCellValue;

  /// Help to control the editable text in [TextField] widget.
  //TextEditingController editingController = TextEditingController();

  final Random _random = Random();

  @override
  List<DataGridRow> get rows => dataGridRows;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(cells: <Widget>[
      Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.all(8),
        child: Text(
          row.getCells()[0].value.toString(),
          overflow: TextOverflow.ellipsis,
        ),
      ),
      Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.all(8),
        child: Text(
          row.getCells()[1].value.toString(),
          overflow: TextOverflow.ellipsis,
        ),
      ),
      Container(
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.all(8),
        child: Text(
          row.getCells()[2].value.toString(),
          overflow: TextOverflow.ellipsis,
        ),
      ),
      Container(
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.all(8),
        child: Text(
          row.getCells()[3].value.toString(),
          overflow: TextOverflow.ellipsis,
        ),
      ),
      Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.all(8),
        child: Text(
          row.getCells()[4].value.toString(),
          overflow: TextOverflow.ellipsis,
        ),
      ),
      Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.all(8),
        child: Text(
          row.getCells()[5].value.toString(),
          overflow: TextOverflow.ellipsis,
        ),
      ),
      Container(
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.all(8),
        child: Text(
          row.getCells()[6].value.toString(),
          overflow: TextOverflow.ellipsis,
        ),
      ),
      Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.all(8),
        child: Text(
          row.getCells()[7].value.toString(),
          overflow: TextOverflow.ellipsis,
        ),
      ),
    ]);
  }

  @override
  int compare(DataGridRow? a, DataGridRow? b, SortColumnDetails sortColumn) {
    return super.compare(a, b, sortColumn);
  }


  @override
  Future<void>  onCellSubmit(DataGridRow dataGridRow, RowColumnIndex rowColumnIndex,
      GridColumn column) async {
    print("TEST-=-=$newCellValue");
    isEditOpened.value = false;
    final dynamic oldValue = mainDataGridRow!
        .getCells()
        .firstWhereOrNull((DataGridCell dataGridCell) =>
    dataGridCell.columnName == column.columnName)
        ?.value ??
        '';
    print("OLD VALUE -====$oldValue");
    print(dataGridRow.getCells()..toString());
    int dataRowIndex = 0;
    /*if (mainDataGridRow != null) {
      dataRowIndex = dataGridRows.indexOf(mainDataGridRow!);
    }*/

    for (int i = 0 ; i < dataGridRows.length ; i++) {
      DataGridRow otherDataGridRow = dataGridRows[i];
      if (otherDataGridRow.getCells().first.value == mainDataGridRow!.getCells().first!.value) {
        dataRowIndex = i;
        break;
      }
    }
    if (editingController.text.toString().isEmpty || oldValue == editingController.text.toString()) {
      return;
    }
    print("COLUMN NAME _==${column.columnName}");
    if (column.columnName == '-85.0') {

      dataGridRows[dataRowIndex].getCells()[rowColumnIndex.columnIndex] = DataGridCell<String>(columnName: '-85.0', value: editingController.text.toString());
      products[dataRowIndex].name = double.parse(editingController.text.toString());
    } 
  }
  @override
  Future<bool> canSubmitCell(DataGridRow dataGridRow,
      RowColumnIndex rowColumnIndex, GridColumn column) async {
    print("METHOD CALLED");
    return true;
  }

  @override
  Widget? buildEditWidget(DataGridRow dataGridRow,
      RowColumnIndex rowColumnIndex, GridColumn column, CellSubmit submitCell) {
    // Text going to display on editable widget
    final String displayText = dataGridRow
        .getCells()
        .firstWhereOrNull((DataGridCell dataGridCell) =>
    dataGridCell.columnName == column.columnName)
        ?.value
        ?.toString() ??
        '';

    newCellValue = null;
    mainDataGridRow = dataGridRow;
    mainRowColumnIndex = rowColumnIndex;
    mainColumn = column;

    isEditOpened.value = true;
   // final RegExp regExp = _getRegExp(isNumericType, column.columnName);

    return Container(
      padding: const EdgeInsets.all(8.0),
      //alignment: isNumericType ? Alignment.centerRight : Alignment.centerLeft,
      child: TextField(
        autofocus: true,
        controller: editingController..text = displayText,
        textAlign: TextAlign.right,
        autocorrect: false,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.fromLTRB(0, 0, 0, 16.0),
        ),
        keyboardType:TextInputType.none,
        onChanged: (String value) {
          if (value.isNotEmpty) {
            newCellValue = value;
          } else {
            newCellValue = null;
          }
          print("NEW CALL VALUE ---$newCellValue");
        },
        onSubmitted: (String value) {

          print("CLICKED ---$value");
          /// Call [CellSubmit] callback to fire the canSubmitCell and
          /// onCellSubmit to commit the new value in single place.
          submitCell();
        },
      ),
    );
  }

  RegExp _getRegExp(bool isNumericKeyBoard, String columnName) {
    return isNumericKeyBoard ? RegExp('[0-9]') : RegExp('[a-zA-Z ]');
  }

  final List<double> _product = <double>[
    0.20,
    0.50,
    0.80,
    1.00,
    1.00,
    0.85,
    0.30,
    0.35,
    0.40,
    0.20,
    0.50,
    0.80,
    1.00,
    1.00,
    0.85,
    0.30,
    0.35,
    0.40,
  ];

  final List<double> _cities = <double>[
    0.20,
    0.50,
    0.80,
    1.00,
    1.00,
    0.85,
    0.30,
    0.35,

  ];

  final List<double> _productId = <double>[
    500,
    750,
    1000,
    1250,
    1500,
    1750,
    2000,
    2250,
    2500,
    2750,
    3000,
    3250,
    3500,
    3750,
    4000,
    4250,
    4500,
    4750,
    5000,
    5250,
    5500,
    5750,
    6000,
    6250,
    6500,
    6750,
    7000,
    7250,
    7500,
  ];

  final List<double> _orderDate = <double>[
    0.20,
    0.50,
    0.80,
    1.00,
    1.00,
    0.85,
    0.30,
    0.35,
    1.00,
    1.00,
    1.00,
    1.00,
  ];

  final List<double> _names = <double>[
    1.00,
    1.00,
  ];

  /// Get products collection
  List<Product> getProducts(int count) {
    final List<Product> productData = <Product>[];
    for (int i = 0; i < count; i++) {
      productData.add(
        Product(
            _productId[ _random.nextInt(_productId.length-1)],
            _orderDate[ _random.nextInt(_orderDate.length-1)],
            _orderDate[ _random.nextInt(_orderDate.length-1)],
            _orderDate[ _random.nextInt(_orderDate.length-1)],
            _orderDate[ _random.nextInt(_orderDate.length-1)],
            _orderDate[ _random.nextInt(_orderDate.length-1)],
            _orderDate[ _random.nextInt(_orderDate.length-1)],
            _names[i < _names.length ? i : _random.nextInt(_names.length - 1)]),
      );
    }
    return productData;
  }
}