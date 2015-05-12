//
//  SwitchPlanItemSelection.m
//  Total Fitness And Nutrition
//
//  Created by Namgyal Damdul on 2013-03-11.
//  Copyright (c) 2013 Total Fitness and Nutrition. All rights reserved.
//

#import "SwitchPlanItemSelection.h"
#import "NSMutableArray+SportsList.h"

@implementation SwitchPlanItemSelection

@synthesize categoryName;

// Beverages items
NSMutableArray *m_beverage;
// Carbohydrates items
NSMutableArray *m_carbohydrates;
// Fruit items
NSMutableArray *m_fruit;
// Protein items
NSMutableArray *m_protein;
// Snacks items
NSMutableArray *m_snacks;
// Vegetables items
NSMutableArray *m_vegetables;
//  Dairy items
NSMutableArray *m_dairy;
// Beans items
NSMutableArray *m_beans;
// Fats items
NSMutableArray *m_fats;
// Drinks items
NSMutableArray *m_drinks;
// Sugar items
NSMutableArray *m_sugar;
// Complex Carbs items
NSMutableArray *m_complexCarbs;
// Triceps images array
NSMutableArray *m_tricepsImagesArray;
// Biceps images array
NSMutableArray *m_bicepsImagesArray;
// Abs exercises list
NSMutableArray *m_absExerciseList;
// Arms exercises list
NSMutableArray *m_armsExerciseList;
// Triceps exercises list
NSMutableArray *m_tricepsExerciseList;
// Biceps exercises list
NSMutableArray *m_bicepsExerciseList;
// Back exercises list
NSMutableArray *m_backExerciseList;
// Chest exercises list
NSMutableArray *m_chestExerciseList;
// Legs exercises list
NSMutableArray *m_legsExerciseList;
// Shoulder exercises list
NSMutableArray *m_shoulderExerciseList;
// Full Body exercises list
NSMutableArray *m_fullBodyExerciseList;
// Cardio exercises list
NSMutableArray *m_cardioExerciseList;
// Sports exercises list
NSMutableArray *m_sportsExerciseList;


/*
 Singleton SwitchPlanItemSelection object
 */
+ (SwitchPlanItemSelection *)sharedInstance {
	static SwitchPlanItemSelection *globalInstance;
	static dispatch_once_t predicate;
	dispatch_once(&predicate, ^{
        globalInstance = [self alloc];
    });
	return globalInstance;
}

