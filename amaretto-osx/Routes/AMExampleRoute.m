/*
 AMExampleRoute.h
 amaretto-osx
 
 Copyright (c) 2014 EgoAleSum
 All rights reserved.
 
 Redistribution and use in source and binary forms, with or without
 modification, are permitted provided that the following conditions are met:
 
 1. Redistributions of source code must retain the above copyright notice, this
 list of conditions and the following disclaimer.
 2. Redistributions in binary form must reproduce the above copyright notice,
 this list of conditions and the following disclaimer in the documentation
 and/or other materials provided with the distribution.
 
 THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
 ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
 WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
 DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR
 ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
 (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
 LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
 ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

#import "AMExampleRoute.h"


@implementation AMExampleRoute

- (id<NSObject>)executeMethod:(NSString*)method withArgs:(NSDictionary*)args
{
	if([method isEqualToString:@"example"] || [method isEqualToString:@"example.string"])
	{
		return [[NSString alloc]
				initWithData:[NSJSONSerialization dataWithJSONObject:args options:0 error:NULL]
				encoding:NSUTF8StringEncoding];
	}
	else if([method isEqualToString:@"example.object"])
	{
		return args;
	}
	else if([method isEqualToString:@"example.error"])
	{
		@throw [NSException exceptionWithName:@"RandomError" reason:@"Just random errors here and there" userInfo:nil];
	}
	else if([method isEqualToString:@"example.delayed"])
	{
		double delayInSeconds = 8.0;
		dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
		dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
			AMCommon *common = [AMCommon sharedInstance];
			[common.UIController sendMessage:[NSDictionary dictionaryWithObject:@"delayed" forKey:@"message"]];
		});
	}
	
	return nil;
}

@end
