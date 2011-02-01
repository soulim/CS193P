//
//  CalculatorViewController.m
//  Calculator
//
//  Created by Alex Soulim on 1/29/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CalculatorViewController.h"

@implementation CalculatorViewController

- (CalculatorBrain *)brain
{
	if (!brain) brain = [[CalculatorBrain alloc] init];
	return brain;
}

- (IBAction)digitPressed:(UIButton *)sender
{
	NSString *digit = [[sender titleLabel] text];
	
	if (userIsInTheMiddleOfTypingANumber)
	{
		[display setText:[[display text] stringByAppendingString:digit]];
	}
	else
	{
		[display setText:digit];
		userIsInTheMiddleOfTypingANumber = YES;
	}

}

- (IBAction)operationPressed:(UIButton *)sender
{
	if (userIsInTheMiddleOfTypingANumber)
	{
		[[self brain] setOperand:[[display text] doubleValue]];
		userIsInTheMiddleOfTypingANumber = NO;
	}
	NSString *operation = [[sender titleLabel] text];
	double result = [[self brain] performOperation:operation];
	[display setText:[NSString stringWithFormat:@"%g", result]];
}

- (IBAction)floatingPointPressed:(UIButton *)sender
{
	NSRange range = [[display text] rangeOfString:@"."];
	
	if (userIsInTheMiddleOfTypingANumber)
	{
		if (range.location == NSNotFound)
		{
			[display setText:[[display text] stringByAppendingString:@"."]];
		}		
	}
	else
	{
		[display setText:@"0."];
		userIsInTheMiddleOfTypingANumber = YES;
	}
}

@end
