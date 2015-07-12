//
//  DetailViewController.h
//  WirestromTJ
//
//  Created by Klishevich, Yauheni on 13/07/2015.
//  Copyright (c) 2015 YKL-soft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;
@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

@end

