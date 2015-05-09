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
#import "ContactDao.h"

@interface ContactsInMapViewController : UIViewController<MKMapViewDelegate>
@property (nonatomic, weak) IBOutlet MKMapView *map;
@property (strong) CLLocationManager *manager;
@property (nonatomic, weak) NSMutableArray *contacts;
@property (strong) ContactDao *dao;
@end
