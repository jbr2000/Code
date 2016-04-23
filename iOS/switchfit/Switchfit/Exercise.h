//
//  Exercises.h
//  Switchfit
//
//  Created by Brendan Mcmahon on 8/18/14.
//  Copyright (c) 2014 Spencer McWilliams. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Exercise : NSObject

@property int num;
@property (nonatomic,strong) NSString *id;
@property (nonatomic,strong) NSString *name;
@property float difficulty;
@property (nonatomic,strong) NSString *summary;
@property (nonatomic,strong) NSArray *targets;

-(id)initExerciseWithDictionary:(NSDictionary*)exerciseAttributes;

@end
