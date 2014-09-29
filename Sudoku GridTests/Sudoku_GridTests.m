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

@interface Sudoku_GridTests : XCTestCase
{
    KFAMGridModel* _model;
    KFAMGridModel* _fullModel;
    
    KFAMGridGenerator* _modelGen;
}

@end

@implementation Sudoku_GridTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    _model = [[KFAMGridModel alloc] init];
    _fullModel = [[KFAMGridModel alloc] fullinit];
    _modelGen = [[KFAMGridGenerator alloc] init];
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

// some tests for GridModel
- (void)testValues
{
    // TESTS FOR GRIDMODEL CLASS
    
    // some tests for inserting into a certain row with consistency
    XCTAssertTrue([_model canInsertValue:1 atRow:0]==false, @"Cannot insert");
    XCTAssertTrue([_model canInsertValue:1 atRow:1]==true, @"Can insert");
    
    // some tests for inserting into a certain column with consistency
    XCTAssertTrue([_model canInsertValue:1 atCol:0]==false, @"Cannot insert");
    XCTAssertTrue([_model canInsertValue:5 atCol:1]==true, @"Can insert");
    
    // some tests for inserting into a certain subgrid with consistency
    XCTAssertTrue([_model canInsertIntoSubgrid:1 atRow:0 andCol:2]==false, @"Cannot insert");
    XCTAssertTrue([_model canInsertIntoSubgrid:6 atRow:0 andCol:2]==true, @"Can insert");
    
    // some tests for getValueAtRowandColumn
    XCTAssertTrue([_model getValueAtRow:0 andColumn:0]==1, @"Testing edge case");
    XCTAssertTrue([_model getValueAtRow:9 andColumn:9]==0, @"Testing edge case");
    XCTAssertTrue([_model getValueAtRow:4 andColumn:5]==0, @"Testing for number somewhere in the middle");
    XCTAssertTrue([_model getValueAtRow:2 andColumn:7]==0, @"Testing for number somewhere in the middle");
    
    // some tests for canInsert (which keeps track of initial grid values), before inserting
    // anything
    XCTAssertTrue([_model canInsertAtRow:0 andColumn:0]==false, @"Cannot insert into initial value");
    XCTAssertTrue([_model canInsertAtRow:9 andColumn:9]==true, @"Can insert into non-initial value");
    
    // some tests for inserting a value into a certain position
    [_model setValueAtRow:0 column:0 withValue:9];
    XCTAssertTrue([_model getValueAtRow:0 andColumn:0]==9, @"Testing edge case");
    [_model setValueAtRow:9 column:9 withValue:5];
    XCTAssertTrue([_model getValueAtRow:9 andColumn:9]==5, @"Testing edge case");
    [_model setValueAtRow:0 column:0 withValue:6];
    XCTAssertTrue([_model getValueAtRow:0 andColumn:0]==6, @"Testing inserting over inserted value");
    [_model setValueAtRow:9 column:9 withValue:1];
    XCTAssertTrue([_model getValueAtRow:9 andColumn:9]==1, @"Testing inserting over inserted value");
    
    // some tests for canInsert, after inserting new values
    XCTAssertTrue([_model canInsertAtRow:0 andColumn:0]==false, @"Cannot insert into initial value");
    XCTAssertTrue([_model canInsertAtRow:9 andColumn:9]==true, @"Can insert into a cell that has been inserted into");
    
    // some tests for gridComplete
    XCTAssertTrue([_model gridComplete]==false, @"Grid is not complete");
    XCTAssertTrue([_fullModel gridComplete]==true, @"Grid is full");
    
    // some tests for remainingCells
    XCTAssertTrue([_model remainingCells]==49, @"Semi-full grid");
    XCTAssertTrue([_fullModel remainingCells]==0, @"Full grid");
    
    
    //TESTS FOR GRIDGENERATOR CLASS
    
    [_modelGen getRawGrid];
    
    // test for getArray
    XCTAssertTrue([[_modelGen getArray] count]==81, @"Checking size of generated grid");
    
    // test for getGridModel
    XCTAssertTrue([[_modelGen getGridModel] isKindOfClass:[KFAMGridModel class]], @"Checking that generated grid is of the right type");
}

@end
