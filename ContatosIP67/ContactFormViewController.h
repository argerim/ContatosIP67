//
//  ViewController.h
//  ContatosIP67
//
//  Created by ios5065 on 11/04/15.
//  Copyright (c) 2015 Caelum. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ContactDao.h"

@protocol ContactFormViewControllerDelegate <NSObject>
-(void)contactUpdated:(Contact *) contact;
-(void)contactCreated:(Contact *) contact;
@end

@interface ContactFormViewController : UIViewController<UINavigationControllerDelegate,UIImagePickerControllerDelegate>
@property IBOutlet UITextField *name;
@property IBOutlet UITextField *phone;
@property IBOutlet UITextField *email;
@property IBOutlet UITextField *address;
@property IBOutlet UITextField *site;
@property IBOutlet UITextField *latitude;
@property IBOutlet UITextField *longitude;
@property IBOutlet UIButton *addImage;
@property ContactDao *dao;
@property (strong) Contact *contact;
@property (weak) id<ContactFormViewControllerDelegate> delegate;
-(void)getDataOfForm;
@end

