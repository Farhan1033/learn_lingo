import 'package:learn_lingo/core/models/redeem_api.dart';
import 'package:learn_lingo/core/models/reward_api.dart';
import 'package:learn_lingo/core/service/redeem_models.dart';
import 'package:learn_lingo/core/service/reward_models.dart';
import 'package:learn_lingo/core/theme/button_app.dart';
import 'package:learn_lingo/core/theme/color_primary.dart';
import 'package:learn_lingo/core/theme/typography.dart';
import 'package:learn_lingo/core/utils/shared_preferences.dart';
import 'package:flutter/material.dart';

class RewardProvider with ChangeNotifier {
  bool _isLoading = false;
  String? _hasError;
  RewardApi? _rewardApi;
  RedeemApi? _redeemApi;

  final RewardModels _rewardModels = RewardModels();
  final RedeemModels _redeemModels = RedeemModels();

  // Getter
  bool get isLoading => _isLoading;
  String? get hasError => _hasError;
  RewardApi? get rewardApi => _rewardApi;
  RedeemApi? get redeemApi => _redeemApi;

  // Setter
  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void setError(String? value) {
    _hasError = value;
    notifyListeners();
  }

  void setReward(RewardApi? value) {
    _rewardApi = value;
    notifyListeners();
  }

  void setRedeem(RedeemApi? value) {
    _redeemApi = value;
    notifyListeners();
  }

  // Clean data
  void cleanData() {
    setError(null);
    setReward(null);
    setRedeem(null);
  }

  // Fetch rewards
  Future<void> reward() async {
    setLoading(true);
    setError(null);

    try {
      final token = await Token().getToken();
      final rewardData =
          await _rewardModels.rewardModels(token ?? 'Token Not Found!');
      if (rewardData != null) {
        setReward(rewardData);
      } else {
        setError('Failed to fetch rewards: No data returned.');
      }
    } catch (e) {
      setError(e.toString());
      // cleanData();
    } finally {
      setLoading(false);
    }
  }

// Redeem reward
  Future<bool> redeem(String jenisReward) async {
    setLoading(true);
    setError(null);

    try {
      final token = await Token().getToken();
      final redeemData = await _redeemModels.redeemReward(
        token ?? 'Token Not Found!',
        jenisReward,
      );

      if (redeemData != null && redeemData.statusCode == 200) {
        setRedeem(redeemData);
        return true; // Menandakan berhasil
      } else {
        setError(redeemData?.message ?? 'Redeem failed: Unknown error.');
        return false; // Menandakan gagal
      }
    } catch (e) {
      setError(e.toString());
      // cleanData();
      return false; // Menandakan gagal
    } finally {
      setLoading(false);
    }
  }

  Future<void> showDialogRedeem(BuildContext context, String imageItem,
      String title, int poin, String description, String term) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Row(
            children: [
              SizedBox(
                width: 60,
                height: 60,
                child: Image.asset(imageItem),
              ),
              const SizedBox(width: 10),
              Flexible(
                fit: FlexFit.loose,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Tipografi().s2(
                      isiText: title,
                      warnaFont: Warna.netral1,
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Tipografi().C(
                          isiText: 'Poin',
                          warnaFont: Warna.netral1,
                        ),
                        Tipografi().C(
                          isiText: poin.toString(),
                          warnaFont: Warna.netral1,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Tipografi().s2(
                  isiText: 'Description Item',
                  warnaFont: Warna.netral1,
                ),
                const SizedBox(height: 8),
                Tipografi().C(
                  isiText: description,
                  warnaFont: Warna.netral1,
                ),
                const SizedBox(height: 8),
                Tipografi().s2(
                  isiText: 'Term Item',
                  warnaFont: Warna.netral1,
                ),
                const SizedBox(height: 8),
                Tipografi().C(
                  isiText: term,
                  warnaFont: Warna.netral1,
                ),
              ],
            ),
          ),
          actions: [
            Tombol().TextLarge(
              teksTombol: 'Tutup',
              lebarTombol: double.infinity,
              navigasiTombol: () {
                Navigator.pop(context);
              },
            ),
            Tombol().primarySmall(
              teksTombol: 'Redeem',
              lebarTombol: double.infinity,
              navigasiTombol: () async {
                final isSuccess = await redeem(title);
                if (isSuccess) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(redeemApi?.message ?? 'Redeem successful'),
                      backgroundColor: Warna.benar,
                      duration: const Duration(seconds: 5),
                    ),
                  );
                  reward(); // Memperbarui reward setelah redeem berhasil
                  Navigator.pop(context);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                          hasError ?? 'Not enough points to redeem reward'),
                      backgroundColor: Warna.salah,
                      duration: const Duration(seconds: 3),
                    ),
                  );
                  Navigator.pop(context);
                }
              },
            )
          ],
        );
      },
    );
  }
}
