//
//  Exercises.m
//  Switchfit
//
//  Created by Brendan Mcmahon on 8/18/14.
//  Copyright (c) 2014 Spencer McWilliams. All rights reserved.
//

#import "Exercise.h"

@interface Exercise () <NSCoding>

@end

@implementation Exercise

-(id)initExerciseWithDictionary:(NSDictionary*)exerciseAttributes
{
    self = [super init];
    
    if(self)
    {
        _num = (int)exerciseAttributes[@"num"];
        _id = exerciseAttributes[@"id"];
        _name = exerciseAttributes[@"name"];
        _difficulty = [exerciseAttributes[@"difficulty"] floatValue];
        _summary = exerciseAttributes[@"summary"];
        _targets = [exerciseAttributes[@"targets"] componentsSeparatedByString:@", "];
        
    }
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeInt:_num forKey:@"num"];
    [aCoder encodeObject:(NSString *)_id forKey:@"id"];
    [aCoder encodeObject:(NSString *)_name forKey:@"name"];
    [aCoder encodeFloat:_difficulty forKey:@"difficulty"];
    [aCoder encodeObject:(NSString *)_summary forKey:@"summary"];
    [aCoder encodeObject:(NSArray *)_targets forKey:@"targets"];
}

- (id) initWithCoder:(NSCoder *)aDecoder
{
    Exercise *exercise = [Exercise new];
    exercise.num = [aDecoder decodeIntForKey:@"num"];
    exercise.id = [aDecoder decodeObjectForKey:@"id"];
    exercise.name = [aDecoder decodeObjectForKey:@"name"];
    exercise.difficulty = [aDecoder decodeFloatForKey:@"difficulty"];
    exercise.summary = [aDecoder decodeObjectForKey:@"summary"];
    exercise.targets = [aDecoder decodeObjectForKey:@"targets"];
    
    return exercise;
}

@end
