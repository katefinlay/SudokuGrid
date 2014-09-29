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
#import "KFAMGridGenerator.h"
//#import "KFAMTimer.h"

int numPadArray[9] = {1,2,3,4,5,6,7,8,9};

@interface KFAMViewController() {
    KFAMGridView* _grid;
    KFAMNumPadView* _numPad;
    KFAMGridModel* _gridModel;
    KFAMGridGenerator* _gridGenerator;
    int _initialGrid[81];
    NSDate* _startTime;
}

@end

@implementation KFAMViewController


// Returns the vlue in the initial grid
- (int)getNumberWithRow:(int)row
                 andCol:(int)col {
        return _initialGrid[row*9 + col];
}


// Sets background color and makes gridview set up
// the Sudoku board.
- (void)viewDidLoad {
    // make sure things loaded correctly
    [super viewDidLoad];

    _startTime = [NSDate date];
    
    _gridGenerator = [[KFAMGridGenerator alloc] init];
    [_gridGenerator getRawGrid];
    NSMutableArray *initGrid = [_gridGenerator getArray];

    
    
    
    for(int i=0;i<[initGrid count];i++) {
        NSNumber *index = [initGrid objectAtIndex:(NSUInteger) i];
        int toAdd = [index intValue];
        _initialGrid[i] = toAdd;
    }
    
    // initaliztion and allocation done when grid generator is
    // initalized, so no init needed here
    _gridModel = [_gridGenerator getGridModel];
    
    [self updateLabels];
    
    // Create sudoku board and place on the main view
    CGFloat x = CGRectGetWidth(self.view.frame);
    CGFloat y = CGRectGetHeight(self.view.frame);
    
    UIView *gridContainer = [[UIView alloc] initWithFrame:CGRectMake(x*.1,y*.16,x*0.8,y*0.8)];
    _grid = [[KFAMGridView alloc] initWithFrame:gridContainer.frame];
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
    
    // Initialize numpad
    UIView *numPadContainer = [[UIView alloc] initWithFrame:CGRectMake(x*.245 - 75,y*.79,x*0.6,y*0.14)];
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
    NSLog(@"You pressed the button at row %d, column %d.", row + 1, col + 1);
    
    // To identify whether a number can be inserted in the selected cell
    BOOL notInitial = [_gridModel canInsertAtRow:row andColumn:col];
    BOOL insertRow = [_gridModel canInsertValue:numPadSelected atRow:row];
    BOOL insertCol = [_gridModel canInsertValue:numPadSelected atCol:col];
    BOOL insertSubgrid = [_gridModel canInsertIntoSubgrid:numPadSelected atRow:row andCol:col];
    
    // If cell is not an initial value, insert the number selected on the numpad
    if (notInitial && insertRow && insertCol && insertSubgrid) {
        [_gridModel setValueAtRow:row column:col withValue:numPadSelected];
        
        [_grid setValueForCellAtCol:col andRow:row withValue:numPadSelected withColor:[UIColor blueColor]];
        
        NSLog(@"You inserted %d at row %d, column %d.", numPadSelected, row, col);
    }
    // If cell is an initial value, cannot insert
    else {
        NSLog(@"Cannot insert there; cell has initial value or value to insert is inconsistent.");
        
        
    }
    if ([_gridModel gridComplete]) {
        NSLog(@"Grid complete.");
        
        // when the current grid is complete, an alert appears to indicate completion and elapsed time
        NSDate* _endTime = [NSDate date];
        NSTimeInterval timeInterval = [_endTime timeIntervalSinceDate:_startTime];
        int intTimeInterval = (int)timeInterval;
        NSString *timeString = [NSString stringWithFormat:@"%d", intTimeInterval];
        
        UIAlertView *alertView = [[UIAlertView alloc]
                                  initWithTitle:@"Grid Complete!"
                                  message:[NSString stringWithFormat:@"You completed the grid in %@ seconds", timeString]
                                  delegate:nil
                                  cancelButtonTitle:@"Ok"
                                  otherButtonTitles:nil];
        [alertView show];
    }
    [self updateLabels];
}

// Gets information from numPadView and displays which button has been
// pressed on the console.
-(void)numPadPressed:(NSNumber*)buttonTag {
    int tag = [buttonTag intValue];
    NSLog(@"You selected %d for insertion.", tag + 1);
}

// the function that the restart button calls
- (IBAction)restartGame {
    CATransition *transition = [CATransition animation];
    transition.type = kCATransitionFade;
    transition.duration = 1;
    transition.timingFunction = [CAMediaTimingFunction
                                 functionWithName:kCAMediaTimingFunctionEaseOut];
    [self viewDidLoad];
    [self.view.layer addAnimation:transition forKey:nil];
}

// update the label for remaining cell count
- (void)updateLabels {
    int tilesLeft = [_gridModel remainingCells];
    self.countLabel.text = [NSString stringWithFormat:@"Tiles: %d", tilesLeft];
}

// Checks if memory was received.
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