- (void)loadUpMealItemsSelection
{
    if (!m_beverage) {
        m_beverage              = [[NSMutableArray alloc] initWithObjects:@"Almond Milk", @"6 oz", @"Apple Juice", @"6 oz", @"Coffee", @"8 oz", @"Cranberry Juice", @"6 oz", @"Green Tea", @"8 oz", @"Milk", @"6 oz", @"Orange Juice", @"6 oz", @"Pomegranate Juice", @"6 oz", @"Soy Milk", @"6 oz", @"Tea", @"8 oz", @"Tomato Juice", @"8 oz", nil];
    }
    if (!m_carbohydrates) {
        m_carbohydrates         = [[NSMutableArray alloc] initWithObjects:@"Brown Rice Cake", @"2 cakes", @"Bread", @"9-grain 1 slice or 32g", @"Brown Rice", @"1 cup, cooked : 215 cal", @"Couscous", @"1 cup, cooked", @"Lentils", @"1 cup, cooked", @"Oat Bran Bagel", @"Oat Bran Bagel", @"Oatmeal", @"2/3 cup, cooked : 97 cal", @"Potato", @"63.8g or 2.25 oz", @"Quinoa", @"3/4 cup : 183 cal", @"Steel Cut Oats", @"dry 1/4 cup or 20g", @"Sweet Potato", @"56.7g or 4 oz", @"Whole Wheat Pasta",  @"1 cup cooked", @"Yams", @"1 cup : 161 cal", nil];
    }
    if (!m_fruit) {
        m_fruit                 = [[NSMutableArray alloc] initWithObjects:@"Apple", @"1 medium : 81 cal", @"Banana", @"1 large : 125 cal", @"Blackberries", @"2/3 cup or 99g", @"Blueberries", @"2/3 cup : 30 cal", @"Cherries", @"2/3 cup", @"Dried Apricot", @"2/3 cup", @"Dried Cranberries", @"1/3 cup", @"Grapefruit", @"6.5 oz or 184g", @"Grapes", @"1 cup", @"Kiwi", @"2 kiwi", @"Mango", @"1 medium", @"Melon", @"5 oz or 141.75g", @"Orange", @"1 large", @"Peach", @"1 medium", @"Pear", @"1 large", @"Pineapple", @"4 oz or 85g", @"Pomegranate", @"1 pomegranate : 105 cal", @"Raisins", @"1/4 cup or 18.5g", @"Raspberries", @"2/3 cup", @"Strawberries", @"6.5 oz or 184g", @"Watermelon", @"6 oz or 141.75g", nil];
    }
    if (!m_protein) {
        m_protein               = [[NSMutableArray alloc] initWithObjects:@"Beef", @"6 oz", @"Bison", @"5 oz", @"Chicken Breast", @"6 oz : 139 cal", @"Cod", @"6 oz", @"Egg", @"2 eggs", @"Fresh Tuna", @"4 oz", @"Optimum 100% Whey", @"Empty Space", @"Musclepharm Casein", @"Empty Space", @"Shrimp", @"5 oz", @"Soy Burger", @"4 oz", @"Tilapia", @"5 oz", @"Tofu", @"4 oz", @"Turkey", @"6 oz or 28.35g", @"Wild Salmon", @"5 oz : 146 cal", nil];
    }
    if (!m_snacks) {
        m_snacks                = [[NSMutableArray alloc] initWithObjects:@"Almonds", @"1 oz (approx 22) : 175 cal", @"Peanuts", @"1/3 oz", @"Pecans", @"1/3 oz", @"Protein Bar", @"1/2 bar or 40 grams", @"Trail Mix", @"1 oz", @"Walnuts", @"1Tbsp or 1/4 oz", nil];
    }
    if (!m_vegetables) {
        m_vegetables            = [[NSMutableArray alloc] initWithObjects:@"Alfalfa Sprouts", @"1/2 cup", @"Asparagus", @"5 stocks : 21 cal", @"Avocado", @"1/2 Avocado", @"Beets", @"1 cup", @"Broccoli", @"1 cup : 27 cal", @"Brussel Sprouts", @"1 cup", @"Cabbage", @"1 cup", @"Carrots", @"2 medium carrots", @"Cauliflower", @"2.75oz or ½ cup", @"Celery", @"1 medium stalk: 6 cal", @"Corn", @"1 cup or on large cob", @"Cucumber", @"5.5 oz or 1/3 cup", @"Eggplant", @"1 cup", @"Green Beans", @"2.2oz or ½ cup", @"Kale", @"1 cup", @"Mixed Greens", @"1.5 cups", @"Mushrooms", @"2.2oz or ½ cup", @"Onions", @"15 g : 5 cal", @"Green Onions", @"15 g : 5 cal", @"Peas", @"3/4 cup", @"Peppers", @"1 pepper : 1/2 pepper", @"Romaine Lettuce", @"1 cup : 167 cal", @"Spinach", @"1 cup : 28 cal", @"Squash", @"1 cup", @"Tomato", @"90g or 3.2 oz or ½ cup", @"Zucchini", @"1 cup or 1 medium", @"Tomato Juice", @"Empty Space", @"Garlic", @"Empty Space", @"Ginger", @"Empty Space",  nil];
    }
    if (!m_dairy) {
        m_dairy                 = [[NSMutableArray alloc] initWithObjects:@"Cottage Cheese", @"Empty Space", @"Greek Yogurt", @"Empty Space", @"Yogurt", @"Empty Space", @"Milk", @"Empty Space", @"Almond Milk", @"Empty Space", @"Soy Milk", @"Empty Space", nil];
    }
    if (!m_beans) {
        m_beans                 = [[NSMutableArray alloc] initWithObjects:@"Kidney Beans", @"Empty Space", @"Hummus", @"Empty Space", @"Edamame Beans", @"Empty Space", nil];
    }
    if (!m_fats) {
        m_fats                  = [[NSMutableArray alloc] initWithObjects:@"Goat Cheese", @"Empty Space", @"Avocado", @"Empty Space", @"Flaxseed Oil", @"Empty Space", @"Olive Oil", @"Empty Space", @"Almonds", @"Empty Space", @"Trail Mix", @"Empty Space", @"Walnuts", @"Empty Space", @"Pecans", @"Empty Space", @"Peanuts", @"Empty Space", @"Salad Dressing", @"Empty Space", @"Feta Cheese", @"Empty Space", @"Peanut Butter", @"Empty Space", @"Almond Butter", @"Empty Space",  nil];
    }
    if (!m_drinks) {
        m_drinks                = [[NSMutableArray alloc] initWithObjects:@"Coffee",@"Empty Space",@"Tea",@"Empty Space", @"Green Tea",@"Empty Space", nil];
    }
    if (!m_complexCarbs) {
        m_complexCarbs          = [[NSMutableArray alloc] initWithObjects:@"Steel Cut Oats", @"Empty Space", @"Granola", @"Empty Space", @"Flax Seeds", @"Empty Space", @"Hemp Hearts", @"Empty Space", @"Buckwheat Pancakes", @"Empty Space", @"Wheat Germ", @"Empty Space", nil];
    }
}

