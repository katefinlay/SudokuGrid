//
//  Sudoku_GridTests.m
//  Sudoku GridTests
//
//  Created by Katharine Finlay on 9/14/14.
//  Copyright (c) 2014 Kate Finlay, Alejandro Mendoza. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "KFAMGridModel.h"

@interface Sudoku_GridTests : XCTestCase {
    KFAMGridModel* _gridModel;
}

@end

@implementation Sudoku_GridTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    _gridModel = [KFAMGridModel alloc];
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
    XCTAssertTrue([_gridModel isMutableForRow:0 andCol:1], @"Checking a sample true value");
    XCTAssertTrue(![_gridModel isMutableForRow:0  andCol:0], @"Checking a sample false value");
}

- (void)test_inputNumber
{
    int numToInput = 3;
    [_gridModel inputNumber:numToInput atRow:0 andCol:1]; // shouldn't be here;
    XCTAssertTrue([_gridModel getNumberWithRow:0 andCol:1] == numToInput, @"Checking that number was inputed, even though invalid");
    [_gridModel inputNumber:numToInput atRow:1 andCol:0];
    XCTAssertTrue([_gridModel getNumberWithRow:1 andCol:0] == numToInput, @"Checking that a valid number was inputed");
}

@end
