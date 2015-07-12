//
//  MasterViewController.m
//  WirestromTJ
//
//  Created by Klishevich, Yauheni on 13/07/2015.
//  Copyright (c) 2015 YKL-soft. All rights reserved.
//

#import "MasterViewController.h"
#import "DetailViewController.h"

#import "AFNetworking.h"
#import <UIImageView+AFNetworking.h>
#import "KMKDimmedViewWithActivityIndicator.h"


@interface MasterViewController ()

@property NSArray *objects;

@end

@implementation MasterViewController {
    KMKDimmedViewWithActivityIndicator *_viewWithIndicator;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _viewWithIndicator = [KMKDimmedViewWithActivityIndicator new];
    [self.view addSubview:_viewWithIndicator];
    [_viewWithIndicator adjustToBoundsOfSuperView];
    
    [self queryPersons];
}

#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        NSDate *object = self.objects[indexPath.row];
        [[segue destinationViewController] setDetailItem:object];
    }
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.objects.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];

    NSDictionary *object = self.objects[indexPath.row];
    cell.textLabel.text = [object valueForKey:@"name"];
    cell.detailTextLabel.text = [object valueForKey:@"position"];
    NSURL *url = [NSURL URLWithString:[object valueForKey:@"smallpic"]];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    __weak UITableViewCell *weakCell = cell;

    [cell.imageView setImageWithURLRequest:request
                          placeholderImage:nil
                                   success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
                                       weakCell.imageView.image = image;
                                       [weakCell setNeedsLayout];
                                       
                                   } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
                                       
                                   }];
    
    return cell;
}

- (void)queryPersons {
    
    [_viewWithIndicator showActivityIndicator];
    
    NSString *string = @"https://s3-us-west-2.amazonaws.com/wirestorm/assets/response.json";
    NSURL *url = [NSURL URLWithString:string];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [_viewWithIndicator hideActivityIndicator];

        self.objects = (NSArray *)responseObject;
        [self.tableView reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [_viewWithIndicator hideActivityIndicator];
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error Retrieving Objects"
                                                            message:[error localizedDescription]
                                                           delegate:nil
                                                  cancelButtonTitle:@"Ok"
                                                  otherButtonTitles:nil];
        [alertView show];
    }];
    
    [operation start];
}

@end
