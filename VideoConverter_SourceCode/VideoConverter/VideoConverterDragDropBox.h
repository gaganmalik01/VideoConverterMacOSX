/////////////////////////////////////////////
//  Project: Mac VideoConverter
//  Author: Gagan Malik
//  URN:000687563
//  
//
//  File Name: VideoConverterDragDropBox.h
//  Date: Saturday 21 April, 2012
//  
/////////////////////////////////////////////// 


#import <AppKit/AppKit.h>
#import "VideoConverterController.h"

@interface VideoConverterDragDropBox : NSBox
{
    IBOutlet VideoConverterController*  conversionController;
}

@end
