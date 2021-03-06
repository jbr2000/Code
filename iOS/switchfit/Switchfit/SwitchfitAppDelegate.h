//
//  SwitchfitAppDelegate.h
//  Switchfit
//
//  Created by Spencer McWilliams on 8/18/14.
//  Copyright (c) 2014 Spencer McWilliams. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SwitchfitAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end
