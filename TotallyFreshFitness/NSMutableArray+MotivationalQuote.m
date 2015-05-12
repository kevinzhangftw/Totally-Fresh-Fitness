//
//  NSMutableArray+MotivationalQuote.m
//  Total Fitness And Nutrition
//
//  Created by Namgyal Damdul on 11/11/2013.
//  Copyright (c) 2013 Total Fitness and Nutrition. All rights reserved.
//

#import "NSMutableArray+MotivationalQuote.h"

@implementation NSMutableArray (MotivationalQuote)

NSMutableArray *m_motivationalQuotesArray;

/*
 load up motivational quotes
 */
+ (NSString *)randomlySelectAMotivationalQuote
{
    if (!m_motivationalQuotesArray) {
        m_motivationalQuotesArray           = [[NSMutableArray alloc] initWithObjects:@"Ask yourself if what you are doing today is getting you closer to where you want to be tomorrow", @"I would rather be covered in sweat at the gym than covered in clothes at the beach", @"I’m not telling you its going to be easy, I’m telling you its going to be worth it!", @"You can feel sore tomorrow or you can feel sorry tomorrow. You choose", @"Believe In yourself and all that you are. Know that there is something inside you that is greater than any obstacle", @"The body achieves what the mind believes", @"Reshape your life one workout at a time", @"The only bad workout is the one that didn’t happen", @"Life begins at the end of your comfort zone", @"Excuses aren’t useless, results are priceless", @"Of course its hard. Its supposed to be hard. If it were easy, everybody would do it. Hard is what makes us great", @"Dare to go the distance", @"I don’t find the time to exercise. I make the time to exercise", @"Always bring your own sunshine", @"Dreams don’t work, unless you do", @"Bad days make for great workouts", @"There’s 1440 minutes in a day. Use 20 of them to workout", @"Motivation is what gets you started, Habit is what keeps you going", @"Instead of giving myself reasons why I can’t I give myself reasons why I can", @"Our greatest glory is not in never falling, but is rising every-time we fall", @"What would you do if you weren’t afraid", @"Run faster, eat better, sleep longer, try harder, aim higher, love more, day by day get happier", @"Go the extra mile, its never crowded", @"Make it your habit not to be critical about small things", @"When nothing goes right, go left", @"Whether you think you can or whether you think you cant, your right", @"No great thing is created suddenly", @"Turn I wish into I will", @"Stamina, speed, strength, skill and spirit", @"People often say that motivation doesn’t last. Well neither does bathing. That’s why we recommend it daily", @"No matter how slow you go, you are still lapping everybody on the couch", @"The secret of getting ahead is getting started", @"Because when I pick up the weights, the kind on my shoulders are lifted as well", @"Life is like riding a bicycle to keep your balance. You must keep moving", @"Luck has nothing to do with it", @"Never quit, never give up", @"Commitment- either you do or you don’t, there is no in between", @"Don’t show up late. Don’t try to slide out early. Don’t cheat your rep counts. And definitely, don’t hold back. Leave it all at the gym", @"Fall seven times, get up eight", @"Do not give up, the beginning is always the hardest", @"Be inspired. Be inspiring", @"Im busy getting stronger", @"One of the greatest moments in life is realizing that two weeks ago you couldn’t do what you just did", @"You don’t have to go fast. You just have to go", @"Distance makes the heart grow stronger", nil];
    }
    NSUInteger randomIndex                 = arc4random() % [m_motivationalQuotesArray count];
    return [NSString stringWithFormat:@"%@", [m_motivationalQuotesArray objectAtIndex:randomIndex]];
}
@end
