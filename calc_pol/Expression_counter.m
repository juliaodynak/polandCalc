////
////  Expression_counter.m
////  calc_pol
////
////  Created by adminaccount on 9/3/15.
////  Copyright (c) 2015 pelekh. All rights reserved.
////
//
//#import <Foundation/Foundation.h>
//#import "Expression_counter.h"
//#import "ViewController.h"
//
//
//
//@implementation Expression_counter
//
//@synthesize operator1 = _operator1;
//@synthesize operator2 = _operator2;
//@synthesize codeOperation = _codeOperation;
//@synthesize polandEx = _polandEx;
//@synthesize readyEx = _readyEx;
//@synthesize stackOperations = _stackOperations;
//
//+ (Expression_counter*)SharedInstance
//{
//    static Expression_counter *ob;
//    static dispatch_once_t predicat;
//    
//    dispatch_once(&predicat, ^{
//        ob = [[Expression_counter alloc]init];
//    });
//    
//    return ob;
//}
//
//- (void)putOperator1:(NSMutableArray*)op1
//{
//    _polandEx = [[NSMutableArray alloc] init];
//    self.polandEx = op1;
//}
//
//- (void)makeExpressionToPoland:(NSMutableArray *)arr
//{
//    NSUInteger capacity = _polandEx.count;
//    _readyEx = [[NSMutableArray alloc] init];
//    _stackOperations = [[NSMutableArray alloc] init];
//    
//    //capacity = _polandEx.count;
//    _readyEx[0] = _polandEx[0];
//    _stackOperations[0] = _polandEx[1];
//    _readyEx[1] = _polandEx [2];
//    for( int i = 3; i < capacity; i++)
//    {
//    
//
//    }
//}
//
//- (double)binaryOperation:(NSInteger)codeOpBin
//{
//    
//    switch (codeOpBin)
//    {
//        case 10:
//            _operator1 += _operator2;
//            break;
//        case 20:
//            _operator1 -= _operator2;
//            break;
//        case 30:
//            _operator1 *= _operator2;
//            break;
//        case 40:
//            _operator1 /= _operator2;
//            break;
//    }
//    return _operator1;
//}
//
//- (double)unaryOperation:(NSInteger)codeOpUn
//{
//    double resultOp = 0.0;
//    
//    switch (codeOpUn)
//    {
//        case 50:
//            if(_codeOperation == 0)
//            {
//                _operator1 *= -1;
//                resultOp = _operator1;
//            }
//            else
//            {
//                _operator2 *= -1;
//                resultOp = _operator2;
//            }
//            break;
//        case 60:
//            if(_codeOperation == 0)
//            {
//                _operator1 = sqrt(_operator1);
//                resultOp = _operator1;
//            }
//            else
//            {
//                _operator2 = sqrt(_operator2);
//                resultOp = _operator2;
//            }
//            break;
//    }
//    return resultOp;
//}
//
//- (int) getPriority:(NSString *) element
//{
//        int prior = 0;
//        
//        if([element  isEqual: @"+"])
//        {
//            prior = 1;
//        }
//        if([element isEqual:@"-"])
//        {
//            prior = 1;
//        }
//        if([element isEqual:@"*"])
//        {
//            prior = 2;
//        }
//        if ([element isEqual:@"/"])
//        {
//            prior = 2;
//        }
//        return prior;
//}
//
//@end
//
//
