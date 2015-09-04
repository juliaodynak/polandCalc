//
//  ViewController.h
//  calc_pol
//
//  Created by adminaccount on 9/3/15.
//  Copyright (c) 2015 pelekh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (nonatomic, strong) NSString *currentString;
@property (nonatomic, strong) NSString *polandExpression;
@property (weak, nonatomic) IBOutlet UILabel *display;
@property (strong, nonatomic) NSString *bufString;


@end

