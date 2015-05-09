//
//  ContactDao.m
//  ContatosIP67
//
//  Created by ios5065 on 11/04/15.
//  Copyright (c) 2015 Caelum. All rights reserved.
//

#import "ContactDao.h"

@implementation ContactDao
static ContactDao *defaultDao = nil;
+(id) contactDaoInstance {
    if (!defaultDao) {
        defaultDao = [ContactDao new];
    }
    return defaultDao;
}

-(id) init {
    self = [super init];
    if(self) {
        _contacts = [NSMutableArray new];
    }
    return self;
}
-(void) addContact:(Contact *) contact {
    [self.contacts addObject:contact];
}
-(Contact *)getContactPosition:(NSInteger)position{
    return self.contacts[position];
}
-(void)removeContactOfPosition:(NSInteger)position {
    [self.contacts removeObjectAtIndex:position];
}
-(NSInteger)getPositionOfContact:(Contact *) contact {
    return [self.contacts indexOfObject:contact];
}
@end
