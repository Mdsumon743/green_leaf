


import 'dart:io';

enum ServiceStatus { pending, completed, cancel }

class CustomerServiceModel {
  final String id;
  final String title;
  final String quoteNumber;
  final double price;
  final ServiceStatus status;
  final String preferDate;
  final String address;
  final String jobDescription;
  final List<File> beforePhotos;
  final List<File> afterPhotos;

  const CustomerServiceModel({
    required this.id,
    required this.title,
    required this.quoteNumber,
    required this.price,
    required this.status,
    required this.preferDate,
    required this.address,
    required this.jobDescription,
    this.beforePhotos = const [],
    this.afterPhotos = const [],
  });

  CustomerServiceModel copyWith({
    String? id,
    String? title,
    String? quoteNumber,
    double? price,
    ServiceStatus? status,
    String? preferDate,
    String? address,
    String? jobDescription,
    List<File>? beforePhotos,
    List<File>? afterPhotos,
  }) {
    return CustomerServiceModel(
      id: id ?? this.id,
      title: title ?? this.title,
      quoteNumber: quoteNumber ?? this.quoteNumber,
      price: price ?? this.price,
      status: status ?? this.status,
      preferDate: preferDate ?? this.preferDate,
      address: address ?? this.address,
      jobDescription: jobDescription ?? this.jobDescription,
      beforePhotos: beforePhotos ?? this.beforePhotos,
      afterPhotos: afterPhotos ?? this.afterPhotos,
    );
  }
}