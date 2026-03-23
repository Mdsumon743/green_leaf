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
      // ResizeToAvoidBottomInset ensures the garden image stays put when keyboard opens
      resizeToAvoidBottomInset: true,
      body: Stack(
        fit: StackFit.expand,
        children: [
          /// 1. TOP BACKGROUND IMAGE
          Align(
            alignment: Alignment.topCenter,
            child: Image.asset(
              ImagePath.quoteBackground,
              width: double.infinity,
              fit: BoxFit.fitWidth,
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

          /// 3. OVERLAY
          Container(
            color: Colors.black.withValues(alpha: 0.35),
          ),

          /// 4. MAIN UI
          Column(
            children: [
              /// AppBar
              SafeArea(
                bottom: false,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(16.w, 10.h, 16.w, 0),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () => context.pop(),
                        child: Container(
                          width: 34.w,
                          height: 34.h,
                          alignment: Alignment.center,
                          child: Image.asset(IconPath.arrowLeft,height: 24.h,width: 24.w,)
                        ),
                      ),
                      Expanded(
                        child: Text(
                          'Message',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 19.sp,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(width: 34.w),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 25.h),

              /// Message List Container
              /// Message List Container with Fading Background
              Expanded(
                child: ClipPath(
                  clipper: CurveClipper(),
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      // Instead of a solid color, we use a gradient that ends in transparent
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          const Color(0xFFEDFFE8),           // Solid light green at top
                          const Color(0xFFEDFFE8),
                          const Color(0xFFEDFFE8).withValues(alpha: 0.8), // Slightly fading
                          Colors.transparent,                // Completely clear at the bottom
                        ],
                        stops: const [0.0, 0.75,0.85, 1.0], // Card starts fading 60% of the way down
                      ),
                    ),
                    // We keep the ShaderMask on the child (ListView) to make sure
                    // the messages also fade out along with the background.
                    child: ListView.builder(
                      controller: _scrollController,
                      padding: EdgeInsets.fromLTRB(16.w, 50.h, 16.w, 60.h),
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

              /// Input Bar Section
              Container(
                color: Colors.transparent, // Keep garden visible behind input
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).padding.bottom + 10.h,
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