//
//  Sudoku_GridTests.m
//  Sudoku GridTests
//
//  Created by Katharine Finlay on 9/14/14.
//  Copyright (c) 2014 Kate Finlay, Alejandro Mendoza. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "KFAMGridModel.h"
#import "KFAMGridGenerator.h"

@interface Sudoku_GridTests : XCTestCase {
    KFAMGridModel* _gridModel;
    KFAMGridGenerator* _gridGenerator;
}

@end

@implementation Sudoku_GridTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    _gridModel = [KFAMGridModel alloc];
    [_gridModel initialize];
    _gridGenerator = [KFAMGridGenerator alloc];
    [_gridGenerator initialize];
    
    int testGrid[81] =
    {1,0,3,5,0,0,0,0,9,
        0,0,2,4,6,0,0,7,0,
        2,4,0,1,0,0,0,0,0,
        0,0,0,0,2,6,7,0,8,
        0,0,1,0,7,0,9,4,0,
        0,6,4,0,1,0,0,0,2,
        5,0,0,9,0,1,6,0,0,
        0,0,0,0,5,4,0,1,0,
        7,3,0,0,0,0,0,0,0};
    for (int r = 0; r < 9; r++) {
        for (int c = 0; c < 9; c++) {
            [_gridModel inputNumber:testGrid[(r*9 + c)] atRow:r andCol:c];
        }
    }
    
    
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)test_getNumberWithRow
{
    XCTAssertTrue([_gridModel getNumberWithRow:3 andCol:3] == 0, @"Checking a sample value");
    XCTAssertTrue([_gridModel getNumberWithRow:8 andCol:8] == 0, @"Checking that the highest values called work");
}

- (void)test_isValidValue
{
    XCTAssertTrue((![_gridModel isValidValue:1 forRow:0 andCol:1]), @"Checking a sample false value");
    XCTAssertTrue([_gridModel isValidValue:9 forRow:1 andCol:0], @"Checking a sample true value");
    XCTAssertTrue([_gridModel isValidValue:8 forRow:0 andCol:0], @"Checking that an unmutable value can still be valid, this is handled by isMutableForRow");
}

- (void)test_isMutableForRow
{
    [_gridModel makeNewGame];
    int sampleMutableIndex = 82;
    for (int i = 0; i < 81; i++) {
        if ([_gridModel getNumberWithRow:i/9 andCol:i%9] == 0) {
            sampleMutableIndex = i;
        }
    }
    XCTAssertTrue([_gridModel isMutableForRow:sampleMutableIndex/9 andCol:sampleMutableIndex%9], @"Checking a sample true value");
}

- (void)test_inputNumber
{
    int numToInput = 3;
    [_gridModel inputNumber:numToInput atRow:0 andCol:1]; // shouldn't be here;
    XCTAssertTrue([_gridModel getNumberWithRow:0 andCol:1] == numToInput, @"Checking that number was inputed, even though invalid");
    [_gridModel inputNumber:numToInput atRow:1 andCol:0];
    XCTAssertTrue([_gridModel getNumberWithRow:1 andCol:0] == numToInput, @"Checking that a valid number was inputed");
}


- (void)test_generateNewGrid {
    [_gridGenerator generateNewGrid];
    int initialGrid[81];
    for (int r = 0; r < 9; r++) {
        for (int c = 0; c < 9; c++) {
            initialGrid[r*9 + c] = [_gridGenerator getNumberWithRow:r andCol:c];
        }
    }
    [_gridGenerator generateNewGrid];
    BOOL gridChanged = false;
    for (int r = 0; r < 9; r++) {
        for (int c = 0; c < 9; c++) {
            int initNum = initialGrid[r*9 + c];
            int newNum = [_gridGenerator getNumberWithRow:r andCol:c];
            NSLog(@"init num %d newNum %d", initNum, newNum);
            if (initNum != newNum) {
                gridChanged = true;
            }
        }
    }
    XCTAssert(gridChanged, @"Checking that generate new grid changes the grid");
    
}

- (void)test_makeNewGame {
    [_gridModel makeNewGame];
    int initialGrid[81];
    for (int r = 0; r < 9; r++) {
        for (int c = 0; c < 9; c++) {
            initialGrid[r*9 + c] = [_gridModel getNumberWithRow:r andCol:c];
        }
    }
    
    [_gridModel makeNewGame];
    
    BOOL gridChanged = false;
    for (int r = 0; r < 9; r++) {
        for (int c = 0; c < 9; c++) {
            if (initialGrid[r*9 + c] != [_gridModel getNumberWithRow:r andCol:c]) {
                gridChanged = true;
            }
        }
    }
    XCTAssert(gridChanged, @"Checking that generate new grid changes the grid");
}

- (void) test_checkSolution {
    for (int i = 0; i < 81; i++) {
        [_gridModel inputNumber:1 atRow:i/9 andCol:i%9];
    }
    XCTAssert([_gridModel checkSolution], @"checking that filling the grid will cause it to behave as expected, to identify it as a checked solution"); //if ismutable and isvalid checks work, then we only need to check if the grid is full to see if the grid is solved.
}


@end
