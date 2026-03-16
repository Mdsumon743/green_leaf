import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:saunders/core/constants/image_path.dart';
import 'package:saunders/core/global/curve_clipper.dart';
import 'package:saunders/core/global/custom_text.dart';



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
  static const pendingText   = Color(0xFFF57C00);
  static const paidBg        = Color(0xFFE8F5E9);
  static const paidText      = Color(0xFF2E7D32);
  static const dueBg         = Color(0xFFFFEBEE);
  static const dueText       = Color(0xFFC62828);
}

// ── Screen ─────────────────────────────────────────────────────────────────────

class InvoiceScreen extends ConsumerWidget {
  const InvoiceScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedTab      = ref.watch(invoiceTabProvider);
    final filteredInvoices = ref.watch(filteredInvoicesProvider);

    return Scaffold(
      backgroundColor: _C.scaffoldBg,
      body: Stack(
        children: [
          // ── Green gradient header bg ─────────────────────────────────
          Positioned(
            top: 0, left: 0, right: 0,
            height: 200.h,
            child: const DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end:   Alignment.bottomRight,
                  colors: [_C.gradientStart, _C.gradientEnd],
                ),
              ),
            ),
          ),

          // ── Decorative leaves ────────────────────────────────────────
          Positioned(
            top: -10, right: -14,
            child: Opacity(
              opacity: 0.22,
              child: Icon(Icons.eco_rounded, color: Colors.white, size: 120.r),
            ),
          ),
          Positioned(
            top: 30, right: 70,
            child: Opacity(
              opacity: 0.10,
              child: Icon(Icons.eco_rounded, color: Colors.white, size: 55.r),
            ),
          ),

          // ── Main column ──────────────────────────────────────────────
          Column(
            children: [
              // AppBar
              SafeArea(
                bottom: false,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 0),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () => context.pop(),
                        child: Container(
                          width: 34.w, height: 34.h,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.18),
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          child: Icon(Icons.arrow_back_ios_new_rounded,
                              color: Colors.white, size: 15.sp),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          'Invoice & Earning',
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

              SizedBox(height: 14.h),

              // ── White rounded sheet ──────────────────────────────────
              Expanded(
                child: ClipPath(
                  clipper: CurveClipper(),
                  child: Container(
                    decoration: BoxDecoration(
                      color: _C.scaffoldBg,
                      borderRadius: BorderRadius.vertical(top: Radius.circular(28.r)),
                    ),
                    child: Column(
                      children: [
                        // ── Total Balance card ───────────────────────────
                        Container(
                          margin: EdgeInsets.fromLTRB(16.w, 60.h, 16.w, 0),
                          child: _TotalBalanceCard(),
                        ),

                        SizedBox(height: 16.h),

                        // ── Tabs ─────────────────────────────────────────
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 16.w),
                          child: _TabBar(selectedTab: selectedTab, ref: ref),
                        ),

                        SizedBox(height: 14.h),

                        // ── Invoice list ─────────────────────────────────
                        Expanded(
                          child: filteredInvoices.isEmpty
                              ? _EmptyState()
                              : ListView.separated(
                            padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 40.h),
                            itemCount: filteredInvoices.length,
                            separatorBuilder: (_, __) => SizedBox(height: 10.h),
                            itemBuilder: (_, i) =>
                                _InvoiceCard(invoice: filteredInvoices[i]),
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

// ── Total Balance Card ─────────────────────────────────────────────────────────

class _TotalBalanceCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 16.h),
      decoration: BoxDecoration(
        color: _C.balanceBg,
        borderRadius: BorderRadius.circular(14.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            text: 'Total Balance',

              fontSize: 13.sp,
              color: Colors.white.withValues(alpha: 0.85),
              fontWeight: FontWeight.w400,

          ),
          SizedBox(height: 4.h),
          CustomText(
           text:  '€150.00',

              fontSize: 28.sp,
              fontWeight: FontWeight.w700,
              color: Colors.white,

          ),
          SizedBox(height: 8.h),
          Container(
            height: 1,
            color: Colors.white.withValues(alpha: 0.2),
          ),
          SizedBox(height: 8.h),
          CustomText(
           text:  'Last Payment: €30.00 Paid on 5th july',

              fontSize: 12.sp,
              color: Colors.white.withValues(alpha: 0.75),

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
      height: 42.h,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: _C.cardBorder, width: 1),
      ),
      child: Row(
        children: [
          _Tab(
            label: 'All',
            isSelected: selectedTab == InvoiceTab.all,
            isFirst: true,
            onTap: () => ref.read(invoiceTabProvider.notifier).state = InvoiceTab.all,
          ),
          _Tab(
            label: 'Paid',
            isSelected: selectedTab == InvoiceTab.paid,
            onTap: () => ref.read(invoiceTabProvider.notifier).state = InvoiceTab.paid,
          ),
          _Tab(
            label: 'Due',
            isSelected: selectedTab == InvoiceTab.due,
            isLast: true,
            onTap: () => ref.read(invoiceTabProvider.notifier).state = InvoiceTab.due,
          ),
        ],
      ),
    );
  }
}

class _Tab extends StatelessWidget {
  final String label;
  final bool isSelected;
  final bool isFirst;
  final bool isLast;
  final VoidCallback onTap;

  const _Tab({
    required this.label,
    required this.isSelected,
    required this.onTap,
    this.isFirst = false,
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          margin: EdgeInsets.all(3.r),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: isSelected ? _C.primary : Colors.transparent,
            borderRadius: BorderRadius.circular(7.r),
          ),
          child: CustomText(
           text:  label,

              fontSize: 13.sp,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
              color: isSelected ? Colors.white : _C.textMid,

          ),
        ),
      ),
    );
  }
}

