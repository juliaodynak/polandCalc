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
    p=0;k=0;
//    readySetGo[0] = polExpression[0];
//    stackOfOperations[0] = polExpression[1];
//    readySetGo[1] = polExpression [2];
    for( i = 0; i < capacity; i++)
    {
        if([polExpression[i]  isEqualToString: @"+"] || [polExpression[i] isEqualToString: @"-"])
        {
            k= stackOfOperations.count-1;
            if (proper >0)
            {
                k++;
                stackOfOperations[k] = polExpression[i];
            }
            else if (stackOfOperations.count == 0)
            {
                stackOfOperations[0] = polExpression[i];
            }

           else if([stackOfOperations[k] isEqualToString:@"*"] || [stackOfOperations[k] isEqualToString:@"/"] )
            {
                int j = k;
                while (j >= 1)
                {
                    readySetGo[p] = stackOfOperations[j];
                    [stackOfOperations removeObjectAtIndex:j];
                    j--;
                    p++;
                    
                }
                readySetGo[p] = stackOfOperations[0];
                p++;
                stackOfOperations[0] = polExpression[i];
                k = 0;
            }
            else if([stackOfOperations[k] isEqualToString:@"+"] || [stackOfOperations[k] isEqualToString:@"-"])
            {
                int j = k;
                while (j >= 1)
                {
                    readySetGo[p] = stackOfOperations[j];
                    [stackOfOperations removeObjectAtIndex:j];
                    j--;
                    p++;
                    
                }
                readySetGo[p] = stackOfOperations[0];
                p++;
                stackOfOperations[0] = polExpression[i];
                k = 0;
            }

        }
        if([polExpression [i] isEqualToString:@"*"] || [polExpression[i] isEqualToString:@"/"])
        {
            k = stackOfOperations.count-1;
            if (proper > 0)
            {
                k++;
                stackOfOperations[k] = polExpression[i];
            }
            else if (stackOfOperations.count == 0)
            {
                stackOfOperations[0] = polExpression[i];
            }
            else if([stackOfOperations[k] isEqualToString:@"*"] || [stackOfOperations[k] isEqualToString:@"/"])
            {
                readySetGo[p] = stackOfOperations[k];
                p++;
                stackOfOperations[k] = polExpression[i];
            }
            else if([stackOfOperations[k] isEqualToString:@"+"] || [stackOfOperations[k] isEqualToString:@"-"] )
            {
                k++;
                stackOfOperations[k] = polExpression[i];
                
            }
        }
        if([polExpression[i] isEqualToString:@"("])
        {
            if (stackOfOperations.count == 0)
            {
                stackOfOperations[0] = polExpression[i];
                proper++;
            }
            else
            {
                k = stackOfOperations.count;
                stackOfOperations[k] = polExpression[i];
                proper++;
            }
        }
        if ([polExpression[i] isEqualToString:@")"])
        {
            int j = k;
            while (j < stackOfOperations.count && ![stackOfOperations[j] isEqualToString:@"("])
            {
                readySetGo[p] = stackOfOperations[j];
                [stackOfOperations removeObjectAtIndex:j];
                j--;
                p++;
                
            }
            proper--;
            [stackOfOperations removeObjectAtIndex:j];
            k -= 2;
        }
        if (![polExpression[i]  isEqualToString: @""])
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
        if(![stackOfOperations[k] isEqualToString: @"("] && ![stackOfOperations[k] isEqualToString:@"("])
        {
            readySetGo[p] = stackOfOperations[k];
            [stackOfOperations removeObjectAtIndex:k];
            k--;
            p++;
        }
    }
    if(![stackOfOperations[0] isEqualToString: @"("] && ![stackOfOperations[0] isEqualToString:@"("])
    {
        readySetGo[p] = stackOfOperations[0];
    }
    
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
            [polExpression removeObjectAtIndex:k];
            //k--;
            //polExpression[k-1] = res2;
            
        }
    }
    
    display.text = polExpression[0];
    
    
}



@end
