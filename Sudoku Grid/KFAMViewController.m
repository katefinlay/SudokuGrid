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
    
    NSURL *musicFile = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"RelaxingMusic" ofType:@"mp3"]];
    AVAudioPlayer *audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:musicFile error:nil];
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:nil];
    [[AVAudioSession sharedInstance] setActive:YES error:nil];
    [[UIApplication sharedApplication] beginReceivingRemoteControlEvents];
    [audioPlayer play];
    
    [super viewDidLoad];
    
    //Make the background a light green
    UIColor * color = [UIColor colorWithRed:136/255.0f green:169/255.0f blue:121/255.0f alpha:1.5f];
    self.view.backgroundColor = color;
    
    //create app frame
    CGRect frame = self.view.frame;
    //create grid frame. Width is 8/10 of screen size
    CGFloat x = CGRectGetWidth(frame)*.1;
    CGFloat y = CGRectGetHeight(frame)*.15;
    CGFloat size = MIN(CGRectGetWidth(frame), CGRectGetHeight(frame))*.8;
    CGRect gridFrame = CGRectMake(x, y, size, size);
    //create num pad frame with equally spaced buttons
    CGRect numPadFrame = CGRectMake(x, y + size + size*0.12, size, size*0.12);

    //Initialize and set up other classes
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
    
    int currentNumSelected = [_numPad getCurrentNumSelected];
    BOOL isMutable = [_gridModel isMutableForRow:row andCol:col];
    BOOL isValid = [_gridModel isValidValue:currentNumSelected forRow:row andCol:col];
    
    if (isMutable && isValid && currentNumSelected != 10) {
        [_gridModel inputNumber:currentNumSelected atRow:row andCol:col];
        UIColor * color = [UIColor colorWithRed:52/255.0f green:137/255.0f blue:56/255.0f alpha:1.0f];
        [_grid displayNumber:currentNumSelected atRow:row andCol:col andColor:color];
        
    } else if (currentNumSelected == 10 && isMutable) {
        //The 10th button is the clear button, input a 0
        [_gridModel inputNumber:0 atRow:row andCol:col];
        UIColor * color = [UIColor colorWithRed:52/255.0f green:137/255.0f blue:56/255.0f alpha:1.0f];
        [_grid displayNumber:0 atRow:row andCol:col andColor:color];
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
    
    [_newGameButton setBackgroundColor:[UIColor whiteColor]];
    [_restartGameButton setBackgroundColor:[UIColor whiteColor]];
    [_verifySolutionButton setBackgroundColor:[UIColor whiteColor]];
    
    [self.view addSubview:_newGameButton];
    [self.view addSubview:_restartGameButton];
    [self.view addSubview:_verifySolutionButton];
}

- (void)newGameButtonPressed:(id)sender {
    [self showConfirmNewGameAlert];
}

- (IBAction)showConfirmNewGameAlert {
    
    UIAlertView *alertView = [[UIAlertView alloc]
                              initWithTitle:[NSString stringWithFormat:@"Confirm New Game"]
                              message:[NSString stringWithFormat:@"Sure you want to start a new game?"]
                              delegate:self
                              cancelButtonTitle:@"Cancel"
                              otherButtonTitles:nil];
    [alertView addButtonWithTitle:@"Yes"];
    [alertView setTag:1];
    
    [alertView show];
}

- (void)newGameButtonConfirmed {
    [_gridModel makeNewGame];
    for (int r = 0; r < 9; r++) {
        for (int c = 0; c < 9; c++) {
            int toInsert = [_gridModel getNumberWithRow:c andCol:r];
            [_grid displayNumber:toInsert atRow:c andCol:r andColor:[UIColor blackColor]];
        }
    }
    [_numPad setCurrentNum:1];
}

- (void)restartGameButtonPressed:(id)sender {
    [self showConfirmRestartAlert];
}

- (IBAction)showConfirmRestartAlert {
    
    UIAlertView *alertView = [[UIAlertView alloc]
                              initWithTitle:[NSString stringWithFormat:@"Confirm Restart Game"]
                              message:[NSString stringWithFormat:@"Sure you want to restart?"]
                              delegate:self
                              cancelButtonTitle:@"Cancel"
                              otherButtonTitles:nil];
    [alertView addButtonWithTitle:@"Yes"];
    [alertView setTag:2];
    
    [alertView show];
}

- (void)restartButtonConfirmed {
    for (int r = 0; r < 9; r++) {
        for (int c = 0; c < 9; c++) {
            if ([_gridModel isMutableForRow:r andCol:c]) {
                [_gridModel inputNumber:0 atRow:r andCol:c];
                UIColor * color = [UIColor colorWithRed:52/255.0f green:137/255.0f blue:56/255.0f alpha:1.0f];
                [_grid displayNumber:0 atRow:r andCol:c andColor:color];
            }
        }
    }
    [_numPad setCurrentNum:1];
    
}

-(void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    if ([alertView tag] == 1) {
        if (buttonIndex == 1) {
            [self newGameButtonConfirmed];
        }
    } else if ([alertView tag] == 2) {
        if (buttonIndex == 1) {
            [self restartButtonConfirmed];
        }
    }
    if (buttonIndex == 1) {
        [self restartButtonConfirmed];
    }
}

- (void)verifySolutionButtonPressed:(id)sender {
    BOOL isCorrectSolution = [_gridModel checkSolution];
    if (isCorrectSolution) {
        [self showWinAlert];
    } else {
        [self showNotWinAlert];
    }
    
    
}

- (IBAction)showWinAlert {
    
    UIAlertView *alertView = [[UIAlertView alloc]
                              initWithTitle:[NSString stringWithFormat:@"Congratulations!"]
                              message:[NSString stringWithFormat:@"You won the game!"]
                              delegate:self
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
    
    [alertView show];
}

- (IBAction)showNotWinAlert {
    
    UIAlertView *alertView = [[UIAlertView alloc]
                              initWithTitle:[NSString stringWithFormat:@"Sorry"]
                              message:[NSString stringWithFormat:@"This is not a correct solution. Keep trying!"]
                              delegate:self
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
    
    [alertView show];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
