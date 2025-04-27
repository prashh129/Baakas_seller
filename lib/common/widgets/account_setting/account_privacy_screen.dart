/// Second Code Start from here
library;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import '../../../common/widgets/appbar/appbar.dart';

class AccountPrivacyScreen extends StatefulWidget {
  const AccountPrivacyScreen({super.key});

  @override
  State<AccountPrivacyScreen> createState() => _AccountPrivacyScreenState();
}

class _AccountPrivacyScreenState extends State<AccountPrivacyScreen> {
  final _logger = Logger();
  bool shareData = false;
  bool personalizedAds = false;

  bool showProfileToBuyers = false;
  bool showStoreStatsPublicly = false;

  bool trackProductViews = false;
  bool trackOrderPerformance = false;

  bool rememberDevice = false;

  @override
  void initState() {
    super.initState();
    _loadSettingsFromFirestore();
  }

  Future<void> _loadSettingsFromFirestore() async {
    final userUID = FirebaseAuth.instance.currentUser?.uid;
    if (userUID == null) return;

    try {
      final doc = await FirebaseFirestore.instance
          .collection('Sellers')
          .doc(userUID)
          .collection('settings')
          .doc('privacy')
          .get();

      if (doc.exists) {
        final data = doc.data() ?? {};
        setState(() {
          shareData = data['shareData'] ?? false;
          personalizedAds = data['personalizedAds'] ?? false;
          showProfileToBuyers = data['showProfileToBuyers'] ?? false;
          showStoreStatsPublicly = data['showStoreStatsPublicly'] ?? false;
          trackProductViews = data['trackProductViews'] ?? false;
          trackOrderPerformance = data['trackOrderPerformance'] ?? false;
          rememberDevice = data['rememberDevice'] ?? false;
        });
      }
    } catch (e) {
      _logger.e("Error loading settings: $e");
    }
  }

  Future<void> _saveSettingsToFirestore() async {
    final userUID = FirebaseAuth.instance.currentUser?.uid;
    if (userUID == null) return;

    final settings = {
      'shareData': shareData,
      'personalizedAds': personalizedAds,
      'showProfileToBuyers': showProfileToBuyers,
      'showStoreStatsPublicly': showStoreStatsPublicly,
      'trackProductViews': trackProductViews,
      'trackOrderPerformance': trackOrderPerformance,
      'rememberDevice': rememberDevice,
    };

    try {
      await FirebaseFirestore.instance
          .collection('Sellers')
          .doc(userUID)
          .collection('settings')
          .doc('privacy')
          .set(settings, SetOptions(merge: true));

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Privacy settings updated!')),
        );
      }
    } catch (e) {
      _logger.e("Error saving settings: $e");
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to update settings: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BaakasAppBar(
        showBackArrow: true,
        title: Text("Privacy & Preferences"),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            "Data Preferences",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          _switchTile("Allow data sharing with analytics tools", shareData, (
            val,
          ) {
            setState(() => shareData = val);
            _saveSettingsToFirestore();
          }),
          _switchTile("Enable personalized recommendations", personalizedAds, (
            val,
          ) {
            setState(() => personalizedAds = val);
            _saveSettingsToFirestore();
          }),

          const SizedBox(height: 16),
          const Text(
            "Store Visibility",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          _switchTile("Show profile to buyers", showProfileToBuyers, (val) {
            setState(() => showProfileToBuyers = val);
            _saveSettingsToFirestore();
          }),
          _switchTile(
            "Display store performance stats publicly",
            showStoreStatsPublicly,
            (val) {
              setState(() => showStoreStatsPublicly = val);
              _saveSettingsToFirestore();
            },
          ),

          const SizedBox(height: 16),
          const Text(
            "Activity Tracking",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          _switchTile("Track product views for analytics", trackProductViews, (
            val,
          ) {
            setState(() => trackProductViews = val);
            _saveSettingsToFirestore();
          }),
          _switchTile("Enable order tracking metrics", trackOrderPerformance, (
            val,
          ) {
            setState(() => trackOrderPerformance = val);
            _saveSettingsToFirestore();
          }),

          const SizedBox(height: 16),
          const Text("Security", style: TextStyle(fontWeight: FontWeight.bold)),
          _switchTile("Remember this device for login", rememberDevice, (val) {
            setState(() => rememberDevice = val);
            _saveSettingsToFirestore();
          }),
        ],
      ),
    );
  }

  Widget _switchTile(String title, bool value, Function(bool) onChanged) {
    return SwitchListTile(
      title: Text(title),
      value: value,
      activeColor: Colors.green,
      onChanged: onChanged,
    );
  }
}
