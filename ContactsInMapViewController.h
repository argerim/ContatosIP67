//
//  ContactsInMapViewController.h
//  ContatosIP67
//
//  Created by ios5065 on 02/05/15.
//  Copyright (c) 2015 Caelum. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <MapKit/MKMapView.h>

@interface ContactsInMapViewController : UIViewController
@property (weak) IBOutlet MKMapView *map;
@property (strong) CLLocationManager *manager;
@end
