import 'package:ase/generated/locale_keys.g.dart';
import 'package:ase/main.dart';
import 'package:ase/presentation/constants/color_constants.dart';
import 'package:ase/presentation/courier/pages/scan/utils/barcode_at_center.dart';
import 'package:ase/presentation/widgets/text/app_text.dart';
import 'package:ase/router/app_router.dart';
import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

@RoutePage(name: 'ScanRoute')
class ScanPage extends StatefulWidget {
  const ScanPage({super.key});

  @override
  State<ScanPage> createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
  Barcode? _barcode;
  bool _isProcessing = false;
  final MobileScannerController _scannerController = MobileScannerController(
    facing: CameraFacing.back,
  );
  Widget _buildBarcode(Barcode? value) {
    if (value == null) {
      return const Text(
        '',
        overflow: TextOverflow.fade,
        style: TextStyle(color: Colors.white),
      );
    }

    return Text(
      value.displayValue ?? 'No display value.',
      overflow: TextOverflow.fade,
      style: const TextStyle(color: Colors.white),
    );
  }

  Future<void> _handleBarcode(BarcodeCapture barcodeCapture) async {
    if (_isProcessing) return;

    if (mounted) {
      setState(() {
        final orientation =
            MediaQuery.of(context).orientation == Orientation.portrait
                ? DeviceOrientation.portraitUp
                : DeviceOrientation.landscapeLeft;

        _barcode = findBarcodeAtCenter(barcodeCapture, orientation);
      });

      if (_barcode != null && _barcode!.displayValue != null) {
        final orderCode = _barcode!.displayValue!;
        _isProcessing = true; // İşlem başladığında flag'i true yap
        _scannerController.stop(); // Kamerayı durdur
        if (mounted) {
          bool? result = await getIt<AppRouter>()
              .push<bool>(ScanDetailRoute(orderCode: orderCode));
          if (mounted && (result ?? false) == true) {
            _scannerController.start(); // Kamerayı tekrar aç
          }
        }
        _isProcessing = false;
      }
    }
  }

  @override
  void dispose() {
    _scannerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.black,
      body: CustomScrollView(
        physics: const NeverScrollableScrollPhysics(),
        slivers: [
          SliverAppBar(
            backgroundColor: ColorConstants.black,
            pinned: true,
            leading: CloseButton(
              color: ColorConstants.white,
            ),
          ),
          SliverFillRemaining(
            child: Stack(
              children: [
                MobileScanner(
                  onDetect: _handleBarcode,
                  controller: _scannerController,
                ),
                LayoutBuilder(
                  builder: (context, constraints) {
                    return SizedBox(
                      width: constraints.maxWidth,
                      height: constraints.maxHeight,
                      child: CustomPaint(
                        painter: ScannerOverlayPainter(),
                      ),
                    );
                  },
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: AppText(
                    title: LocaleKeys.general_scan_barcode.tr(),
                    textType: TextType.header,
                    color: ColorConstants.white,
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    alignment: Alignment.bottomCenter,
                    height: 100,
                    color: const Color.fromRGBO(0, 0, 0, 0.4),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(child: Center(child: _buildBarcode(_barcode))),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ScannerOverlayPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = ColorConstants.black.withValues(alpha: 0.6)
      ..style = PaintingStyle.fill;

    final cutoutWidth = size.width * 0.7;
    final cutoutHeight = size.width * 0.7;
    final borderRadius = 14.0;
    final cutoutOffset = Offset(
      (size.width - cutoutWidth) / 2,
      (size.height - cutoutHeight) / 2,
    );

    // Dış alanı oluştur
    Path backgroundPath = Path()
      ..addRect(Rect.fromLTWH(0, 0, size.width, size.height));

    // Ortadaki şeffaf alanı belirle
    Path cutoutPath = Path()
      ..addRRect(RRect.fromLTRBR(
        cutoutOffset.dx,
        cutoutOffset.dy,
        cutoutOffset.dx + cutoutWidth,
        cutoutOffset.dy + cutoutHeight,
        Radius.circular(borderRadius),
      ));

    // Kesme işlemi
    backgroundPath =
        Path.combine(PathOperation.difference, backgroundPath, cutoutPath);

    // Çizimi uygula
    canvas.drawPath(backgroundPath, paint);

    // Beyaz çerçeve çiz
    final borderPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;

    canvas.drawRRect(
      RRect.fromLTRBR(
        cutoutOffset.dx,
        cutoutOffset.dy,
        cutoutOffset.dx + cutoutWidth,
        cutoutOffset.dy + cutoutHeight,
        Radius.circular(borderRadius),
      ),
      borderPaint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
