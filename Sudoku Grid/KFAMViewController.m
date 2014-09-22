//
//  KFAMViewController.m
//
//  Created by John Park and Alejandro Mendoza on 9/16/14.
//  Copyright (c) 2014 John Park, Alejandro Mendoza. All rights reserved.
//

#import "KFAMViewController.h"
#import "KFAMGridView.h"
#import "KFAMGridModel.h"
#import "KFAMNumPadView.h"

int initialGrid[81] =
{1,0,3,5,0,0,0,0,9,
    0,0,2,4,6,0,0,7,0,
    0,4,0,1,0,0,0,0,0,
    0,0,0,0,2,6,7,0,8,
    0,0,1,0,7,0,9,4,0,
    0,6,4,0,1,0,0,0,2,
    5,0,0,9,0,1,6,0,0,
    0,0,0,0,5,4,0,1,0,
    7,3,0,0,0,0,0,0,0};

int numPadArray[9] = {1,2,3,4,5,6,7,8,9};

@interface KFAMViewController() {
    KFAMGridView* _grid;
    KFAMNumPadView* _numPad;
    KFAMGridModel* _gridModel;
}

@end

@implementation KFAMViewController


// Returns the vlue in the initial grid
- (int)getNumberWithRow:(int)row
                 andCol:(int)col
{
        return initialGrid[row*9 + col];
}


// Sets background color and makes gridview set up
// the Sudoku board.
- (void)viewDidLoad {
    // make sure things loaded correctly
    [super viewDidLoad];
    
    _gridModel = [[KFAMGridModel alloc] init];
    [_gridModel initializeGrid:initialGrid];
    
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
            [_grid setValueForCellAtCol:r andRow:c withValue:toInsert];
            NSLog(@"We are inserting %d at row %d, column %d", toInsert, r, c);
        }
    }
    [self.view addSubview:_grid];
    
    // Initialize numpad
    
    CGFloat x = CGRectGetWidth(self.view.frame);
    CGFloat y = CGRectGetHeight(self.view.frame);
    UIView *numPadContainer = [[UIView alloc] initWithFrame:CGRectMake(x*.1,y*.8,x*1.035,y)];
    _numPad = [[KFAMNumPadView alloc] initWithFrame:numPadContainer.frame];
    for (int i = 0; i < 9; i++) {
        int toInsert = numPadArray[i];
        [_numPad setValueAtIndex:i withValue:toInsert];
    }
    [_numPad setAction:@selector(numPadPressed:) withTarget:self];
    [self.view addSubview:_numPad];
}

// Gets information from gridview and displays which button has been
// pressed on the console.
-(void)buttonPressed:(NSNumber*)buttonTag {
    int tag = [buttonTag intValue];
    int row = tag%9;
    int col = tag/9;
    int numPadSelected = [_numPad numSelected]+1; // increment by 1 because the tag index starts at 0.
    NSLog(@"You pressed the button at row %d, column %d!", row + 1, col + 1);
    
    // To identify whether a number can be inserted in the selected cell
    BOOL notInitial = [_gridModel canInsertAtRow:row andColumn:col];
    BOOL insertRow = [_gridModel canInsertValue:numPadSelected atRow:row];
    BOOL insertCol = [_gridModel canInsertValue:numPadSelected atCol:col];
    BOOL insertSubgrid = [_gridModel canInsertIntoSubgrid:numPadSelected atRow:row andCol:col];
    
    // If cell is not an initial value, insert the number selected on the numpad
    if (notInitial && insertRow && insertCol && insertSubgrid) {
        [_gridModel setValueAtRow:row column:col withValue:numPadSelected];
        
        [_grid setValueForCellAtCol:col andRow:row withValue:numPadSelected withColor:[UIColor blueColor]];
        
        NSLog(@"You inserted %d at row %d, column %d", numPadSelected, row, col);
    }
    // If cell is an initial value, cannot insert
    else {
        NSLog(@"You cannot insert into cells with initial values.");
    }
}

// Gets information from numPadView and displays which button has been
// pressed on the console.
-(void)numPadPressed:(NSNumber*)buttonTag {
    int tag = [buttonTag intValue];
    NSLog(@"You selected button number %d", tag + 1);
}


// Checks if memory was received.
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
