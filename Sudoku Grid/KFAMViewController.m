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
    UIButton* _newGameButton;
    UIButton* _restartGameButton;
    UIButton* _verifySolutionButton;
}

@end

@implementation KFAMViewController



- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    CGRect frame = self.view.frame;
    
    CGFloat x = CGRectGetWidth(frame)*.1;
    CGFloat y = CGRectGetHeight(frame)*.15;
    CGFloat size = MIN(CGRectGetWidth(frame), CGRectGetHeight(frame))*.8;
    
    CGRect gridFrame = CGRectMake(x, y, size, size);
    CGRect numPadFrame = CGRectMake(x, y + size + size*0.12, size, size*0.12);

    _grid = [[KFAMGridView alloc] initWithFrame:gridFrame];
    _gridModel = [KFAMGridModel alloc];
    [_gridModel initialize];
    _numPad = [[KFAMNumPadView alloc] initWithFrame:numPadFrame];
    
    
    [_grid setAction:@selector(buttonPressed:) withTarget:self];
    
    [self.view addSubview:_grid];
    [self.view addSubview:_numPad];
    [self addMenuOptions:frame];
    
    
    //set the initial values for the sudoku grid
    for (int r = 0; r < 9; r++) {
        for (int c = 0; c < 9; c++) {
            int toInsert = [_gridModel getNumberWithRow:c andCol:r];
            //[_grid setValueForCellAtRow:c andCol:r withValue:toInsert];
            [_grid displayNumber:toInsert atRow:c andCol:r andColor:[UIColor blackColor]];
        }
    }

    
    
}

-(void)buttonPressed:(NSNumber*)buttonTag {
    //The button tag is utilized to store the button number, from 1:81. To get
    //the row and column, divide by 9(row) and take the remainder(col).
    int num = [buttonTag intValue];
    int row = num/9;
    int col = num%9;
    
    NSLog(@"You pressed the button at row %d, column %d!", row,col);
    NSLog(@"GRID:");
    for (int i = 0; i < 9; i++) {
        for (int j = 0; j < 9; j++) {
            NSLog(@"[%d][%d] : %d:", i, j, [_gridModel getNumberWithRow:i andCol:j]);
        }
    }
    
    int currentNumSelected = [_numPad getCurrentNumSelected];
    BOOL isMutable = [_gridModel isMutableForRow:row andCol:col];
    BOOL isValid = [_gridModel isValidValue:currentNumSelected forRow:row andCol:col];
    
    if (isMutable && isValid) {
        [_gridModel inputNumber:currentNumSelected atRow:row andCol:col];
        [_grid displayNumber:currentNumSelected atRow:row andCol:col andColor:[UIColor blueColor]];
    }
    
    
}

- (void)addMenuOptions:(CGRect)frame {
    CGFloat buttonHeight = CGRectGetWidth(frame)/20.0;
    CGFloat buttonWidth = CGRectGetWidth(frame)/5.0;
    CGFloat buttonX = CGRectGetWidth(frame)*.1;
    CGFloat buttonY = CGRectGetWidth(frame)*.1;
    
    _newGameButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    _restartGameButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    _verifySolutionButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    
    [_newGameButton addTarget:self action:@selector(newGameButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [_restartGameButton addTarget:self action:@selector(restartGameButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [_verifySolutionButton addTarget:self action:@selector(verifySolutionButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    _newGameButton.frame = CGRectMake(buttonX, buttonY, buttonWidth, buttonHeight);
    _restartGameButton.frame = CGRectMake(buttonX + buttonWidth*1.5, buttonY, buttonWidth, buttonHeight);
    _verifySolutionButton.frame = CGRectMake(buttonX + buttonWidth*3.0, buttonY, buttonWidth, buttonHeight);
    
    [_newGameButton setTitle:[NSString stringWithFormat:@"Start New Game"] forState:UIControlStateNormal];
    [_restartGameButton setTitle:[NSString stringWithFormat:@"Restart Game"] forState:UIControlStateNormal];
    [_verifySolutionButton setTitle:[NSString stringWithFormat:@"Check Solution"] forState:UIControlStateNormal];
    
    [_newGameButton setBackgroundColor:[UIColor redColor]];
    [_restartGameButton setBackgroundColor:[UIColor redColor]];
    [_verifySolutionButton setBackgroundColor:[UIColor redColor]];
    
    [self.view addSubview:_newGameButton];
    [self.view addSubview:_restartGameButton];
    [self.view addSubview:_verifySolutionButton];
}

- (void)newGameButtonPressed:(id)sender {
    [_gridModel makeNewGame];
    for (int r = 0; r < 9; r++) {
        for (int c = 0; c < 9; c++) {
            int toInsert = [_gridModel getNumberWithRow:c andCol:r];
            //[_grid setValueForCellAtRow:c andCol:r withValue:toInsert];
            [_grid displayNumber:toInsert atRow:c andCol:r andColor:[UIColor blackColor]];
        }
    }
    [_numPad setCurrentNum:1];
}

- (void)restartGameButtonPressed:(id)sender {
    for (int r = 0; r < 9; r++) {
        for (int c = 0; c < 9; c++) {
            if ([_gridModel isMutableForRow:r andCol:c]) {
                [_gridModel inputNumber:0 atRow:r andCol:c];
                [_grid displayNumber:0 atRow:r andCol:c andColor:[UIColor blueColor]];
            }
        }
    }
    [_numPad setCurrentNum:1];
    
}

- (void)verifySolutionButtonPressed:(id)sender {
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
