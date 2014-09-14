//
//  KFAMViewController.m
//  viewTutorial
//
//  Created by Katharine Finlay on 9/11/14.
//  Copyright (c) 2014 Kate Finlay. All rights reserved.
//

#import "KFAMViewController.h"
#import "KFAMGridView.h"

int initialGrid[81] =
{1,0,3,5,0,0,0,0,9,
    0,0,2,4,6,0,0,7,0,
    2,4,0,1,0,0,0,0,0,
    0,0,0,0,2,6,7,0,8,
    0,0,1,0,7,0,9,4,0,
    0,6,4,0,1,0,0,0,2,
    5,0,0,9,0,1,6,0,0,
    0,0,0,0,5,4,0,1,0,
    7,3,0,0,0,0,0,0,0};
@interface KFAMViewController() {
    KFAMGridView* _grid;
}

@end

@implementation KFAMViewController

- (int)getNumberWithRow:(int)row
                 andCol:(int)col
{
    return initialGrid[row*9 + col];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
	
    _grid = [[KFAMGridView alloc] initWithFrame:self.view.frame];
    
    [_grid setAction:@selector(buttonPressed:) withTarget:self];
    
    [self.view addSubview:_grid];
    
    for (int r = 0; r<9; r++) {
        for (int c = 0; c<9; c++) {
            int toInsert = [self getNumberWithRow:c andCol:r];
            [_grid setValueForCellAtRow:c andCol:r withValue:toInsert];
        }
    }
    
}

-(void)buttonPressed:(NSNumber*)buttonTag
{
    int num = [buttonTag intValue];
    NSLog(@"You pressed the button at row %d, column %d!", num%9,num/9);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
