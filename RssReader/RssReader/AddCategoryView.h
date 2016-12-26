//
//  AddCategoryView.h
//  RssReader
//
//  Created by AravindKumar on 12/25/16.
//  Copyright © 2016 DCI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CategoryAddingViewController.h"

@class CategoryAddingViewController;
@interface AddCategoryView : UIView
@property (weak, nonatomic) IBOutlet UITextField *categoryNameTxtField;
@property (weak, nonatomic) IBOutlet UITextField *linkTxtField;
- (IBAction)cancelSelected:(id)sender;
- (IBAction)saveSelected:(id)sender;
@property(strong, nonatomic) CategoryAddingViewController*categoryAddingViewController;

@end
