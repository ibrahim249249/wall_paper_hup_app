import 'package:wall_paper_hub_app/model/categories_model.dart';

String apiKey = '3aP58WlbMAx81rwdrL5JrD0XbiPbJ3g542gppZZW8U5VYRyhSeHTODnU';
List<CategoriesModel> getCategories() {
  List<CategoriesModel> categories = [];
  CategoriesModel categoriesModel = CategoriesModel();

  categoriesModel.imgUrl =
      'https://images.pexels.com/photos/545008/pexels-photo-545008.jpeg?compress&cs=tinysrgb&dpr=2&w=500';
  categoriesModel.catrgorieName = 'Steet Art';
  categories.add(categoriesModel);
  categoriesModel = CategoriesModel();

  categoriesModel.imgUrl =
      'https://images.pexels.com/photos/704320/pexels-photo-704320.jpeg?auto=compress&cs=tinysrgb&dpr=2&w=500';
  categoriesModel.catrgorieName = 'Wild Life';
  categories.add(categoriesModel);
  categoriesModel = CategoriesModel();

  categoriesModel.imgUrl =
      'https://images.pexels.com/photos/34950/pexels-photo.jpg?auto=compress&cs=tinysrgb&dpr=2&w=500';
  categoriesModel.catrgorieName = 'Nature';
  categories.add(categoriesModel);
  categoriesModel = CategoriesModel();

  categoriesModel.imgUrl =
      'https://images.pexels.com/photos/466685/pexels-photo-466685.jpeg?compress&cs=tinysrgb&dpr=2&w=500';
  categoriesModel.catrgorieName = 'City';
  categories.add(categoriesModel);
  categoriesModel = CategoriesModel();

  categoriesModel.imgUrl =
      'https://images.pexels.com/photos/1434819/pexels-photo-1434819.jpeg?compress&cs=tinysrgb&dpr=750&w=120';
  categoriesModel.catrgorieName = 'Motivation';
  categories.add(categoriesModel);
  categoriesModel = CategoriesModel();
  //'https://images.pexels.com/photos/30516945/pexels-photo-30516945.jpeg'
  categoriesModel.imgUrl =
      'https://images.pexels.com/photos/2116475/pexels-photo-2116475.jpeg';
  categoriesModel.catrgorieName = 'Bike';
  categories.add(categoriesModel);
  categoriesModel = CategoriesModel();

  categoriesModel.imgUrl =
      'https://images.pexels.com/photos/1149137/pexels-photo-1149137.jpeg';
  categoriesModel.catrgorieName = 'Cars';
  categories.add(categoriesModel);
  categoriesModel = CategoriesModel();

  return categories;
}
