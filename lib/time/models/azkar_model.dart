class AzkarItem {
  final String category;
  final String content;
  final String count;
  final String description;
  final String reference;

  AzkarItem({
    required this.category,
    required this.content,
    required this.count,
    required this.description,
    required this.reference,
  });

  factory AzkarItem.fromJson(Map<String, dynamic> json) {
    return AzkarItem(
      category: json['category'] ?? '',
      content: json['content'] ?? '',
      count: json['count'] ?? '',
      description: json['description'] ?? '',
      reference: json['reference'] ?? '',
    );
  }
}

class AzkarData {
  final String category;
  final List<AzkarItem> items;

  AzkarData({required this.category, required this.items});
}
