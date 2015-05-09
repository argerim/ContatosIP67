//
//  ContactListViewController.h
//  ContatosIP67
//
//  Created by ios5065 on 18/04/15.
//  Copyright (c) 2015 Caelum. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "ContactDao.h"
#import "ContactFormViewController.h"
#import "ActionManager.h"

@interface ContactListViewController : UITableViewController<ContactFormViewControllerDelegate>

@property (strong) ContactDao *dao;
@property (strong) Contact *contact_selected;
@property NSInteger line;
@property (readonly) ActionManager *actionManager;
-(void) showMoreActions:(UIGestureRecognizer *) gesture;
@end
