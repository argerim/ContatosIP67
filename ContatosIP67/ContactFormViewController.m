//
//  ViewController.m
//  ContatosIP67
//
//  Created by ios5065 on 11/04/15.
//  Copyright (c) 2015 Caelum. All rights reserved.
//

#import "ContactFormViewController.h"
#import "ContactDao.h"
#import <CoreLocation/CoreLocation.h>

@interface ContactFormViewController ()

@end

@implementation ContactFormViewController

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.dao = [ContactDao contactDaoInstance];
        self.navigationItem.title = @"New Contact";
        UIBarButtonItem *buttonSaveForm = [[UIBarButtonItem alloc]
                                           initWithTitle:@"Save" style:UIBarButtonItemStylePlain
                                           target:self action:@selector(createContact)];
        self.navigationItem.rightBarButtonItem = buttonSaveForm;
    }

    return self;
}

- (void)viewDidLoad {
    //[super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    if (self.contact) {
        UIBarButtonItem *confirm = [[UIBarButtonItem alloc] initWithTitle:@"Confirm" style:(UIBarButtonItemStylePlain) target:self action:@selector(updateContact)];
        self.navigationItem.rightBarButtonItem = confirm;
        self.name.text      = self.contact.name;
        self.phone.text     = self.contact.phone;
        self.email.text     = self.contact.email;
        self.address.text   = self.contact.address;
        self.site.text      = self.contact.site;
        self.latitude.text  = [self.contact.latitude stringValue];
        self.longitude.text = [self.contact.longitude stringValue];
        if (self.contact.image) {
            [self.addImage setBackgroundImage:self.contact.image forState:UIControlStateNormal];
            [self.addImage setTitle:nil forState:UIControlStateNormal];
        }
    }
}

-(void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)getDataOfForm {
    if (!self.contact) {
        self.contact = [Contact new];
    }
    if ([self.addImage backgroundImageForState:UIControlStateNormal]) {
        self.contact.image = [self.addImage backgroundImageForState:UIControlStateNormal];
    }
    self.contact.name     = self.name.text;
    self.contact.phone    = self.phone.text;
    self.contact.address  = self.address.text;
    self.contact.site     = self.site.text;
    self.contact.email    = self.email.text;
    self.contact.latitude = [NSNumber numberWithFloat: [self.latitude.text floatValue]];
    self.contact.longitude = [NSNumber numberWithFloat: [self.longitude.text floatValue]];
    //NSLog(@"Dados: %@", contact);

}

-(void)createContact {
    [self getDataOfForm];
    [self.dao addContact:self.contact];
    if (self.delegate) {
        [self.delegate contactCreated:self.contact];
    }
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)updateContact {
    [self getDataOfForm];
    if (self.delegate) {
        [self.delegate contactUpdated:self.contact];
    }
    [self.navigationController popViewControllerAnimated:YES];
}

-(IBAction) selectImage:(id)sender {
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        
    }
    else {
        UIImagePickerController *picker = [UIImagePickerController new];
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        picker.allowsEditing = YES;
        picker.delegate = self;
        [self presentViewController:picker animated:YES completion:nil];
        
    }
}

-(void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    UIImage *selectedImage = [info valueForKey:UIImagePickerControllerEditedImage];
    [self.addImage setBackgroundImage:selectedImage forState:UIControlStateNormal];
    [self.addImage setTitle:nil forState: UIControlStateNormal];
    [picker dismissViewControllerAnimated:YES completion:nil];
}

-(IBAction) getGeocoder:(id)sender {
    CLGeocoder *geocoder = [CLGeocoder new];
    [geocoder geocodeAddressString:self.address.text completionHandler:^(NSArray *results, NSError *error) {
        if  (error == nil && [results count] > 0) {
            CLPlacemark *result = results[0];
            CLLocationCoordinate2D coordinate = result.location.coordinate;
            self.latitude.text = [NSString stringWithFormat:@"%f", coordinate.latitude];
            self.longitude.text = [NSString stringWithFormat:@"%f", coordinate.longitude];
        }
    }];
}

@end
