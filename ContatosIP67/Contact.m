//
//  contact.m
//  ContatosIP67
//
//  Created by ios5065 on 11/04/15.
//  Copyright (c) 2015 Caelum. All rights reserved.
//

#import "contact.h"

@implementation Contact

@dynamic name, phone, email, address, site, latitude, longitude, image;

-(NSString *)description {
    return [NSString stringWithFormat:@"Name: %@, Phone: %@, Email: %@ Address: %@ Site: %@", self.name, self.phone, self.email, self.address, self.site];
}

-(CLLocationCoordinate2D)coordinate {
    return CLLocationCoordinate2DMake([self.latitude doubleValue], [self.longitude doubleValue]);
}

-(NSString *)title {
    return self.name;
}

-(NSString *)subtitle {
    return self.email;
}

@end
