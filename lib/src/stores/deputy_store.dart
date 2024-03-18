import 'package:flutter/material.dart';
import 'package:flutter_deputyapp/src/models/deputy_model.dart';
import 'package:flutter_deputyapp/src/state/deputy_state.dart';

class DeputyStore extends ValueNotifier<DeputyState> {
  DeputyStore(DeputyState value) : super(value);

  void getDeputies() {
    // Simulate loading by setting loading to true
    value = value.copyWith(loading: true, error: '');
    
    // Perform the actual logic to fetch deputies
    // For demonstration purposes, we're just setting an empty list of deputies and an error message
    // Replace this with your actual logic to fetch deputies from an API or any other source
    final List<DeputyModel> fetchedDeputies = []; // Replace this with actual fetched data
    const error = ''; // Replace this with actual error message if fetching fails
    
    // Update the state with fetched data or error
    value = value.copyWith(loading: false, deputies: fetchedDeputies, error: error);
  }
}