/*
 Get Meal Plan Items for selection
 */
- (NSMutableArray *)getMealPanItems:(NSString *)foodItem
{
    // first load up the food items
    [self loadUpMealItemsSelection];
    
    NSMutableArray *foodArray;
    for (NSString *food in m_beverage) {
        if ([food caseInsensitiveCompare:foodItem] == NSOrderedSame) {
            foodArray           = m_beverage;
            categoryName        = @"Beverage";
            return foodArray;
        }
        else {
            categoryName        = @"";
        }
    }
    
    for (NSString *food in m_carbohydrates) {
        if ([food caseInsensitiveCompare:foodItem] == NSOrderedSame) {
            foodArray           = m_carbohydrates;
            categoryName        = @"Carbohydrates";
            return foodArray;
        }
        else {
            categoryName        = @"";
        }
    }

    for (NSString *food in m_fruit) {
        if ([food caseInsensitiveCompare:foodItem] == NSOrderedSame) {
            foodArray           = m_fruit;
            categoryName        = @"Fruit";
            return foodArray;
        }
        else {
            categoryName        = @"";
        }
    }
    
    for (NSString *food in m_protein) {
        if ([food caseInsensitiveCompare:foodItem] == NSOrderedSame) {
            foodArray           = m_protein;
            categoryName        = @"Protein";
            return foodArray;
        }
        else {
            categoryName        = @"";
        }
    }
    
    for (NSString *food in m_snacks) {
        if ([food caseInsensitiveCompare:foodItem] == NSOrderedSame) {
            foodArray           = m_snacks;
            categoryName        = @"Snacks";
            return foodArray;
        }
        else {
            categoryName        = @"";
        }
    }
    
    for (NSString *food in m_vegetables) {
        if ([food caseInsensitiveCompare:foodItem] == NSOrderedSame) {
            foodArray           = m_vegetables;
            categoryName        = @"Vegetables";
            return foodArray;
        }
        else {
            categoryName        = @"";
        }
    }
    
    for (NSString *food in m_dairy) {
        if ([food caseInsensitiveCompare:foodItem] == NSOrderedSame) {
            foodArray           = m_dairy;
            categoryName        = @"Dairy";
            return foodArray;
        }
        else {
            categoryName        = @"";
        }
    }
    
    for (NSString *food in m_beans) {
        if ([food caseInsensitiveCompare:foodItem] == NSOrderedSame) {
            foodArray           = m_beans;
            categoryName        = @"Beans";
            return foodArray;
        }
        else {
            categoryName        = @"";
        }
    }
    
    for (NSString *food in m_fats) {
        if ([food caseInsensitiveCompare:foodItem] == NSOrderedSame) {
            foodArray           = m_fats;
            categoryName        = @"Fats";
            return foodArray;
        }
        else {
            categoryName        = @"";
        }
    }

    for (NSString *food in m_drinks) {
        if ([food caseInsensitiveCompare:foodItem] == NSOrderedSame) {
            foodArray           = m_drinks;
            categoryName        = @"Drinks";
            return foodArray;
        }
        else {
            categoryName        = @"";
        }
    }
    
    for (NSString *food in m_complexCarbs) {
        if ([food caseInsensitiveCompare:foodItem] == NSOrderedSame) {
            foodArray           = m_complexCarbs;
            categoryName        = @"Complex Carbs";
            return foodArray;
        }
        else {
            categoryName        = @"";
        }
    }
    
    return foodArray;
}


