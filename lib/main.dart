import 'dart:math';

import 'package:datagrid_editing/utils/nam_pad.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'datasource/product_datasource.dart';
import 'model/product.dart';


RxBool isEditOpened = false.obs;
TextEditingController editingController = TextEditingController();
DataGridRow? mainDataGridRow;
RowColumnIndex? mainRowColumnIndex;
GridColumn? mainColumn;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'SfDataGrid Editing'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late DataGridController _dataGridController;

  late ProductDataGridSource freezePanesDataGridSource;

  //List<Product> products = <Product>[];
  EditingGestureType editingGestureType = EditingGestureType.doubleTap;


  @override
  void initState() {
    super.initState();
    _dataGridController = DataGridController();


    freezePanesDataGridSource = ProductDataGridSource();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SfDataGrid Editing'),
      ),
      body: Column(
        children: [
          _buildDataGrid(),
          showKeyPad()

        ],
      ),
    );
  }


  List<GridColumn> getColumns() {
    List<GridColumn> columns;
    columns = <GridColumn>[
      GridColumn(
          columnName: 'id',
          width: 90,
          label: Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.all(8.0),
            child: const Text(
              'ID',
              overflow: TextOverflow.ellipsis,
            ),
          )),
      GridColumn(
          columnName: '-85.0',
          width: 60,
          label: Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.all(8.0),
            child: const Text(
              '-85.0',
              overflow: TextOverflow.ellipsis,
            ),
          )),
      GridColumn(
          columnName: '-75.0',
          width: 60,
          label: Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.all(8.0),
            child: const Text(
              '-75.0',
              overflow: TextOverflow.ellipsis,
            ),
          )),
      GridColumn(
          columnName: '-60.0',
          width: 60,
          label: Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.all(8.0),
            child: const Text(
              '-60.0',
              overflow: TextOverflow.ellipsis,
            ),
          )),
      GridColumn(
          columnName: '-55.0',
          width: 60,
          label: Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.all(8.0),
            child: const Text(
              '-55.0',
              overflow: TextOverflow.ellipsis,
            ),
          )),
      GridColumn(
          columnName: '-45.0',
          width: 60,
          label: Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.all(8.0),
            child: const Text(
              '-45.0',
              overflow: TextOverflow.ellipsis,
            ),
          )),
      GridColumn(
          columnName: '-30.0',
          width: 60,
          label: Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.all(8.0),
            child: const Text(
              '-30.0',
              overflow: TextOverflow.ellipsis,
            ),
          )),
      GridColumn(
          columnName: '-20.0',
          width: 60,
          label: Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.all(8.0),
            child: const Text(
              '-20.0',
              overflow: TextOverflow.ellipsis,
            ),
          )),
    ];
    return columns;
  }

  Widget _buildDataGrid() {
    return Container(
      height: MediaQuery
          .of(context)
          .size
          .height * 0.40,
      child: SfDataGrid(
        source: freezePanesDataGridSource,
        frozenColumnsCount: 1,
        allowEditing: true,
        selectionMode: SelectionMode.single,
        navigationMode: GridNavigationMode.cell,
        editingGestureType: editingGestureType,
        columns: getColumns(),
        controller: _dataGridController,
        onCellTap: (DataGridCellTapDetails tapDetails) {
          String cellValue = freezePanesDataGridSource.effectiveRows[tapDetails
              .rowColumnIndex.rowIndex - 1]
              .getCells()[tapDetails.rowColumnIndex.columnIndex]
              .value
              .toString();
          print("${_dataGridController.currentCell.toString()}");
        },
      ),
    );
  }




  Widget showKeyPad() {
    return Obx(() {
      return Visibility(
        visible: isEditOpened.value,
        child: NumPad(
          buttonSize: 50,
          buttonColor: Colors.purple,
          iconColor: Colors.deepOrange,
          controller: editingController,
          delete: () {
            editingController.text = editingController.text
                .substring(0, editingController.text.length - 1);
          },
          onIncrement: (){
            editingController.text = (double.parse(editingController.text) + 1).toString();
          },
          onDecrement: (){
            editingController.text = (double.parse(editingController.text) - 1).toString();
          },
          // do something with the input numbers
          onSubmit: () {
            isEditOpened.value = false;
            ProductDataGridSource().newCellValue = editingController.text.toString().trim();
            ProductDataGridSource().onCellSubmit(mainDataGridRow!, mainRowColumnIndex!, mainColumn!);
          },
        ),
      );
    });
  }


}


