//
//  ContactListViewController.m
//  ContatosIP67
//
//  Created by ios5065 on 18/04/15.
//  Copyright (c) 2015 Caelum. All rights reserved.
//

#import "ContactListViewController.h"
#import "ContactFormViewController.h"
#import "ActionManager.h"

@implementation ContactListViewController

-(id) init {
    self = [super init];
    if (self) {
        UIImage *imageTabItem = [UIImage imageNamed:@"contactlist.png"];
        UITabBarItem *tabItem = [[UITabBarItem alloc] initWithTitle:@"Contacts" image:imageTabItem tag:0];
        self.tabBarItem = tabItem;
        self.navigationItem.title = @"Contacts";
        UIBarButtonItem *buttonShowForm = [[UIBarButtonItem alloc]
                                            initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                            target:self action:@selector(showForm)];
        self.navigationItem.rightBarButtonItem = buttonShowForm;
        self.navigationItem.leftBarButtonItem = self.editButtonItem;
        self.dao = [ContactDao contactDaoInstance];
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(showMoreActions:)];
    [self.tableView addGestureRecognizer:longPress];
}

-(void)viewDidAppear:(BOOL)animated {
    [self.tableView reloadData];
    if (self.line == 0 && [self.dao.contacts count] > 0) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.line inSection:0];
        [self.tableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionNone];
        [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionNone animated:YES];
        self.line = 1;
    }
}

-(void) showMoreActions:(UIGestureRecognizer *)gesture {
    if (gesture.state == UIGestureRecognizerStateBegan) {
        CGPoint point = [gesture locationInView:self.tableView];
        NSIndexPath *index = [self.tableView indexPathForRowAtPoint:point];
        if (index) {
            self.contact_selected = [self.dao getContactPosition:index.row];
            _actionManager = [[ActionManager alloc] initWithContact:self.contact_selected];
            [self.actionManager controllerActions:self];
        }

    }
}

-(void) showForm {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    ContactFormViewController *form = [storyboard instantiateViewControllerWithIdentifier:@"contact-form"];
    form.delegate = self;
    if (self.contact_selected) {
        form.contact = self.contact_selected;
    }
    [self.navigationController pushViewController:form animated:YES];
    //[self alertShow];
}

-(void) showAlert {
    UIAlertController *alertController = [UIAlertController
                                          alertControllerWithTitle:@"Formulário"
                                          message:@"Aqui vamos exibir o formulário"
                                          preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction
                               actionWithTitle:NSLocalizedString(@"OK", @"OK action")
                               style:UIAlertActionStyleDefault
                               handler:^(UIAlertAction *action)
                               {
                                   NSLog(@"OK action");
                               }];
    [alertController addAction:okAction];
    [self presentViewController:alertController animated:YES completion:nil];
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.dao.contacts count];
}

-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"Cell";

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    Contact *contact = [self.dao getContactPosition: indexPath.row];
    cell.textLabel.text = contact.name;
    return cell;
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.dao removeContactOfPosition:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.contact_selected = [self.dao getContactPosition: indexPath.row];
    [self showForm];
    //NSLog(@"Name: %@", self.contact_selected.name);
    self.contact_selected = nil;
}

-(void)contactUpdated:(Contact *) contact {
    self.line = [self.dao getPositionOfContact:contact];
    //NSLog(@"contact updated: %@", contact.name);
}

-(void)contactCreated:(Contact *) contact {
    self.line = [self.dao getPositionOfContact:contact];
    //NSLog(@"contact created: %@", contact.name);
}

@end

