//
//  AppDelegate.h
//  ContatosIP67
//
//  Created by ios5065 on 11/04/15.
//  Copyright (c) 2015 Caelum. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "ContactDao.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;

@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@property (strong) ContactDao *dao;

- (void)saveContext;

- (NSURL *)applicationDocumentsDirectory;

@end

