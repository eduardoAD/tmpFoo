//
//  DetailViewController.h
//  tmpFoo
//
//  Created by Eduardo Alvarado Díaz on 10/23/14.
//  Copyright (c) 2014 Organization. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;
@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

@end