/*
 Load up the abs
 */
- (void)loadUpAbsExercise
{
    if (!m_absExerciseList) {
        m_absExerciseList           = [NSMutableArray mutableArrayObject];
        [m_absExerciseList addObject:@"Ab Roller"];
        [m_absExerciseList addObject:@"Ball Hand To Feet"];
        [m_absExerciseList addObject:@"Ball Roll Ins"];
        [m_absExerciseList addObject:@"Ball Twist"];
        [m_absExerciseList addObject:@"Bench V Sit Crunch"];
        [m_absExerciseList addObject:@"Bicycle Crunch"];
        [m_absExerciseList addObject:@"Crunches"];
        [m_absExerciseList addObject:@"Flutter Kicks"];
        [m_absExerciseList addObject:@"Hanging Leg Raises"];
        [m_absExerciseList addObject:@"Hip Raises"];
        [m_absExerciseList addObject:@"Laying Windshield Wipers"];
        [m_absExerciseList addObject:@"Plank"];
        [m_absExerciseList addObject:@"Scissor Sit Ups"];
        [m_absExerciseList addObject:@"Side Plank Hip Raises"];
        [m_absExerciseList addObject:@"Side Plank"];
        [m_absExerciseList addObject:@"Sit Ups"];
        [m_absExerciseList addObject:@"Supermans"];
        [m_absExerciseList addObject:@"Toe Touches"];
        [m_absExerciseList addObject:@"V Sit"];
        [m_absExerciseList addObject:@"Weighted Crunch On Ball"];
    }
}

/*
 Load up Triceps exercises
 */
- (void) loadUpTricepExercises
{
    if (!m_tricepsExerciseList) {
        m_tricepsExerciseList           = [NSMutableArray mutableArrayObject];
        // triceps exercise list starts
        [m_tricepsExerciseList addObject:@"Bench Dips"];
        [m_tricepsExerciseList addObject:@"Tricep Extension"];
        [m_tricepsExerciseList addObject:@"Tricep Kick Backs"];
        [m_tricepsExerciseList addObject:@"Tricep Rope Pull Down"];
    }
}

/*
 Load up Biceps exercises
 */
- (void)loadUpBicepExercises
{
    if (!m_bicepsExerciseList) {
        m_bicepsExerciseList            = [NSMutableArray mutableArrayObject];
        // biceps exercise list starts
        [m_bicepsExerciseList addObject:@"Bicep Curl"];
        [m_bicepsExerciseList addObject:@"Concentration Curl"];
        [m_bicepsExerciseList addObject:@"Ez Bar Curl"];
        [m_bicepsExerciseList addObject:@"Preacher Curl"];
    }
}

/*
 load up Back exercises
 */
- (void)loadUpBackExercises
{
    if (!m_backExerciseList) {
        m_backExerciseList              = [NSMutableArray mutableArrayObject];
        [m_backExerciseList addObject:@"Single Arm Bent Over Row"];
        [m_backExerciseList addObject:@"Bent Over Alternating Row"];
        [m_backExerciseList addObject:@"Bent Over Barbell Row"];
        [m_backExerciseList addObject:@"Bent Over Dumbbell Row"];
        [m_backExerciseList addObject:@"Seated Row"];
        [m_backExerciseList addObject:@"Narrow Grip Pull Up"];
        [m_backExerciseList addObject:@"Upright Row"];
        [m_backExerciseList addObject:@"Wide Grip Lateral Pull Down"];
        [m_backExerciseList addObject:@"Wide Grip Pull Up"];
    }
}

