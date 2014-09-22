//
//  Sudoku_GridTests.m
//  Sudoku GridTests
//
//  Created by Katharine Finlay on 9/14/14.
//  Copyright (c) 2014 Kate Finlay, Alejandro Mendoza. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "KFAMGridModel.h"

@interface Sudoku_GridTests : XCTestCase
{
    KFAMGridModel* _model;
}

@end

@implementation Sudoku_GridTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    _model = [[KFAMGridModel alloc] init];
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

// some tests for GridModel
- (void)testValues
{
    [_model {1,0,3,5,0,0,0,0,9,0,0,2,4,6,0,0}];
    XCTAssertTrue([_model getValueAtRow:0 andColumn:0]==1, @"Testing base case");
    XC
}

@end
