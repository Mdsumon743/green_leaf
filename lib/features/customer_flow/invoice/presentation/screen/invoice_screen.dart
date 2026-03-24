import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:saunders/core/constants/icon_path.dart';
import 'package:saunders/core/constants/image_path.dart';
import 'package:saunders/core/global/curve_clipper.dart';
import 'package:saunders/core/global/custom_text.dart';

import '../../../../../core/utils/app_color.dart';



// ── Models ────────────────────────────────────────────────────────────────────

enum InvoiceTab { all, paid, due }

enum InvoiceStatus { pending, paid, due }

class InvoiceModel {
  final String id;
  final String serviceName;
  final String category;
  final String timeAgo;
  final double amount;
  final InvoiceStatus status;
  final String imagePath;

  const InvoiceModel({
    required this.id,
    required this.serviceName,
    required this.category,
    required this.timeAgo,
    required this.amount,
    required this.status,
    required this.imagePath,
  });

  String get statusLabel {
    switch (status) {
      case InvoiceStatus.pending:
        return 'Pending';
      case InvoiceStatus.paid:
        return 'Paid';
      case InvoiceStatus.due:
        return 'Due';
    }
  }
}

// ── Providers ──────────────────────────────────────────────────────────────────

final invoiceTabProvider = StateProvider<InvoiceTab>((ref) => InvoiceTab.all);

final invoiceListProvider = Provider<List<InvoiceModel>>((ref) => [
  InvoiceModel(
    id: '001',
    serviceName: 'Garden Maintenance',
    category: 'Garden Maintenance',
    timeAgo: 'Today',
    amount: 80.00,
    status: InvoiceStatus.pending,
    imagePath: ImagePath.gardening, // swap to your asset
  ),
  InvoiceModel(
    id: '002',
    serviceName: 'Hedge Trimming',
    category: 'Ground Maintenance',
    timeAgo: '2 days ago',
    amount: 60.00,
    status: InvoiceStatus.paid,
    imagePath: ImagePath.gardening,
  ),
  InvoiceModel(
    id: '003',
    serviceName: 'Lawn Mowing',
    category: 'Hedge Trimming',
    timeAgo: '2 weeks ago',
    amount: 120.00,
    status: InvoiceStatus.due,
    imagePath: ImagePath.gardening,
  ),
  InvoiceModel(
    id: '004',
    serviceName: 'Tree Pruning',
    category: 'Tree Services',
    timeAgo: '1 month ago',
    amount: 200.00,
    status: InvoiceStatus.paid,
    imagePath: ImagePath.gardening,
  ),
]);

final filteredInvoicesProvider = Provider<List<InvoiceModel>>((ref) {
  final tab = ref.watch(invoiceTabProvider);
  final all = ref.watch(invoiceListProvider);
  return switch (tab) {
    InvoiceTab.paid => all.where((e) => e.status == InvoiceStatus.paid).toList(),
    InvoiceTab.due  => all.where((e) => e.status == InvoiceStatus.due).toList(),
    _               => all,
  };
});

// ── Colors ─────────────────────────────────────────────────────────────────────

class _C {
  static const primary       = Color(0xFF3A7A35);

  static const gradientStart = Color(0xFF2E6B2E);
  static const gradientEnd   = Color(0xFF6CAF4A);
  static const scaffoldBg    = Color(0xFFF5F9F3);

  static const textDark      = Color(0xFF1C2B1C);
  static const textMid       = Color(0xFF4A5E4A);
  static const textLight     = Color(0xFF9AB09A);
  static const cardBorder    = Color(0xFFE8F0E5);
  static const balanceBg     = Color(0xFF2E6324);

  // status badge colours
  static const pendingBg     = Color(0xFFFFF3E0);
  static const pendingText   = Color(0xFFFAAD14);
  static const paidBg        = Color(0xFFE8F5E9);
  static const paidText      = Color(0xFF188220);
  static const dueBg         = Color(0xFFFFEBEE);
  static const dueText       = Color(0xFFFF6164);
}

// ── Screen ─────────────────────────────────────────────────────────────────────

