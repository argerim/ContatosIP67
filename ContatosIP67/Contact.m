//
//  contact.m
//  ContatosIP67
//
//  Created by ios5065 on 11/04/15.
//  Copyright (c) 2015 Caelum. All rights reserved.
//

#import "contact.h"

@implementation Contact
-(NSString *)description {
    return [NSString stringWithFormat:@"Name: %@, Phone: %@, Email: %@ Address: %@ Site: %@", self.name, self.phone, self.email, self.address, self.site];
}
@end