class Category {
  int? id;
  String? name;
  String? slug;
  int? parent;

  Category({this.id,this.name,this.slug,this.parent});

  Category fromMap(dynamic dynamicData) {
    return Category(
      id: dynamicData['id'],
      name: dynamicData['name'],
      slug: dynamicData['slug'],
      parent: dynamicData['parent'],
    );
  }

}