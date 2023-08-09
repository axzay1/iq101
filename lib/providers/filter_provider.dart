import 'package:flutter/material.dart';
import 'package:iq101/model/filter_model.dart';

class FilterProvider extends ChangeNotifier {
  FilterModel? _filterModel = FilterModel();
 bool? _filter;
  bool? get filter => _filter;
  FilterModel? get filterModel => _filterModel;

  void setFilterActive(bool filter
      ){
   _filter = filter;
   notifyListeners();
  }

  void updateFilter(FilterModel newFilter) {
    _filterModel = newFilter;
    notifyListeners();
  }

  // Specific methods to modify the filters
  void addColor(String color) {
    _filterModel?.color ??= [];
    _filterModel?.color!.add(color);
    notifyListeners();
  }

  void removeColor(String color) {
    _filterModel?.color?.remove(color);
    notifyListeners();
  }

  void addSize(String size) {
    _filterModel?.size ??= [];
    _filterModel?.size!.add(size);
    notifyListeners();
  }

  void removeSize(String size) {
    _filterModel?.size?.remove(size);
    notifyListeners();
  }

  void setIsPrinted(bool value) {
    _filterModel?.isPrinted = value;
    notifyListeners();
  }

  void setMinCost(int value) {
    _filterModel?.minCost = value;
    notifyListeners();
  }

  void setMaxCost(int value) {
    _filterModel?.maxCost = value;
    notifyListeners();
  }

  void resetFilter(){
    _filterModel = FilterModel();
    notifyListeners();
  }
}

