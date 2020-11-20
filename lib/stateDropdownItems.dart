import 'package:flutter/material.dart';

List<DropdownMenuItem<String>> createStateDropdownItems() {
  return [
    makeMenuItem('Abia'),
    makeMenuItem('Adamawa'),
    makeMenuItem('AkwaIbom'),
    makeMenuItem('Anambra'),
    makeMenuItem('Bauchi'),
    makeMenuItem('Bayelsa'),
    makeMenuItem('Benue'),
    makeMenuItem('Borno'),
    makeMenuItem('CrossRiver'),
    makeMenuItem('Delta'),
    makeMenuItem('Ebonyi'),
    makeMenuItem('Edo'),
    makeMenuItem('Ekiti'),
    makeMenuItem('Enugu'),
    makeMenuItem('FCT'),
    makeMenuItem('Gombe'),
    makeMenuItem('Imo'),
    makeMenuItem('Jigawa'),
    makeMenuItem('Kaduna'),
    makeMenuItem('Kano'),
    makeMenuItem('Katsina'),
    makeMenuItem('Kebbi'),
    makeMenuItem('Kogi'),
    makeMenuItem('Kwara'),
    makeMenuItem('Lagos'),
    makeMenuItem('Nasarawa'),
    makeMenuItem('Niger'),
    makeMenuItem('Ogun'),
    makeMenuItem('Ondo'),
    makeMenuItem('Osun'),
    makeMenuItem('Oyo'),
    makeMenuItem('Plateau'),
    makeMenuItem('Rivers'),
    makeMenuItem('Sokoto'),
    makeMenuItem('Taraba'),
    makeMenuItem('Yobe'),
    makeMenuItem('Zamfara'),
  ];
}

Widget makeMenuItem(String itemName) {
  return DropdownMenuItem(
    value: itemName,
    child: Text(itemName),
  );
}