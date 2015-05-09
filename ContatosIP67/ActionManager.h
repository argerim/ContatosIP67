//
//  ActionManager.h
//  ContatosIP67
//
//  Created by ios5065 on 25/04/15.
//  Copyright (c) 2015 Caelum. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Contact.h"
#import <MessageUI/MFMailComposeViewController.h>

@interface ActionManager : NSObject<UIActionSheetDelegate, MFMailComposeViewControllerDelegate>
@property Contact *contact;
@property UIViewController *controller;
-(id)initWithContact:(Contact *) contact;
-(void) controllerActions:(UIViewController *) controller;


@end
