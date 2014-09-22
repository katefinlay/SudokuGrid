//
//  KFAMViewController.m
//
//  Created by John Park and Alejandro Mendoza on 9/16/14.
//  Copyright (c) 2014 John Park, Alejandro Mendoza. All rights reserved.
//

#import "KFAMViewController.h"
#import "KFAMGridView.h"

// int array we give to gridview to build the initial grid
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


// Returns the vlue in the initial grid
- (int)getNumberWithRow:(int)row
                 andCol:(int)col {
    return initialGrid[row*9 + col];
}


// Sets background color and makes gridview set up
// the Sudoku board.
- (void)viewDidLoad {
    // make sure things loaded correctly
    [super viewDidLoad];
    
    // Make the main background color white
    self.view.backgroundColor = [UIColor whiteColor];
	
    // Create sudoku board and place on the main view
    _grid = [[KFAMGridView alloc] initWithFrame:self.view.frame];
    [_grid setAction:@selector(buttonPressed:) withTarget:self];
    
    // Run through our array of initial values and give values
    // to gridview to build the board.
    for (int r = 0; r<9; r++) {
        for (int c = 0; c<9; c++) {
            int toInsert = [self getNumberWithRow:c andCol:r];
            [_grid setValueForCellAtRow:r andCol:c withValue:toInsert];
        }
    }
    [self.view addSubview:_grid];
}

// Gets information from gridview and displays which button has been
// pressed on the console.
-(void)buttonPressed:(NSNumber*)buttonTag {
    int tag = [buttonTag intValue];
    NSLog(@"You pressed the button at row %d, column %d!", tag%9 + 1,tag/9 + 1);
}

// Checks if memory was received.
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