/*
 load up Chest exercises
 */
- (void)loadUpChestExercises
{
    if (!m_chestExerciseList) {
        m_chestExerciseList            = [NSMutableArray mutableArrayObject];
        [m_chestExerciseList addObject:@"Bench Press"];
        [m_chestExerciseList addObject:@"Inch Worm Push Up"];
        [m_chestExerciseList addObject:@"Incline Bench Press"];
        [m_chestExerciseList addObject:@"Push Ups"];
        [m_chestExerciseList addObject:@"Weighted Chest Fly"];
    }
}

/*
 load up Legs exercises
 */
- (void)loadUpLegsExercises
{
    if (!m_legsExerciseList) {
        m_legsExerciseList             = [NSMutableArray mutableArrayObject];
        [m_legsExerciseList addObject:@"Body Weight Squats"];
        [m_legsExerciseList addObject:@"Butt Kicks"];
        [m_legsExerciseList addObject:@"Calf Raises"];
        [m_legsExerciseList addObject:@"Deadlift"];
        [m_legsExerciseList addObject:@"Squat and Press"];
        [m_legsExerciseList addObject:@"Dumbbell Deadlift"];
        [m_legsExerciseList addObject:@"Front Squat"];
        [m_legsExerciseList addObject:@"Jump Squat"];
        [m_legsExerciseList addObject:@"Squat"];
        [m_legsExerciseList addObject:@"Jumping Split Squat"];
        [m_legsExerciseList addObject:@"Leg Press"];
        [m_legsExerciseList addObject:@"Lunges"];
        [m_legsExerciseList addObject:@"Reverse Lunge"];
        [m_legsExerciseList addObject:@"Single Arm Deadlift"];
        [m_legsExerciseList addObject:@"Skater Lunges"];
    }
}

/*
 load up Shoulder exercises
 */
- (void)loadUpShoulderExercises
{
    if (!m_shoulderExerciseList) {
        m_shoulderExerciseList          = [NSMutableArray mutableArrayObject];
        [m_shoulderExerciseList addObject:@"Bent Lateral Raises"];
        [m_shoulderExerciseList addObject:@"Dumbbell Drop"];
        [m_shoulderExerciseList addObject:@"Front Raises"];
        [m_shoulderExerciseList addObject:@"Seated Shoulder Press"];
        [m_shoulderExerciseList addObject:@"Power Shrug"];
        [m_shoulderExerciseList addObject:@"Standing Shoulder Press"];
        [m_shoulderExerciseList addObject:@"Standing Shrug"];
    }
}

/*
 load up Full Body Exercises
 */
- (void)loadUpFullBodyExercises
{
    if (!m_fullBodyExerciseList) {
        m_fullBodyExerciseList          = [NSMutableArray mutableArrayObject];
        [m_fullBodyExerciseList addObject:@"Burpee Push Up"];
        [m_fullBodyExerciseList addObject:@"Burpees"];
        [m_fullBodyExerciseList addObject:@"Half Burpees"];
        [m_fullBodyExerciseList addObject:@"Jump Tucks"];
        [m_fullBodyExerciseList addObject:@"Jumping Jacks"];
        [m_fullBodyExerciseList addObject:@"Kettle Bell Swing"];
        [m_fullBodyExerciseList addObject:@"Knee Abductions"];
        [m_fullBodyExerciseList addObject:@"Mountain Climbers"];
        [m_fullBodyExerciseList addObject:@"Plea Squat Upright Row"];
        [m_fullBodyExerciseList addObject:@"High Knees"];
        [m_fullBodyExerciseList addObject:@"Squat And Press"];
        [m_fullBodyExerciseList addObject:@"Wood Choppers"];
    }
}

/*
 load up Cardio exercises
 */
- (void)loadUpCardioExercises
{
    if (!m_cardioExerciseList) {
        m_cardioExerciseList            = [NSMutableArray mutableArrayObject];
        [m_cardioExerciseList addObject:@"Bike"];
        [m_cardioExerciseList addObject:@"Skip"];
        [m_cardioExerciseList addObject:@"Jogging"];
        [m_cardioExerciseList addObject:@"Elliptical"];
        [m_cardioExerciseList addObject:@"Swimming"];
        [m_cardioExerciseList addObject:@"Rowing"];
    }
}