class InvoiceScreen extends ConsumerWidget {
  const InvoiceScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedTab = ref.watch(invoiceTabProvider);
    final filteredInvoices = ref.watch(filteredInvoicesProvider);

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          /// 1. TOP BACKGROUND IMAGE
          Positioned.fill(
            child: Align(
              alignment: Alignment.topCenter,
              child: Image.asset(
                ImagePath.roleBackground, // Consistent background
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

              // AppBar (Centered Title)
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
                        child: Image.asset(
                          IconPath.arrowLeft,
                          height: 24.h,
                          width: 24.w,
                        ),
                      ),
                    ),
                    const Spacer(),
                    CustomText(
                      text: 'Invoice & Earning',
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                    const Spacer(),
                    SizedBox(width: 34.w), // Balance for back icon
                  ],
                ),
              ),

              SizedBox(height: 25.h),

              // ── Curved Content Area ──
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
                          AppColor.containerBackground, // Consistent mint/white
                          AppColor.containerBackground,
                          AppColor.containerBackground.withValues(alpha: 0.8),
                          Colors.transparent,
                        ],
                        stops: const [0.0, 0.7, 0.8, 1.0],
                      ),
                    ),
                    child: Column(
                      children: [
                        SizedBox(height: 60.h), // Offset for curve peak

                        // ── Total Balance card ──
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.w),
                          child: _TotalBalanceCard(),
                        ),

                        SizedBox(height: 16.h),

                        // ── Tabs ──
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.w),
                          child: _TabBar(selectedTab: selectedTab, ref: ref),
                        ),

                        SizedBox(height: 14.h),

                        // ── Invoice list ──
                        Expanded(
                          child: filteredInvoices.isEmpty
                              ? _EmptyState()
                              : ListView.separated(
                            padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 100.h),
                            itemCount: filteredInvoices.length,
                            separatorBuilder: (_, __) => SizedBox(height: 12.h),
                            itemBuilder: (_, i) => _InvoiceCard(invoice: filteredInvoices[i]),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ── Total Balance Card ──
class _TotalBalanceCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFF126A19),
        borderRadius: BorderRadius.circular(14.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(
                text: 'Total Balance',
                fontSize: 14.sp,
                color: Colors.white.withValues(alpha: 0.8),
              ),
              CustomText(
                text: '£150.00',
                fontSize: 26.sp,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Container(
            height: 1,
            color: Colors.white.withValues(alpha: 0.2),
          ),
          SizedBox(height: 12.h),
          CustomText(
            text: 'Last Payment: £30.00 Paid on 5th July',
            fontSize: 12.sp,
            color: Colors.white.withValues(alpha: 0.9),
          ),
        ],
      ),
    );
  }
}

// ── Tab Bar ────────────────────────────────────────────────────────────────────

class _TabBar extends StatelessWidget {
  final InvoiceTab selectedTab;
  final WidgetRef ref;

