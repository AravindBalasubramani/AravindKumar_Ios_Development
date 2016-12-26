//
//  CategoryAddingViewController.h
//  RssReader
//
//  Created by AravindKumar on 12/25/16.
//  Copyright © 2016 DCI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddCategoryView.h"

@class AddCategoryView;

@interface CategoryAddingViewController : UIViewController<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *categoryNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *linkTextField;
- (IBAction)saveSelected:(id)sender;
- (IBAction)backButtonSelected:(id)sender;
@property(nonatomic,retain) AddCategoryView *addCategoryView;
@property (strong) UIActivityIndicatorView *mySpinner;
@property (strong)UIView* backgroundView;

@end