/*
 load up Sports exercises
 */
- (void)loadUpSportsExercises
{
    if (!m_sportsExerciseList) {
        m_sportsExerciseList            = [NSMutableArray sportsList];
    }
}

/*
 Get Workout Plan Items for selection
 */
- (NSMutableArray *)getWorkoutPlanItems:(NSString *)workoutItem
{
    // capatalize first letter of each words of work item
    workoutItem                 = [workoutItem capitalizedString];
    workoutItem = [workoutItem stringByReplacingOccurrencesOfString:@".Png" withString:@""];
    
    // load up exercises
    [self loadUpAbsExercise];
    [self loadUpTricepExercises];
    [self loadUpBicepExercises];
    [self loadUpBackExercises];
    [self loadUpChestExercises];
    [self loadUpLegsExercises];
    [self loadUpShoulderExercises];
    [self loadUpFullBodyExercises];
    [self loadUpCardioExercises];
    [self loadUpSportsExercises];
    
    NSMutableArray *exerciseArray;
    for (NSString *exercise in m_absExerciseList) {
        if ([exercise isEqualToString:workoutItem]) {
            exerciseArray       = m_absExerciseList;
            categoryName        = @"Abs";
            return exerciseArray;
        }
        else {
            categoryName        = @"";
        }
    }

    for (NSString *exercise in m_tricepsExerciseList) {
        if ([exercise isEqualToString:workoutItem]) {
            exerciseArray       = m_tricepsExerciseList;
            categoryName        = @"Triceps";
            return exerciseArray;
        }
        else {
            categoryName        = @"";
        }
    }
    
    for(NSString *exercise in m_bicepsExerciseList){
        if([exercise isEqualToString:workoutItem]){
            exerciseArray = m_bicepsExerciseList;
            categoryName        = @"Biceps";
            return exerciseArray;
        }
        else{
            categoryName = @"";
        }
    }

    for (NSString *exercise in m_backExerciseList) {
        if ([exercise isEqualToString:workoutItem]) {
            exerciseArray       = m_backExerciseList;
            categoryName        = @"Back";
            return exerciseArray;
        }
        else {
            categoryName        = @"";
        }
    }

    for (NSString *exercise in m_chestExerciseList) {
        if ([exercise isEqualToString:workoutItem]) {
            exerciseArray       = m_chestExerciseList;
            categoryName        = @"Chest";
            return exerciseArray;
        }
        else {
            categoryName        = @"";
        }
    }
   
    for (NSString *exercise in m_legsExerciseList) {
        if ([exercise isEqualToString:workoutItem]) {
            exerciseArray       = m_legsExerciseList;
            categoryName        = @"Legs";
            return exerciseArray;
        }
        else {
            categoryName        = @"";
        }
    }
    
    for (NSString *exercise in m_shoulderExerciseList) {
        if ([exercise isEqualToString:workoutItem]) {
            exerciseArray       = m_shoulderExerciseList;
            categoryName        = @"Shoulder";
            return exerciseArray;
        }
        else {
            categoryName        = @"";
        }
    }

    for (NSString *exercise in m_fullBodyExerciseList) {
        if ([exercise isEqualToString:workoutItem]) {
            exerciseArray       = m_fullBodyExerciseList;
            categoryName        = @"Full Body Exercises";
            return exerciseArray;
        }
        else {
            categoryName        = @"";
        }
    }

    for (NSString *exercise in m_cardioExerciseList) {
        if ([exercise isEqualToString:workoutItem]) {
            exerciseArray       = m_cardioExerciseList;
            categoryName        = @"Cardio";
            return exerciseArray;
        }
        else {
            categoryName        = @"";
        }
    }

    for (NSString *exercise in m_sportsExerciseList) {
        if ([exercise isEqualToString:workoutItem]) {
            exerciseArray       = m_sportsExerciseList;
            categoryName        = @"Sports";
            return exerciseArray;
        }
        else {
            categoryName        = @"";
        }
    }
    
    return exerciseArray;
}

@end
