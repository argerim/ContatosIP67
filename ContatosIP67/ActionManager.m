//
//  ActionManager.m
//  ContatosIP67
//
//  Created by ios5065 on 25/04/15.
//  Copyright (c) 2015 Caelum. All rights reserved.
//

#import "ActionManager.h"

@implementation ActionManager
-(id)initWithContact:(Contact *) contact {
    self = [super init];
    if (self) {
        self.contact = contact;
    }
    return self;
}

-(void)controllerActions:(UIViewController *) controller {
    self.controller = controller;
    UIActionSheet *options = [[UIActionSheet alloc] initWithTitle:self.contact.name delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Call", @"Send E-mail", @"Open Site", @"Show Map", nil];
    [options showInView:controller.view];
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    switch (buttonIndex) {
        case 0:
            [self call];
            break;
        case 1:
            [self sendMail];
            break;
        case 2:
           [self openSite];
            break;
        case 3:
            [self showMap];
            break;
        default:
            break;
    }
    
}

-(void) mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error {
    [self.controller dismissViewControllerAnimated:YES completion:nil];
}

-(void) sendMail {
    if ([MFMailComposeViewController canSendMail]) {
        MFMailComposeViewController *composeEmail = [MFMailComposeViewController new];
        composeEmail.mailComposeDelegate = self;
        [composeEmail setToRecipients:@[self.contact.email]];
        [composeEmail setSubject:@"Caelum"];
        [self.controller presentViewController:composeEmail animated:YES completion:nil];
    }
    else {
        [[[UIAlertView alloc] initWithTitle:@"Ops" message:@"Nao e possivel enviar emails" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil] show];
    }
}

-(void) openSite {
    NSString *url = self.contact.site;
    [self openApplicationWithURL:url];
}

-(void) openApplicationWithURL:(NSString *)url {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
}

-(void) showMap {
    NSString *url = [[NSString stringWithFormat:@"http://maps.google.com/maps?q=%@", self.contact.address] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [self openApplicationWithURL:url];
}

-(void) call {
    UIDevice *device = [UIDevice currentDevice];
    if ([device.model isEqualToString:@"iPhone"]) {
        NSString *number = [NSString stringWithFormat:@"tel:%@", self.contact.phone];
        [self openApplicationWithURL: number];
    }
    else {
        [[[UIAlertView alloc] initWithTitle:@"Impossivel fazer ligacao" message:@"Seu dispositivo nao e um iphone" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil] show];
    }
}
@end
