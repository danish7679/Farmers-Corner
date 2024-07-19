import 'dart:convert';
import 'dart:io';

import 'package:agri_connect/data/models/crop.dart';
import 'package:agri_connect/data/repositories/crop_repository.dart';
import 'package:agri_connect/domain/entites/params/scan_crop_params.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../../domain/entites/app_error.dart';

part 'scan_crop_state.dart';

@injectable
class ScanCropCubit extends Cubit<ScanCropState> {
  final CropRepository _cropRepository;

  ScanCropCubit(this._cropRepository) : super(ScanCropInitial());

  void scanCrop(File imgFile) async {
    // return _mockScanCrop();
    emit(ScanCropLoading());
    print(imgFile.lengthSync());
    final fileInBase64 = base64Encode(await imgFile.readAsBytes());
    print(fileInBase64.length);
    final params = ScanCropParams(imageInBase64: fileInBase64);
    print(params);
    final res = await _cropRepository.scanCrop(params.toMap());
    print(res);
    emit(res.fold((l) => ScanCropFailure(l), (r) => ScanCropSuccess(r)));
  }

  void _mockScanCrop() async {
    emit(ScanCropLoading());
    await Future.delayed(const Duration(seconds: 2));
    final crop = crops.first;
    emit(ScanCropSuccess(crop));
  }
}
