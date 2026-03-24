import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:saunders/core/constants/icon_path.dart';
import 'package:saunders/core/global/curve_clipper.dart';
import '../../../../../core/constants/image_path.dart';
import '../../../../../core/utils/app_color.dart';
import '../../provider/chat_provider.dart';
import '../widget/bubble.dart';
import '../widget/date_divider.dart';
import '../widget/input_bar.dart';

class ChatScreen extends ConsumerStatefulWidget {
  const ChatScreen({super.key});

  @override
  ConsumerState<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends ConsumerState<ChatScreen> {
  final _controller = TextEditingController();
  final _scrollController = ScrollController();

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _send() {
    final text = _controller.text;
    if (text.trim().isEmpty) return;

    ref.read(chatProvider.notifier).sendMessage(text, context);
    _controller.clear();

    Future.delayed(const Duration(milliseconds: 150), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final messages = ref.watch(chatProvider);

    return Scaffold(
      backgroundColor: AppColor.scaffoldBg,
      resizeToAvoidBottomInset: true,
      body: Stack(
        fit: StackFit.expand,
        children: [
          /// 1. TOP BACKGROUND IMAGE
          Positioned.fill(
            child: Align(
              alignment: Alignment.topCenter,
              child: Image.asset(
                ImagePath.roleBackground, // Consistent with other screens
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ),

          /// 2. BOTTOM BACKGROUND IMAGE (Garden)
          Align(
            alignment: Alignment.bottomCenter,
            child: Image.asset(
              ImagePath.myQuotesDetailsBottumBG,
              width: double.infinity,
              fit: BoxFit.fitWidth,
            ),
          ),

          /// 3. MAIN UI
          Column(
            children: [
              SizedBox(height: MediaQuery.of(context).padding.top + 10.h),

              /// Header
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => context.pop(),
                      child: Container(
                        width: 34.w,
                        height: 34.h,
                        alignment: Alignment.center,
                        child: Image.asset(IconPath.arrowLeft, height: 24.h, width: 24.w),
                      ),
                    ),
                    const Spacer(),
                    Text(
                      'Message',
                      style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                    const Spacer(),
                    SizedBox(width: 34.w), // Balance for back button
                  ],
                ),
              ),

              SizedBox(height: 25.h),

              /// 4. Curved Message Area
              Expanded(
                child: ClipPath(
                  clipper: CurveClipper(),
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          AppColor.containerBackground,
                          AppColor.containerBackground,
                          AppColor.containerBackground.withValues(alpha: 0.8),
                          Colors.transparent,
                        ],
                        stops: const [0.0, 0.75, 0.9, 1.0],
                      ),
                    ),
                    child: ListView.builder(
                      controller: _scrollController,
                      // Top padding (60.h) ensures bubbles don't hide under the curve peak
                      padding: EdgeInsets.fromLTRB(16.w, 60.h, 16.w, 100.h),
                      itemCount: messages.length,
                      itemBuilder: (_, i) {
                        final msg = messages[i];
                        return Column(
                          children: [
                            if (msg.showDateDivider) const DateDivider(),
                            Bubble(message: msg),
                          ],
                        );
                      },
                    ),
                  ),
                ),
              ),

              /// 5. Input Bar Section
              Container(
                color: Colors.transparent,
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).padding.bottom + 10.h,
                  left: 16.w,
                  right: 16.w,
                ),
                child: InputBar(
                  controller: _controller,
                  onSend: _send,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}