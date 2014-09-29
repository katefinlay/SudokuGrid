//
//  KFAMViewController.h
//  Sudoku Grid
//
//  Created by John Park and Alejandro Mendoza on 9/16/14.
//  Copyright (c) 2014 John Park, Alejandro Mendoza. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KFAMViewController : UIViewController

// label that keeps count of currently blank cells
@property (nonatomic, strong) IBOutlet UILabel *countLabel;

// the function that the restart button calls
- (IBAction)restartGame;

@end
