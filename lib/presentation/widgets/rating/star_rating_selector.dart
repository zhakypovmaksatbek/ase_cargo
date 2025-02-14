import 'package:ase/presentation/constants/asset_constants.dart';
import 'package:ase/presentation/constants/color_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class StarRatingSelector extends StatefulWidget {
  final int initialRating;
  final Color color;
  final double size;
  final ValueChanged<int> onRatingSelected;

  const StarRatingSelector({
    super.key,
    required this.initialRating,
    this.color = ColorConstants.yellow,
    this.size = 24,
    required this.onRatingSelected,
  });

  @override
  State<StarRatingSelector> createState() => _StarRatingSelectorState();
}

class _StarRatingSelectorState extends State<StarRatingSelector> {
  int _currentRating = 0;

  @override
  void initState() {
    super.initState();
    _currentRating = widget.initialRating; // Başlangıçta verilen puanı atıyoruz
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(5, (index) {
        return GestureDetector(
          onTap: () {
            setState(() {
              _currentRating =
                  index + 1; // Kullanıcı kaç yıldız seçtiyse onu güncelle
            });
            widget.onRatingSelected(_currentRating); // Seçimi geri döndür
          },
          child: SvgPicture.asset(
            AssetConstants.ratingStar.svg,
            height: widget.size,
            colorFilter: ColorFilter.mode(
              index < _currentRating
                  ? widget.color
                  : Colors.grey, // Seçilmiş yıldızlar renkli, diğerleri gri
              BlendMode.srcIn,
            ),
          ),
        );
      }),
    );
  }
}
