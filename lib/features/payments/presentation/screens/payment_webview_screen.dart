import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:starchitects_app/core/constants/app_colors.dart';
import 'package:starchitects_app/core/theme/text_styles.dart';
import 'package:webview_flutter/webview_flutter.dart';

/// WebView screen for Chargily payment checkout.
/// Loads the Chargily checkout URL and monitors navigation
/// for success/failure callback patterns.
class PaymentWebviewScreen extends StatefulWidget {
  final String checkoutUrl;
  final String paymentId;

  const PaymentWebviewScreen({
    super.key,
    required this.checkoutUrl,
    required this.paymentId,
  });

  @override
  State<PaymentWebviewScreen> createState() => _PaymentWebviewScreenState();
}

class _PaymentWebviewScreenState extends State<PaymentWebviewScreen> {
  late final WebViewController _controller;
  bool _isLoading = true;
  int _loadingProgress = 0;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(AppColors.background)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (url) {
            if (mounted) setState(() => _isLoading = true);
          },
          onPageFinished: (url) {
            if (mounted) setState(() => _isLoading = false);
          },
          onProgress: (progress) {
            if (mounted) setState(() => _loadingProgress = progress);
          },
          onNavigationRequest: (request) {
            final url = request.url.toLowerCase();

            // Check for success callback pattern
            if (url.contains('payment/success') ||
                url.contains('payment-success') ||
                url.contains('status=paid') ||
                url.contains('checkout/success')) {
              _navigateToResult(success: true);
              return NavigationDecision.prevent;
            }

            // Check for failure callback pattern
            if (url.contains('payment/failure') ||
                url.contains('payment-failed') ||
                url.contains('status=failed') ||
                url.contains('checkout/failure') ||
                url.contains('payment/cancel')) {
              _navigateToResult(success: false);
              return NavigationDecision.prevent;
            }

            return NavigationDecision.navigate;
          },
          onWebResourceError: (error) {
            // Handle web resource errors gracefully
            // Handle web resource errors gracefully
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.checkoutUrl));
  }

  void _navigateToResult({required bool success}) {
    if (!mounted) return;
    context.pushReplacement(
      '/payment-result',
      extra: {
        'paymentId': widget.paymentId,
        'success': success,
      },
    );
  }

  Future<bool> _onWillPop() async {
    final shouldLeave = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.backgroundLight,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(
            color: AppColors.primary.withValues(alpha: 0.3),
          ),
        ),
        title: Text(
          'payments.cancel_title'.tr(),
          style: AppTextStyles.headlineSmall,
          textAlign: TextAlign.center,
        ),
        content: Text(
          'payments.cancel_confirm'.tr(),
          style: AppTextStyles.bodyMedium.copyWith(
            color: AppColors.textSecondary,
          ),
          textAlign: TextAlign.center,
        ),
        actionsAlignment: MainAxisAlignment.center,
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(
              'common.continue'.tr(),
              style: GoogleFonts.cairo(
                color: AppColors.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text(
              'common.cancel'.tr(),
              style: GoogleFonts.cairo(
                color: AppColors.error,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );

    return shouldLeave ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) async {
        if (didPop) return;
        final shouldPop = await _onWillPop();
        if (shouldPop && mounted) {
          context.pop();
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          backgroundColor: AppColors.backgroundLight,
          elevation: 0,
          title: Text(
            'payments.secure_payment'.tr(),
            style: AppTextStyles.titleLarge,
          ),
          leading: IconButton(
            icon: const Icon(
              Icons.close_rounded,
              color: AppColors.textPrimary,
            ),
            onPressed: () async {
              final shouldPop = await _onWillPop();
              if (shouldPop && mounted) {
                context.pop();
              }
            },
          ),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(3),
            child: _isLoading
                ? LinearProgressIndicator(
                    value: _loadingProgress / 100,
                    backgroundColor: AppColors.surface,
                    valueColor: const AlwaysStoppedAnimation<Color>(
                      AppColors.primary,
                    ),
                    minHeight: 3,
                  )
                : const SizedBox(height: 3),
          ),
        ),
        body: Stack(
          children: [
            WebViewWidget(controller: _controller),

            // Loading overlay
            if (_isLoading)
              Container(
                color: AppColors.background.withValues(alpha: 0.7),
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(
                        width: 48,
                        height: 48,
                        child: CircularProgressIndicator(
                          strokeWidth: 3,
                          color: AppColors.primary,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        'payments.loading_checkout'.tr(),
                        style: AppTextStyles.bodyMedium.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
