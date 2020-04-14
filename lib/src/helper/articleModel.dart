class ArticleModel {
  int id;
  String title;
  String description;
  String category;

  ArticleModel(
      {this.id,
        this.title,
        this.description,
        this.category,
      });
}

class ArticleList {
  static List<ArticleModel> list = [
    ArticleModel(
      id: 1,
      title: "How to Protect Your Heart if You Have Diabetes",
      description:
      "According to ADA, adults with diabetes are almost twice as likely to have a heart attack or stroke as those without diabetes.",
      category: "Diabetes",
    ),
    ArticleModel(
      id: 2,
      title: "What You Need To Know About Asthma",
      description:
      "Your airways are responsible for carrying air into and out of your lungs, but what happens when they don’t function properly?",
      category: "Asthma",
    ),
    ArticleModel(
      id: 3,
      title: "Types of Diabetes",
      description:
      "Diabetes affects people of all ages and from all walks of life. There are several types, but type 2 diabetes is by far the most common.",
      category: "Diabetes",
    ),
  ];
}
