

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:saunders/core/utils/app_color.dart';
import '../../model/invoice_data_model.dart';
import '../../provider/invoice_tab_provider.dart';
import '../widget/background.dart';
import '../widget/header.dart';
import '../widget/invoice_card.dart';
import '../widget/tab_item.dart';
import '../widget/total_due_card.dart';

class PaymentScreen extends ConsumerWidget {
  const PaymentScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedTab = ref.watch(invoiceTabProvider);
    final invoices = ref.watch(invoiceListProvider);

    final filteredInvoices = switch (selectedTab) {
      InvoiceTab.paid =>
          invoices.where((e) => e.status == "Paid").toList(),
      InvoiceTab.due =>
          invoices.where((e) => e.status == "Overdue").toList(),
      _ => invoices,
    };

    return Scaffold(
      backgroundColor: AppColor.background,
      body: Stack(
        children: [
          Background(),

          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Header(context),
                TotalDueCard(),
                SizedBox(height: 14.h),

                /// Tabs
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20.w),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Row(
                    children: [
                      TabItem(
                        title: "All",
                        isActive: selectedTab == InvoiceTab.all,
                        onTap: () =>
                        ref.read(invoiceTabProvider.notifier).state =
                            InvoiceTab.all,
                      ),
                      TabItem(
                        title: "Paid",
                        isActive: selectedTab == InvoiceTab.paid,
                        onTap: () =>
                        ref.read(invoiceTabProvider.notifier).state =
                            InvoiceTab.paid,
                      ),
                      TabItem(
                        title: "Due",
                        isActive: selectedTab == InvoiceTab.due,
                        onTap: () =>
                        ref.read(invoiceTabProvider.notifier).state =
                            InvoiceTab.due,
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 12.h),

                /// Invoice List
                Expanded(
                  child: ListView.separated(
                    padding: EdgeInsets.only(bottom: 20.h),
                    itemCount: filteredInvoices.length,
                    separatorBuilder: (_, _) => SizedBox(height: 10.h),
                    itemBuilder: (_, index) {
                      final invoice = filteredInvoices[index];
                      return InvoiceCard(
                        amount: invoice.amount,
                        status: invoice.status,
                        date: invoice.date,
                      );
                    },
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





















