//
//  contact.h
//  ContatosIP67
//
//  Created by ios5065 on 11/04/15.
//  Copyright (c) 2015 Caelum. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIkit.h>
#import <MapKit/MKAnnotation.h>

@interface Contact : NSObject <MKAnnotation>

@property (strong) NSString *name;
@property (strong) NSString *phone;
@property (strong) NSString *email;
@property (strong) NSString *address;
@property (strong) NSString *site;
@property (strong) NSNumber *latitude;
@property (strong) NSNumber *longitude;
@property (strong) UIImage *image;

@end


