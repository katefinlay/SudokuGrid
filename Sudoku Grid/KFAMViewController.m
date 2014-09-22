//
//  KFAMViewController.m
//  viewTutorial
//
//  Created by Katharine Finlay on 9/11/14.
//  Copyright (c) 2014 Kate Finlay. All rights reserved.
//

#import "KFAMViewController.h"
#import "KFAMGridView.h"
#import "KFAMGridModel.h"
#import "KFAMNumPadView.h"

@interface KFAMViewController() {
    KFAMGridView* _grid;
    KFAMGridModel* _gridModel;
    KFAMNumPadView* _numPad;
}

@end

@implementation KFAMViewController



- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    CGRect frame = self.view.frame;
    
    CGFloat x = CGRectGetWidth(frame)*.1;
    CGFloat y = CGRectGetHeight(frame)*.1;
    CGFloat size = MIN(CGRectGetWidth(frame), CGRectGetHeight(frame))*.8;
    
    CGRect gridFrame = CGRectMake(x, y, size, size);
    CGRect numPadFrame = CGRectMake(x, y + size + size*0.12, size, size*0.12);

    _grid = [[KFAMGridView alloc] initWithFrame:gridFrame];
    _gridModel = [KFAMGridModel alloc];
    _numPad = [[KFAMNumPadView alloc] initWithFrame:numPadFrame];
    
    [_grid setAction:@selector(buttonPressed:) withTarget:self];
    
    [self.view addSubview:_grid];
    [self.view addSubview:_numPad];
    
    //set the initial values for the sudoku grid
    for (int r = 0; r < 9; r++) {
        for (int c = 0; c < 9; c++) {
            int toInsert = [_gridModel getNumberWithRow:c andCol:r];
            [_grid setValueForCellAtRow:c andCol:r withValue:toInsert];
        }
    }
    
    //tests
    //BOOL val = [_gridModel isValidValue:3 forRow:0 andCol:7];
    
    
}

-(void)buttonPressed:(NSNumber*)buttonTag {
    //The button tag is utilized to store the button number, from 1:81. To get
    //the row and column, divide by 9(row) and take the remainder(col).
    int num = [buttonTag intValue];
    int row = num/9;
    int col = num%9;
    
    NSLog(@"You pressed the button at row %d, column %d!", row,col);
    
    int currentNumSelected = [_numPad getCurrentNumSelected];
    BOOL isMutable = [_gridModel isMutableforRow:row andCol:col];
    BOOL isValid = [_gridModel isValidValue:currentNumSelected forRow:row andCol:col];
    
    if (isMutable && isValid) {
        [_gridModel inputNumber:currentNumSelected atRow:row andCol:col];
        [_grid displayNumber:currentNumSelected atRow:row andCol:col];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
