//
//  Workout.m
//  Switchfit
//
//  Created by Brendan Mcmahon on 8/20/14.
//  Copyright (c) 2014 Spencer McWilliams. All rights reserved.
//

#import "Workout.h"
#import "Exercise.h"

@interface Workout () <NSCoding>

@end

@implementation Workout

-(id)initWorkoutWithDictionary:(NSDictionary *)workoutAttributes
{
    self = [super init];
    
    _id         = workoutAttributes[@"id"];
    _name       = workoutAttributes[@"name"];
    _creator    = workoutAttributes[@"creator"];
    _timestamp  = workoutAttributes[@"timecreated"];
    _summary    = workoutAttributes[@"summary"];
    _exercises  = workoutAttributes[@"exercises"];
    _tags       = workoutAttributes[@"tags"];
    _num        = [workoutAttributes[@"num"] intValue];
    _likes      = [workoutAttributes[@"likes"] intValue];
    _comments   = [workoutAttributes[@"comments"] intValue];
    
    return self;
}

#pragma mark - NSCoding Methods
- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:(NSString *)_id        forKey:@"id"];
    [aCoder encodeObject:(NSString *)_name      forKey:@"name"];
    [aCoder encodeObject:(NSString *)_creator   forKey:@"creator"];
    [aCoder encodeObject:(NSString *)_timestamp forKey:@"timestamp"];
    [aCoder encodeObject:(NSString *)_summary   forKey:@"summary"];
    [aCoder encodeObject:(NSString  *)_tags      forKey:@"tags"];
    [aCoder encodeObject:(NSArray  *)_exercises forKey:@"exercises"];
    [aCoder encodeInt:_num      forKey:@"num"];
    [aCoder encodeInt:_likes    forKey:@"likes"];
    [aCoder encodeInt:_comments forKey:@"comments"];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    NSMutableDictionary *dict = [NSMutableDictionary new];
    [dict setObject:[aDecoder decodeObjectForKey:@"id"]         forKey:@"id"];
    [dict setObject:[aDecoder decodeObjectForKey:@"name"]       forKey:@"name"];
    [dict setObject:[aDecoder decodeObjectForKey:@"creator"]    forKey:@"creator"];
    [dict setObject:[aDecoder decodeObjectForKey:@"timestamp"]  forKey:@"timecreated"];
    [dict setObject:[aDecoder decodeObjectForKey:@"summary"]    forKey:@"summary"];
    [dict setObject:[aDecoder decodeObjectForKey:@"tags"]       forKey:@"tags"];
    [dict setObject:[aDecoder decodeObjectForKey:@"exercises"] forKey:@"exercises"];
    [dict setObject:[NSNumber numberWithInt:[aDecoder decodeIntForKey:@"num"]]      forKey:@"num"];
    [dict setObject:[NSNumber numberWithInt:[aDecoder decodeIntForKey:@"likes"]]    forKey:@"likes"];
    [dict setObject:[NSNumber numberWithInt:[aDecoder decodeIntForKey:@"comments"]] forKey:@"comments"];
    
    Workout *workout = [Workout new];
    workout = [workout initWorkoutWithDictionary:dict];
    return workout;
}

@end
