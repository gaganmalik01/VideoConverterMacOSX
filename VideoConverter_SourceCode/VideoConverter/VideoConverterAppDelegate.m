/////////////////////////////////////////////
//  Project: Mac VideoConverter
//  Author: Gagan Malik
//  URN: 000687563
//  
//
//  File Name: VideoConverterAppDelegate.m
//  Date: Saturday 21 April, 2012
//  
///////////////////////////////////////////////

#import "VideoConverterAppDelegate.h"

@implementation VideoConverterAppDelegate

@synthesize window;

-(void)awakeFromNib
{
    [window setContentView:mianWindowView]; 
}

-(BOOL)applicationShouldTerminateAfterLastWindowClosed:(NSApplication *)sender
{
    return YES;
}
@end
