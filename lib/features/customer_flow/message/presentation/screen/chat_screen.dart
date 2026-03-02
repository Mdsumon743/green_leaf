
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
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

    ref.read(chatProvider.notifier).sendMessage(text, context);

    _controller.clear();

    Future.delayed(const Duration(milliseconds: 80), () {
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
      body: Stack(
        children: [
          /// Background Header
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: 180.h,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    AppColor.headerGradTop,
                    AppColor.headerGradBot,
                  ],
                ),
              ),
            ),
          ),

          Column(
            children: [
              /// AppBar
              SafeArea(
                bottom: false,
                child: Padding(
                  padding:
                  EdgeInsets.fromLTRB(16.w, 10.h, 16.w, 0),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () => context.pop(),
                        child: Container(
                          width: 34.w,
                          height: 34.h,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color:
                            Colors.white.withValues(alpha: 0.22),
                            borderRadius:
                            BorderRadius.circular(8.r),
                          ),
                          child: Icon(
                            Icons.arrow_back_ios_new_rounded,
                            color: Colors.white,
                            size: 15.sp,
                          ),
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

              SizedBox(height: 70.h),

              /// Message List
              Expanded(
                child: ListView.builder(
                  controller: _scrollController,
                  padding:
                  EdgeInsets.fromLTRB(16.w, 0, 16.w, 12.h),
                  itemCount: messages.length,
                  itemBuilder: (_, i) {
                    final msg = messages[i];
                    return Column(
                      children: [
                        if (msg.showDateDivider)
                          DateDivider(),
                        Bubble(message: msg),
                      ],
                    );
                  },
                ),
              ),

              /// Input Bar
              InputBar(
                controller: _controller,
                onSend: _send,
              ),
            ],
          ),
        ],
      ),
    );
  }
}