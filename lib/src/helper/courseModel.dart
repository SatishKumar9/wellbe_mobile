class CourseModel {
  String name;
  String description;
  String tag1;

  CourseModel(
      {this.name,
      this.description,
      this.tag1,
      });
}

class CourseList {
  static List<CourseModel> list = [
    CourseModel(
        name: "How to Protect Your Heart if You Have Diabetes",
        description:
            "According to the American Diabetes Association (ADA), adults with diabetes are almost twice as likely to have a heart attack or stroke as those without diabetes.",
        tag1: "Diabetes",
      ),
    CourseModel(
        name: "What You Need To Know About Asthma",
        description:
            "Your airways are responsible for carrying air into and out of your lungs, but what happens when they don’t function properly?",
        tag1: "Asthma",
      ),
    CourseModel(
        name: "Types of Diabetes",
        description:
            "Diabetes affects people of all ages and from all walks of life. There are several types, but type 2 diabetes is by far the most common.",
        tag1: "Diabetes",
    ),
  ];
}
