//
//  DatabaseManager.m
//  Switchfit
//
//  Created by Spencer McWilliams on 8/17/14.
//  Copyright (c) 2014 Spencer McWilliams. All rights reserved.
//

#import "DatabaseManager.h"

@implementation DatabaseManager

+ (NSArray*)getExercises
{
    NSURL *URL          = [[NSURL alloc] initWithString:@"http://switchf.it/testingdb.php?q=SELECT%20*%20FROM%20exercises%20LIMIT%2030&p=sandpiper123"];
    NSData *rawContents = [[NSData alloc] initWithContentsOfURL:URL];
    NSError      *error;
    NSMutableArray *JSONResults = [[NSMutableArray alloc] init];
    if(!rawContents)
        return nil;
    NSDictionary *parsedJSON = [NSJSONSerialization JSONObjectWithData:rawContents
                                                  options:NSJSONReadingMutableContainers
                                                    error:&error];
    if (error) {
        NSLog(@"JSON Parsing Error: %@", error);
        return nil;
    }
    
    for(int i = 0; i < [[parsedJSON objectForKey:@"Exercises"] count]; i++)
    {
        Exercise *exercise = [[Exercise alloc] initExerciseWithDictionary:parsedJSON[@"Exercises"][i]];
        [JSONResults addObject:exercise];
    }
 
    
    return JSONResults;
}
+ (NSArray*)getWorkouts
{
    NSURL *URL          = [[NSURL alloc] initWithString:@"http://switchf.it/testingdb.php?q=SELECT%20*%20FROM%20workouts%20LIMIT%2030&p=sandpiper123"];
    NSData *rawContents = [[NSData alloc] initWithContentsOfURL:URL];
    NSError      *error;
    NSMutableArray *JSONResults = [[NSMutableArray alloc] init];
    if(!rawContents)
        return nil;
    NSDictionary *parsedJSON = [NSJSONSerialization JSONObjectWithData:rawContents
                                                               options:NSJSONReadingMutableContainers
                                                                 error:&error];
    if (error) {
        NSLog(@"JSON Parsing Error: %@", error);
        return nil;
    }
    for(int i = 0; i < [[parsedJSON objectForKey:@"Exercises"] count]; i++)
    {
        Workout *workout = [[Workout alloc] initWorkoutWithDictionary:parsedJSON[@"Exercises"][i]];
        [JSONResults addObject:workout];
    }
    
    return JSONResults;
}
+(NSArray*)getWorkoutWithMuscles:(NSArray *)muscles
{
    //generate query
    NSMutableString *urlString = [NSMutableString new];
    NSString *tempString = [NSString new];
    [urlString appendString:@"http://switchf.it/testingdb.php?q=SELECT%20*%20FROM%20exercises%20WHERE%20targets%20REGEXP%27"];
    for (int i = 0; i < [muscles count]; i++) {
        tempString = [NSString stringWithFormat:@"(.*%@)", [muscles objectAtIndex:i]];
        tempString = [tempString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [urlString appendString:tempString];
        if (i < [muscles count]-1) {
            [urlString appendString:@"%7C"];
        }
    }
    [urlString appendString:@"%27&p=sandpiper123"];
    //parse query results
    NSURL *URL          = [[NSURL alloc] initWithString:[urlString copy]];
    NSData *rawContents = [[NSData alloc] initWithContentsOfURL:URL];
    NSError      *error;
    NSMutableArray *JSONResults = [[NSMutableArray alloc] init];
    if(!rawContents)
        return nil;
    NSDictionary *parsedJSON = [NSJSONSerialization JSONObjectWithData:rawContents
                                                               options:NSJSONReadingMutableContainers
                                                                 error:&error];
    if (error) {
        NSLog(@"JSON Parsing Error: %@", error);
        return nil;
    }
    for(int i = 0; i < [[parsedJSON objectForKey:@"Exercises"] count]; i++)
    {
        Exercise *exercise = [[Exercise alloc] initExerciseWithDictionary:[parsedJSON[@"Exercises"] objectAtIndex:i]];
        [JSONResults addObject:exercise];
    }
    
    return [JSONResults copy];
}

@end
