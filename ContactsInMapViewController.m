//
//  ContactsInMapViewController.m
//  ContatosIP67
//
//  Created by ios5065 on 02/05/15.
//  Copyright (c) 2015 Caelum. All rights reserved.
//

#import "ContactsInMapViewController.h"

@interface ContactsInMapViewController ()

@end

@implementation ContactsInMapViewController

-(id) init {
    self = [super init];
    if (self) {
        UIImage *imageTabItem = [UIImage imageNamed:@"map-contacts.png"];
        UITabBarItem *tabItem = [[UITabBarItem alloc] initWithTitle:@"Map" image:imageTabItem tag:0];
        self.tabBarItem = tabItem;
        self.navigationItem.title = @"Localization";

        self.dao = [ContactDao contactDaoInstance];
        self.contacts = self.dao.contacts;
        NSLog(@"contacts: %@", self.contacts.description);
    }
    return self;
}

-(void)viewDidLoad {
    //[super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    MKUserTrackingBarButtonItem *localizationButton = [[MKUserTrackingBarButtonItem alloc] initWithMapView:self.map];
    self.navigationItem.rightBarButtonItem = localizationButton;
    self.manager = [CLLocationManager new];
    [self.manager requestWhenInUseAuthorization];
}

-(void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillDisappear:(BOOL)animated {
    [self.map removeAnnotations:self.contacts];
}

-(void)viewWillAppear:(BOOL)animated {
    [self.map addAnnotations:self.contacts];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    if ([annotation isKindOfClass:[MKUserLocation class]]) {
        return nil;
    }
    static NSString *identifier = @"pino";
    MKPinAnnotationView *pino = (MKPinAnnotationView *)[self.map dequeueReusableAnnotationViewWithIdentifier:identifier];
    if (!pino) {
        pino = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifier];
    }
    else {
        pino.annotation = annotation;
    }
    Contact *contact = (Contact *) annotation;
    pino.pinColor = MKPinAnnotationColorRed;
    pino.canShowCallout = YES;
    if (contact.image) {
        UIImageView *contactImage = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, 0.0, 32.0, 32.0)];
        contactImage.image = contact.image;
        pino.leftCalloutAccessoryView = contactImage;
    }
    return pino;
}

@end
