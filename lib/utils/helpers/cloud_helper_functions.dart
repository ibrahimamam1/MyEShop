import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppCloudHelperFunctions {
  ///Helper function to check the state of a single database record.
  ///Return a widget based on the state of the snapshot

  static Widget? checkSingleRecordState<T>(AsyncSnapshot<T> snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return const Center(child: CircularProgressIndicator());
    }

    if (!snapshot.hasData || snapshot.data == null) {
      return const Center(child: Text('No Data found'));
    }

    if (snapshot.hasError) {
      return const Center(child: Text('Something Went Wrong'));
    }

    return null;
  }

  ///Helper function to check the state of multiple database records.
  ///Return a widget based on the state of the snapshot

  static Widget? checkMultiRecordState<T>(
      {required AsyncSnapshot<List<T>> snapshot,
      Widget? loader,
      Widget? error,
      Widget? nothingFound}) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      if (loader != null) return loader;
      return const Center(child: Text('No Data found'));
    }

    if (!snapshot.hasData || snapshot.data == null) {
      return const Center(child: Text('No Data found'));
    }

    if (snapshot.hasError) {
      if (error != null) return error;
      return const Center(child: Text('Something Went Wrong'));
    }

    return null;
  }

  static Future<String> getURLFromFilePathAndName(String path) async {
    try {
      if (path.isEmpty) return '';
      final ref = FirebaseStorage.instance.ref().child(path);
      final url = await ref.getDownloadURL();
      return url;
    } on FirebaseException {
      rethrow;
    } on PlatformException {
      rethrow;
    } catch (e) {
      throw 'Something Went Wrong';
    }
  }
}
