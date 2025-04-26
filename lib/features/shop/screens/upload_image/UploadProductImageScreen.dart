import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';

class UploadProductImageScreen extends StatefulWidget {
  const UploadProductImageScreen({super.key});

  @override
  UploadProductImageScreenState createState() => UploadProductImageScreenState();
}

class UploadProductImageScreenState extends State<UploadProductImageScreen> {
  final ImagePicker _picker = ImagePicker();
  XFile? _image;

  Future<void> _uploadImage() async {
    if (_image == null) {
      _showInfoDialog('Please select an image first.');
      return;
    }

    bool? confirmUpload = await _showConfirmationDialog();
    if (confirmUpload != true) return;

    _showCustomLoader();

    try {
      final storageRef = FirebaseStorage.instance.ref().child(
        'product_images/${DateTime.now().millisecondsSinceEpoch}',
      );
      final uploadTask = storageRef.putFile(File(_image!.path));

      await uploadTask.whenComplete(() async {
        await storageRef.getDownloadURL();
        if (!mounted) return;
        Navigator.pop(context); // Close loader
        _showSuccessDialog();
        setState(() => _image = null);
      });
    } catch (e) {
      if (!mounted) return;
      Navigator.pop(context);
      _showInfoDialog('Upload failed. Please try again.');
    }
  }

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() => _image = pickedFile);
    }
  }

  Future<bool?> _showConfirmationDialog() {
    return showDialog<bool>(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Confirm Upload'),
            content: const Text('Are you sure you want to upload this image?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context, true),
                child: const Text('Yes'),
              ),
            ],
          ),
    );
  }

  void _showCustomLoader() {
    showDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.black.withOpacity(0.4),
      builder: (context) {
        return Stack(
          children: [
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
              child: const SizedBox.expand(),
            ),
            const Center(
              child: SizedBox(
                width: 50,
                height: 50,
                child: CircularProgressIndicator(
                  strokeWidth: 4,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    BaakasColors.primaryColor,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Upload Successful'),
            content: const Text('Thank you for uploading.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('OK'),
              ),
            ],
          ),
    );
  }

  void _showInfoDialog(String message) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Notice'),
            content: Text(message),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('OK'),
              ),
            ],
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Upload Product Image'),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: isDark ? Colors.white : Colors.black,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 40.0),
          child: Center(
            child: Column(
              children: [
                GestureDetector(
                  onTap: _pickImage,
                  child:
                      _image == null
                          ? Container(
                            height: 200,
                            width: 200,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(
                                color: BaakasColors.primaryColor.withOpacity(
                                  0.2,
                                ),
                                width: 2,
                              ),
                            ),
                            child: Icon(
                              Icons.image,
                              size: 100,
                              color: BaakasColors.primaryColor.withOpacity(0.4),
                            ),
                          )
                          : ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Image.file(
                              File(_image!.path),
                              height: 200,
                              width: 200,
                              fit: BoxFit.cover,
                            ),
                          ),
                ),
                const SizedBox(height: BaakasSizes.spaceBtwItems),
                ElevatedButton(
                  onPressed: _pickImage,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: BaakasColors.primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 40,
                      vertical: 15,
                    ),
                    textStyle: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  child: const Text('Pick Image'),
                ),
                const SizedBox(height: BaakasSizes.spaceBtwItems),
                ElevatedButton(
                  onPressed: _uploadImage,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: BaakasColors.primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 40,
                      vertical: 15,
                    ),
                    textStyle: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  child: const Text('Upload Image'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
