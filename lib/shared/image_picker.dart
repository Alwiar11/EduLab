import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AppImagePicker {
  BuildContext context;
  AppImagePicker(this.context);
	Future<File?> getImageGallery() async {
		ImagePicker _picker = ImagePicker();
		final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
		if(image != null){
			return File(image.path);
		}else{
			return null;
		}
	}
}