  const _TabBar({required this.selectedTab, required this.ref});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48.h, // Increased height to account for the pointer
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          // The Main Tab Container
          Container(
            height: 42.h,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(6.r), // Sharper corners per image
              border: Border.all(color: const Color(0xFFD1D5DB), width: 1), // Light grey border
            ),
            child: Row(
              children: [
                _Tab(
                  label: 'All',
                  isSelected: selectedTab == InvoiceTab.all,
                  onTap: () => ref.read(invoiceTabProvider.notifier).state = InvoiceTab.all,
                ),
                // Vertical Divider
                Container(width: 1, color: const Color(0xFFD1D5DB)),
                _Tab(
                  label: 'Paid',
                  isSelected: selectedTab == InvoiceTab.paid,
                  onTap: () => ref.read(invoiceTabProvider.notifier).state = InvoiceTab.paid,
                ),
                // Vertical Divider
                Container(width: 1, color: const Color(0xFFD1D5DB)),
                _Tab(
                  label: 'Due',
                  isSelected: selectedTab == InvoiceTab.due,
                  onTap: () => ref.read(invoiceTabProvider.notifier).state = InvoiceTab.due,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Tab extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _Tab({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.center,
          children: [
            // The Tab Background
            AnimatedContainer(
              duration: const Duration(milliseconds: 180),
              // Image shows the selected tab fills the height but has slight side margins
              margin: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: isSelected ? const Color(0xFF0E4B16) : Colors.transparent, // Dark Green
                borderRadius: BorderRadius.circular(4.r),
              ),
              child: CustomText(
                text: label,
                fontSize: 14.sp,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                color: isSelected ? Colors.white : const Color(0xFF6B7280),
              ),
            ),

            // The Pointer (Triangle)
            if (isSelected)
              Positioned(
                bottom: -10.h, // Positioned below the container
                child: CustomPaint(
                  size: Size(16.w, 8.h),
                  painter: TabPointerPainter(const Color(0xFF0E4B16)),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
class TabPointerPainter extends CustomPainter {
  final Color color;
  const TabPointerPainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final path = Path();
    // Draws a triangle pointing downwards
    path.moveTo(0, 0);
    path.lineTo(size.width / 2, size.height);
    path.lineTo(size.width, 0);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
// ── Invoice Card ───────────────────────────────────────────────────────────────

class _InvoiceCard extends StatelessWidget {
  final InvoiceModel invoice;
  _InvoiceCard({required this.invoice});

  // Updated to Dollar as requested previously
  final currencyFormat = NumberFormat.currency(locale: 'en_GB', symbol: '£');

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18.r), // Softer corners per image
        border: Border.all(color: const Color(0xFFE5E7EB), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── TOP SECTION: Image, Info, Amount ──
          Padding(
            padding: EdgeInsets.all(12.w),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 1. Thumbnail
                ClipRRect(
                  borderRadius: BorderRadius.circular(12.r),
                  child: Image.asset(
                    invoice.imagePath,
                    width: 63.w, // Slightly larger per image ratio
                    height: 58.h,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(width: 12.w),

                // 2. Title and Time
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        text: invoice.serviceName,
                        fontSize: 16.sp, // Match image heading size
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                      SizedBox(height: 4.h),
                      CustomText(
                        text: invoice.timeAgo,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xFF4A4E5A),
                      ),
                    ],
                  ),
                ),

                // 3. Amount (Moved to top row per image)
                _StatusBadge(status: invoice.status),
                SizedBox(height: 12.h),
              ],
            ),
          ),

          // ── MIDDLE SECTION: Invoice # ──
          Row(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.w),
                child: CustomText(
                  text: 'Invoice #${invoice.id}',
                  fontSize: 12.sp,
                  color: const Color(0xFF4A4E5A),
                  fontWeight: FontWeight.w400,
                ),
              ),
              Spacer(),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.w),
                child: CustomText(
                  text: currencyFormat.format(invoice.amount),
                  fontSize: 20.sp, // Large and bold in image
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF25272C),
                ),
              ),
            ],
          ),

          SizedBox(height: 12.h),
          const Divider(height: 1, color: Color(0xFFF3F4F6)),

          // ── BOTTOM SECTION: Category & View Details ──
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(
                  text: invoice.category,
                  fontSize: 12.sp,
                  color: const Color(0xFF4A4E5A),
                ),
                GestureDetector(
                  onTap: () => context.push("/invoiceDetails"),
                  child: Row(
                    children: [
                      CustomText(
                        text: 'View Details',
                        fontSize: 12.sp,
                        color: const Color(0xFF4A4E5A), // Darker grey in image
                      ),
                      SizedBox(width: 4.w),
                      Icon(Icons.arrow_forward_ios_rounded,
                          color: const Color(0xFF4A4E5A), size: 12.sp),
                    ],
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

// ── Status Badge ───────────────────────────────────────────────────────────────

class _StatusBadge extends StatelessWidget {
  final InvoiceStatus status;
  const _StatusBadge({required this.status});

  @override
  Widget build(BuildContext context) {
    Color bg, text;
    switch (status) {
      case InvoiceStatus.pending:
        bg = _C.pendingText ; text = Colors.white;
      case InvoiceStatus.paid:
        bg = _C.paidText;    text = Colors.white;
      case InvoiceStatus.due:
        bg = _C.dueText;     text = Colors.white;
    }

    String label;
    switch (status) {
      case InvoiceStatus.pending: label = 'Pending';
      case InvoiceStatus.paid:    label = 'Paid';
      case InvoiceStatus.due:     label = 'Due';
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: CustomText(
       text:  label,

          fontSize: 11.sp,
          fontWeight: FontWeight.w600,
          color: text,

      ),
    );
  }
}

// ── Empty State ────────────────────────────────────────────────────────────────

class _EmptyState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.receipt_long_outlined, color: _C.textLight, size: 52.r),
          SizedBox(height: 12.h),
          CustomText(text: 'No invoices found',

                  fontSize: 15.sp,
                  fontWeight: FontWeight.w600,
                  color: _C.textMid),
          SizedBox(height: 5.h),
          CustomText(text: 'Try a different filter tab.',
             fontSize: 12.sp, color: _C.textLight),
        ],
      ),
    );
  }
}



