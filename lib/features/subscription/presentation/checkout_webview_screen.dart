import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_colors.dart';

class CheckoutWebviewScreen extends StatefulWidget {
  final String checkoutUrl;
  const CheckoutWebviewScreen({super.key, required this.checkoutUrl});

  @override
  State<CheckoutWebviewScreen> createState() => _CheckoutWebviewScreenState();
}

class _CheckoutWebviewScreenState extends State<CheckoutWebviewScreen> {
  late final WebViewController _controller;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageFinished: (String url) {
            setState(() => _isLoading = false);
          },
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.contains('/payment/success') || request.url.contains('status=paid')) {
              _handleSuccess();
              return NavigationDecision.prevent;
            } else if (request.url.contains('/payment/cancel') || request.url.contains('status=canceled')) {
              _handleCancel();
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.checkoutUrl));
  }

  void _handleSuccess() {
    context.pop();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('نجاح'),
        content: const Text('تم الدفع بنجاح!'),
        actions: [
          TextButton(
            onPressed: () {
              context.pop();
            },
            child: const Text('حسناً'),
          ),
        ],
      ),
    );
  }

  void _handleCancel() {
    context.pop();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('تم إلغاء الدفع')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('الدفع')),
      body: Stack(
        children: [
          WebViewWidget(controller: _controller),
          if (_isLoading) const Center(child: CircularProgressIndicator(color: AppColors.kGold)),
        ],
      ),
    );
  }
}
