/////////////////////////////////////////////
//  Project: Mac VideoConverter
//  Author: Gagan Malik
//  URN:000687563
//  
//
//  File Name: VideoConverterAppDelegate.h
//  Date: Saturday 21 April, 2012
//  
///////////////////////////////////////////////

#import <Cocoa/Cocoa.h>

@interface VideoConverterAppDelegate : NSObject <NSApplicationDelegate> 
{
    NSWindow*           window;
    IBOutlet NSView*    mianWindowView;
}

@property (assign) IBOutlet NSWindow *window;

@end
