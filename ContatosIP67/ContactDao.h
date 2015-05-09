//
//  ContactDao.h
//  ContatosIP67
//
//  Created by ios5065 on 11/04/15.
//  Copyright (c) 2015 Caelum. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "contact.h"
#import <CoreData/CoreData.h>

@interface ContactDao : NSObject
@property (strong, readonly) NSMutableArray *contacts;
@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;
-(void) addContact:(Contact*) contact;
+(id) contactDaoInstance;
-(Contact *)getContactPosition:(NSInteger)position;
-(void)removeContactOfPosition:(NSInteger)position;
-(NSInteger)getPositionOfContact:(Contact *)contact;
-(Contact *) novoContato;
@end
