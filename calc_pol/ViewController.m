//
//  ViewController.m
//  calc_pol
//
//  Created by adminaccount on 9/3/15.
//  Copyright (c) 2015 pelekh. All rights reserved.
//

#import "ViewController.h"
#import "Expression_counter.h"

@interface ViewController ()

@end

@implementation ViewController

@synthesize currentString = _currentString;
@synthesize bufString = _bufString;
@synthesize polandExpression = _polandExpression;
@synthesize display;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.currentString = @"";
    self.polandExpression = @"";
    self.bufString = @"";
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)putDigit:(UIButton *)sender
{
    _bufString = sender.currentTitle;
    _currentString = [_currentString stringByAppendingString: _bufString];
    display.text = _currentString;
  
}

- (IBAction)putOperation:(UIButton *)sender
{
    _bufString = sender.currentTitle;
    _currentString = [_currentString stringByAppendingString: _bufString];
    display.text = _currentString;

}
- (IBAction)makeMeResult:(UIButton *)sender
{
    //Expression_counter *expression = [Expression_counter SharedInstance];
    NSMutableArray *polExpression = [[NSMutableArray alloc] init];
    NSMutableArray *stackOfOperations = [[NSMutableArray alloc] init];
    NSMutableArray *readySetGo = [[NSMutableArray alloc] init];
    NSString *con = @"", *newObj = @"", *operationsList = @"+-*/()";
    NSUInteger len = _currentString.length, i=0, capacity;
    NSRange mayBeOperation;
    int k=0,p=2, proper=0;
    
    for (i=0; i<len; i++)
    {
        con = [_currentString substringWithRange: NSMakeRange(i,1)];
        mayBeOperation = [operationsList rangeOfString:con];
        if (mayBeOperation.length==0)
        {
            newObj = [newObj stringByAppendingString:con];
        }
        else
        {
            [polExpression addObject:newObj];
            [polExpression addObject:con];
            newObj = @"";
        }
    }
    [polExpression addObject:newObj];
    
    capacity = polExpression.count;
    readySetGo[0] = polExpression[0];
    stackOfOperations[0] = polExpression[1];
    readySetGo[1] = polExpression [2];
    for( i = 3; i < capacity; i++)
    {
        if([polExpression[i]  isEqual: @"+"] || [polExpression[i] isEqual: @"-"])
        {
            if (proper >0)
            {
                k++;
                stackOfOperations[k] = polExpression[i];
            }

           else if([stackOfOperations[k] isEqual:@"*"] || [stackOfOperations[k] isEqual:@"/"] )
            {
                int j = k;
                while (j >= 1)
                {
                    readySetGo[p] = stackOfOperations[j];
                    [stackOfOperations removeObject:stackOfOperations[j]];
                    j--;
                    p++;
                    
                }
                readySetGo[p] = stackOfOperations[0];
                p++;
                stackOfOperations[0] = polExpression[i];
                k = 0;
            }
            else if([stackOfOperations[k] isEqual:@"+"] || [stackOfOperations[k] isEqual:@"-"])
            {
                int j = k;
                while (j >= 1)
                {
                    readySetGo[p] = stackOfOperations[j];
                    [stackOfOperations removeObject:stackOfOperations[j]];
                    j--;
                    p++;
                    
                }
                readySetGo[p] = stackOfOperations[0];
                p++;
                stackOfOperations[0] = polExpression[i];
                k = 0;
            }

        }
        if([polExpression [i] isEqual:@"*"] || [polExpression[i] isEqual:@"/"])
        {
            if (proper > 0)
            {
                k++;
                stackOfOperations[k] = polExpression[i];
            }
            else if([stackOfOperations[k] isEqual:@"*"] || [stackOfOperations[k] isEqual:@"/"])
            {
                readySetGo[p] = stackOfOperations[k];
                p++;
                stackOfOperations[k] = polExpression[i];
            }
            else if([stackOfOperations[k] isEqual:@"+"] || [stackOfOperations[k] isEqual:@"-"] )
            {
                k++;
                stackOfOperations[k] = polExpression[i];
                
            }
        }
        if([polExpression[i] isEqual:@"("])
        {
            k++;
            stackOfOperations[k] = polExpression[i];
            proper++;
        }
        if ([polExpression[i] isEqual:@")"])
        {
            int j = k;
            while (j < stackOfOperations.count && ![stackOfOperations[j] isEqual:@"("])
            {
                readySetGo[p] = stackOfOperations[j];
                [stackOfOperations removeObject:stackOfOperations[j]];
                j--;
                p++;
                
            }
            proper--;
            [stackOfOperations removeObject:stackOfOperations[j]];
            k-=2;
        }
        if (![polExpression[i]  isEqual: @""])
        {
            mayBeOperation = [operationsList rangeOfString:polExpression[i]];
            if (mayBeOperation.length==0)
            {
                readySetGo[p] = polExpression[i];
                p++;
            }
        }

    }
    k = stackOfOperations.count - 1;
    while (k>=1)
    {
        readySetGo[p] = stackOfOperations[k];
        [stackOfOperations removeObject:stackOfOperations[k]];
        k--;
        p++;
    }
    readySetGo[p] = stackOfOperations[0];
    
//    con = @"";
//    for( int i=0; i<readySetGo.count; i++)
//    {
//        con = [con stringByAppendingString:readySetGo[i]];
//    }
//    display.text = con;
//    
    
    
    k = 0;
    double res1, res2;
    con = @"";
    [polExpression removeAllObjects];
    polExpression = [[NSMutableArray alloc] init];
    for(int i=0; i<readySetGo.count; i++)
    {
        mayBeOperation = [operationsList rangeOfString:readySetGo[i]];
        if (mayBeOperation.length == 0)
        {
            con = @"";
            [polExpression addObject: [con stringByAppendingString:readySetGo[i]]];
            k++;
            con = @"";
        }
        else
        {
            k--;
            res1 = [polExpression[k] doubleValue];
            res2 = [polExpression[k-1] doubleValue];
            if ([readySetGo[i]  isEqual: @"+"])
            {
                res2+=res1;
            }
            if ([readySetGo[i]  isEqual: @"-"])
            {
                res2-=res1;
            }
            if ([readySetGo[i]  isEqual: @"*"])
            {
                res2*=res1;
            }
            if ([readySetGo[i]  isEqual: @"/"])
            {
                res2/=res1;
            }
            

            con = [NSString stringWithFormat:@"%f", res2];
            polExpression[k-1] = con;
            //[polExpression[k-1] stringWithFormat:@"%f", res2];
            [polExpression removeObject:polExpression[k]];
            //k--;
            //polExpression[k-1] = res2;
            
        }
    }
    
    display.text = polExpression[0];
    
    
}



@end
