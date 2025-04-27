// ignore: file_names
import 'dart:io';
import 'dart:ui';
import 'package:baakas_seller/common/widgets/appbar/appbar.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:url_launcher/url_launcher.dart';

class DocumentsUploadScreen extends StatefulWidget {
  const DocumentsUploadScreen({super.key});

  @override
  State<DocumentsUploadScreen> createState() => _DocumentsUploadScreenState();
}

class _DocumentsUploadScreenState extends State<DocumentsUploadScreen> {
  final Map<String, Map<String, dynamic>?> uploadedDocs = {
    'Citizenship': null,
    'PAN / VAT': null,
    'Business License': null,
  };

  final ImagePicker _picker = ImagePicker();
  bool _isUploading = false;
  final user = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    super.initState();
    _loadUploadedDocs();
  }

  String _getSubcollectionName(String docType) {
    switch (docType) {
      case 'Citizenship':
        return 'citizenship';
      case 'PAN / VAT':
        return 'pan_vat';
      case 'Business License':
        return 'business_license';
      default:
        return 'uploaded_docs';
    }
  }

  Future<void> _loadUploadedDocs() async {
    if (user == null) return;
    final fetchedDocs = <String, Map<String, dynamic>>{};

    for (var docType in uploadedDocs.keys) {
      final subCollection = _getSubcollectionName(docType);
      final docSnapshot =
          await FirebaseFirestore.instance
              .collection('Sellers')
              .doc(user!.uid)
              .collection('documents')
              .doc(subCollection)
              .get();

      if (docSnapshot.exists) {
        fetchedDocs[docType] = docSnapshot.data()!;
      }
    }

    if (mounted) {
      setState(() {
        for (var type in uploadedDocs.keys) {
          uploadedDocs[type] = fetchedDocs[type];
        }
      });
    }
  }

  Future<void> _pickAndUploadDocument(String docType) async {
    final XFile? file = await _picker.pickImage(source: ImageSource.gallery);
    if (file == null || user == null) return;

    if (!mounted) return;
    final confirm = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Confirm Upload"),
        content: const Text("Do you want to upload this document?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text("Upload"),
          ),
        ],
      ),
    );

    if (confirm != true) return;

    if (mounted) setState(() => _isUploading = true);

    try {
      final timestamp = DateTime.now().millisecondsSinceEpoch;
      final storageRef = FirebaseStorage.instance
          .ref()
          .child('seller_documents')
          .child(user!.uid)
          .child('$docType-$timestamp.jpg');

      final subcollection = _getSubcollectionName(docType);

      // Delete previous file if exists
      final prevDoc = await FirebaseFirestore.instance
          .collection('Sellers')
          .doc(user!.uid)
          .collection('documents')
          .doc(subcollection)
          .get();

      if (prevDoc.exists) {
        final prevUrl = prevDoc['downloadUrl'];
        if (prevUrl != null) {
          try {
            await FirebaseStorage.instance.refFromURL(prevUrl).delete();
          } catch (e) {
            debugPrint("Old file deletion failed: $e");
          }
        }
      }

      final uploadTask = await storageRef.putFile(File(file.path));
      final downloadUrl = await uploadTask.ref.getDownloadURL();

      final nameFromEmail = user!.email?.split('@')[0] ?? 'Seller';

      await FirebaseFirestore.instance
          .collection('Sellers')
          .doc(user!.uid)
          .collection('documents')
          .doc(subcollection)
          .set({
            'userId': user!.uid,
            'username': (user?.displayName?.isNotEmpty ?? false) ? user!.displayName : nameFromEmail,
            'name': (user?.displayName?.isNotEmpty ?? false) ? user!.displayName : nameFromEmail,
            'email': user!.email ?? '',
            'documentType': docType,
            'downloadUrl': downloadUrl,
            'uploadedAt': FieldValue.serverTimestamp(),
          });

      await _loadUploadedDocs();
      if (mounted) setState(() => _isUploading = false);
      if (mounted) _showPopupDialog("Upload Successful", "$docType has been uploaded.");
    } catch (e) {
      debugPrint("Upload failed: $e");
      if (mounted) setState(() => _isUploading = false);
      if (mounted) _showPopupDialog("Upload Failed", "Could not upload $docType. Please try again.");
    }
  }

  Future<void> _deleteDocument(String docType) async {
    if (user == null) return;

    final confirmDelete = await showDialog<bool>(
      context: context,
      builder:
          (_) => AlertDialog(
            title: const Text("Confirm Deletion"),
            content: Text(
              "Are you sure you want to delete the $docType document?",
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: const Text("Cancel"),
              ),
              ElevatedButton(
                onPressed: () => Navigator.pop(context, true),
                child: const Text("Delete"),
              ),
            ],
          ),
    );

    if (confirmDelete != true) return;

    try {
      final subCollection = _getSubcollectionName(docType);
      await FirebaseFirestore.instance
          .collection('Sellers')
          .doc(user!.uid)
          .collection('documents')
          .doc(subCollection)
          .delete();

      if (mounted) {
        setState(() {
          uploadedDocs[docType] = null;
        });
      }

      _showPopupDialog("Deleted", "$docType document has been removed.");
    } catch (e) {
      _showPopupDialog("Error", "Failed to delete document.");
    }
  }

  Future<void> _downloadDocument(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      _showPopupDialog("Error", "Could not open document.");
    }
  }

  void _showPopupDialog(String title, String message) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder:
          (_) => AlertDialog(
            title: Text(title),
            content: Text(message),
            actions: [
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("OK"),
              ),
            ],
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;

    return Scaffold(
      appBar: const BaakasAppBar(
        showBackArrow: true,
        title: Text('Seller Documents'),
      ),
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: isMobile ? 12 : 40,
              vertical: isMobile ? 8 : 16,
            ),
            child: ListView(
              children:
                  uploadedDocs.entries.map((entry) {
                    final docName = entry.key;
                    final docData = entry.value;
                    final hasFile = docData != null;

                    return Card(
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      child: ListTile(
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                        leading: const Icon(Iconsax.document_upload, size: 30),
                        title: Text(
                          docName,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle:
                            hasFile
                                ? Text(
                                  'Uploaded on: ${docData['uploadedAt']?.toDate()?.toLocal() ?? ''}',
                                )
                                : const Text('No document uploaded'),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if (hasFile)
                              IconButton(
                                icon: const Icon(
                                  Icons.visibility,
                                  color: Colors.green,
                                ),
                                onPressed:
                                    () => _downloadDocument(
                                      docData['downloadUrl'],
                                    ),
                              ),
                            if (hasFile)
                              IconButton(
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                                onPressed: () => _deleteDocument(docName),
                              ),
                            IconButton(
                              icon: Icon(hasFile ? Icons.edit : Icons.upload),
                              onPressed: () => _pickAndUploadDocument(docName),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
            ),
          ),
          if (_isUploading)
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
              child: Container(
                color: Colors.black.withOpacity(0.3),
                child: const Center(child: CircularProgressIndicator()),
              ),
            ),
        ],
      ),
    );
  }
}
