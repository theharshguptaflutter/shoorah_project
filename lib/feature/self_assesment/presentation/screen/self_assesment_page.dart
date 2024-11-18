
import 'package:bloc_test/feature/self_assesment/data/model/category_model.dart';
import 'package:bloc_test/feature/self_assesment/presentation/bloc/assesment_bloc.dart';
import 'package:context_extension/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SelfAssessmentsPage extends StatefulWidget {
  const SelfAssessmentsPage({super.key});

  @override
  _SelfAssessmentsPageState createState() => _SelfAssessmentsPageState();
}

class _SelfAssessmentsPageState extends State<SelfAssessmentsPage> {
  @override
  void initState() {
   
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<AssesmentBloc>().add(GetCategory());
    });
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        child: BlocConsumer<AssesmentBloc, AssesmentState>(
          listener: (context, state) {
           
          },
          builder: (context, state) {
            if (state is AssesmentBloc) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is AssesmentLoaded) {
              if (state.categoryList.isEmpty) {
                return const Center(child: Text('No category list available'));
              }
        
              return Stack(
               
                children: [
                  
                  _buildBackground(screenWidth, screenHeight),
                  _buildMainContent(
                      screenWidth, screenHeight, state.categoryList),
                  _buildRecentTestCard(screenWidth),
                ],
              );
            }
            return const Center(child: Text('No data'));
          },
        ),
      ),
    );
  }

 
  AppBar _buildAppBar() {
    return AppBar(
      centerTitle: true,
      elevation: 0,
      backgroundColor: Colors.transparent,
      leading: const Icon(Icons.arrow_back, color: Colors.black),
      title: const Text(
        "Self Assessments",
        style: TextStyle(color: Colors.black, fontSize: 20),
      ),
      actions: const [
        Icon(Icons.help_outline, color: Colors.black),
        SizedBox(width: 10),
        Icon(Icons.home_filled, color: Colors.black),
        SizedBox(width: 10),
      ],
    );
  }


  Widget _buildBackground(double width, double height) {
    return Container(
      width: width,
      height: height,
      color: const Color.fromARGB(255, 223, 223, 223),
      child: Column(
        children: [
          const SizedBox(height: 20),
          const Text(
            "Good Morning Reuben!",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
           Padding(
            padding: EdgeInsets.only(left:25.0,right: 25),
            child: Center(
              child: Text(
                "Welcome to our free self-assessments!\n Take charge of your mental health and well-being by exploring these insightful evaluations.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 15, 
                color: Color.fromARGB(255, 125, 124, 124)),
              ),
            ),
          ),
        ],
      ),
    );
  }

 
  _buildMainContent(
      double width, double height, List<CategoryModel> categoryList,) {
    return Positioned(
      top: 190,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(45),
            topRight: Radius.circular(45),
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 28),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             SizedBox(height: 20),
            _buildCategorySection(width),
             SizedBox(height: 20),
            _buildTopPicksSection(width, categoryList),
             SizedBox(height: 20),
            _buildRecentlyTakenSection(categoryList),
          ],
        ),
      ),
    );
  }

_buildCategorySection(width) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Categories",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildCategoryItem(width,Icons.sentiment_very_dissatisfied, "Anxiety", "1 Quizzes"),
              _buildCategoryItem(width,Icons.sentiment_dissatisfied, "Depression", "4 Quizzes"),
              _buildCategoryItem(width,Icons.flash_on, "ADHD", "2 Quizzes"),
              _buildCategoryItem(width,Icons.self_improvement, "Autism", "4 Quizzes"),
            ],
          ),
        ],
      ),
    );
  }


_buildTopPicksSection(screenWidth, categoryList) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        "Top Picks",
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
      SizedBox(height: 10),
     
      SizedBox(
        height: 150, 
        child: ListView.builder(
          itemCount: categoryList.length,
          scrollDirection: Axis.horizontal, 
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.all(8.0),
              child: Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  children: [
                    Image.network(
                      categoryList[index].categoryIcon,
                      width: 80,
                      height: 80,
                      fit: BoxFit.cover,
                    ),
                    SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                         SizedBox(height: 14),
                          Text(
                          categoryList[index].testTime,
                       
                          style: TextStyle(fontSize: 8, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          categoryList[index].categoryName,
                        
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 8),
                        Text(
                          categoryList[index].categoryDesc,
                     
                          style: TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    ],
  );
}





  _buildRecentlyTakenSection(List<CategoryModel> categoryList) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
         Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: [
             Text(
              "Recently Taken",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                     ),
                       Text(
              "View All",
              style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
                     ),
           ],
         ),
        const SizedBox(height: 10),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              
              for (var category in categoryList)
                _buildRecentTestItem(
                    category.categoryName, category.totalQuizees,category.categoryIcon),
            ],
          ),
        ),
      ],
    );
  }

  
  _buildCategoryItem(width,IconData icon, String title, String quizzes) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: Container(
            width: width / 5,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
              width:0.1)),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircleAvatar(
                radius: 30,
                backgroundColor: Colors.blue.shade100,
                child: Icon(icon, color: Colors.blue, size: 30),
              ),
            ),
          ),
        ),
   
        Text(
          title,
          style: const TextStyle(fontSize: 14, color: Colors.black),
        ),
         const SizedBox(height: 1),
         Text(
          quizzes,
          style: const TextStyle(fontSize: 9, color: Colors.black),
        ),
      ],
    );
  }

 _buildRecentTestItem(String title, body,Image) {
    return Padding(
      padding:  EdgeInsets.only(right: 16.0),
         
      child: Column(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundImage:  NetworkImage(
              Image,
            ),
          ),
          const SizedBox(height: 8),
          Center(
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            width: 55,
            decoration: BoxDecoration(color: Colors.blue,borderRadius: BorderRadius.circular(20)),
            child: Center(
              
              child: Text(body,
              textAlign: TextAlign.center,
              
               style: TextStyle(color: Colors.white,   ))),
          ),
        ],
      ),
    );
  }

   _buildRecentTestCard(double width) {
    return Positioned(
      top: context.h * 0.18,
      left: (context.w - width * 0.7) / 2,
      child: Container(
        alignment: Alignment.topCenter,
        width: context.w * 0.7,
        height: 85,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: const Color.fromARGB(255, 18, 120, 205),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children:  [
                  Text(
                    "Recent Test",
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                  SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(Icons.light_mode_rounded,
                          color: Colors.white, size: 11), SizedBox(width: 1),
                      Text(
                        "Self-Discovery Assessments",
                        style: TextStyle(fontSize: 11, color: Colors.white),
                      ),
                    ],
                  ),
                ],
              ),
            ),
             Padding(
              padding: EdgeInsets.only(right: 20),
              child: CircularProgressIndicator(
                
                value: 0.65,
                color: Colors.white,
                backgroundColor: Colors.white70,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
