//
//  DetailViewController.m
//  WirestromTJ
//
//  Created by Klishevich, Yauheni on 13/07/2015.
//  Copyright (c) 2015 YKL-soft. All rights reserved.
//

#import "DetailViewController.h"

#import <UIImageView+AFNetworking.h>
#import "KMKDimmedViewWithActivityIndicator.h"

@interface DetailViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation DetailViewController {
    KMKDimmedViewWithActivityIndicator *_viewWithIndicator;
}

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem {
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        
            
        // Update the view.
        [self configureView];
    }
}

- (void)configureView {
    // Update the user interface for the detail item.
    if (self.detailItem) {
        [_viewWithIndicator showActivityIndicator];
        
        NSDictionary *object = (NSDictionary *)_detailItem;
        NSURL *url = [NSURL URLWithString:[object valueForKey:@"lrgpic"]];
        
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        
        __weak DetailViewController *weakself = self;

        [self.imageView setImageWithURLRequest:request
                              placeholderImage:nil
                                       success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
                                           
                                           [_viewWithIndicator hideActivityIndicator];
                                           weakself.imageView.image = image;
                                           
                                       } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
                                           [_viewWithIndicator hideActivityIndicator];
                                       }];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _viewWithIndicator = [KMKDimmedViewWithActivityIndicator new];
    [self.view addSubview:_viewWithIndicator];
    [_viewWithIndicator adjustToBoundsOfSuperView];
    
    [self configureView];
}

@end