// ── Invoice Card ───────────────────────────────────────────────────────────────

class _InvoiceCard extends StatelessWidget {
  final InvoiceModel invoice;
   _InvoiceCard({required this.invoice});
  final currencyFormat =
  NumberFormat.currency(locale: 'en_GB', symbol: '£');

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: _C.cardBorder, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          // ── Top row: image + title + status ─────────────────────────
          Container(
            margin: EdgeInsets.fromLTRB(12.w, 12.h, 12.w, 10.h),
            child: Row(
              children: [
                // Thumbnail
                ClipRRect(
                  borderRadius: BorderRadius.circular(10.r),
                  child: SizedBox(
                    width: 52.w,
                    height: 52.h,
                    child: Image.asset(
                      invoice.imagePath,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Container(
                        color: const Color(0xFFD4E8CC),
                        child: Icon(Icons.park_rounded,
                            color: _C.primary.withValues(alpha: 0.45), size: 26),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 12.w),

                // Title + time
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                       text:  invoice.serviceName,

                          fontSize: 14.sp,
                          fontWeight: FontWeight.w700,
                          color: _C.textDark,

                      ),
                      SizedBox(height: 3.h),
                      CustomText(
                       text:  invoice.timeAgo,
                        fontSize: 12.sp, color: _C.textLight),

                    ],
                  ),
                ),

                // Status badge
                _StatusBadge(status: invoice.status),
              ],
            ),
          ),

          // ── Divider ──────────────────────────────────────────────────
          Divider(height: 1, thickness: 1, color: _C.cardBorder),

          // ── Bottom row: invoice # + amount + view details ────────────
          Container(
            margin: EdgeInsets.fromLTRB(12.w, 10.h, 12.w, 10.h),
            child: Row(
              children: [
                // Invoice number + category
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                       text:  'Invoice #${invoice.id}',

                          fontSize: 11.sp,
                          color: _C.textLight,
                          fontWeight: FontWeight.w500,

                      ),
                      SizedBox(height: 2.h),
                      CustomText(
                    text:     invoice.category,

                          fontSize: 11.sp,
                          color: _C.textLight,

                      ),
                    ],
                  ),
                ),

                // Amount
                CustomText(
                 text:  currencyFormat.format(invoice.amount),

                    fontSize: 18.sp,
                    fontWeight: FontWeight.w700,
                    color: _C.textDark,

                ),
                SizedBox(width: 12.w),

                // View Details
                GestureDetector(
                  onTap: () => context.push("/invoiceDetails"),
                  child: Row(
                    children: [
                      CustomText(
                       text:  'View Details',

                          fontSize: 11.sp,
                          color: _C.primary,
                          fontWeight: FontWeight.w600,
                      ),
                      SizedBox(width: 2.w),
                      Icon(Icons.arrow_forward_ios_rounded,
                          color: _C.primary, size: 10.sp),
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
        bg = _C.pendingBg; text = _C.pendingText;
      case InvoiceStatus.paid:
        bg = _C.paidBg;    text = _C.paidText;
      case InvoiceStatus.due:
        bg = _C.dueBg;     text = _C.dueText;
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



