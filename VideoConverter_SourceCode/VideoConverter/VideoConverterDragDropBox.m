/////////////////////////////////////////////
//  Project: Mac VideoConverter
//  Author: Gagan Malik
//  URN: 000687563
//  
//
//  File Name: VideoConverterDragDropBox.m
//  File Description: This class has been inherited from NSBox to handle drag and drop in the box area.
//  Date: Saturday 21 April, 2012
//  
/////////////////////////////////////////////// 


#import "VideoConverterDragDropBox.h"

@implementation VideoConverterDragDropBox

- (id)init
{
    self = [super init];
    if (self) 
    {
        // Initialization code here.
    }
    
    return self;
}

- (void)awakeFromNib
{
    //Registering pastreboard type the NSBox will accept
    [self registerForDraggedTypes:[NSArray arrayWithObject:NSFilenamesPboardType]];    
}

- (NSDragOperation)draggingEntered:(id <NSDraggingInfo>)sender
{
    return NSDragOperationGeneric;
}

//Called when a file is dragged and dropped to box
- (BOOL)performDragOperation:(id < NSDraggingInfo >)sender 
{	
	NSArray *draggedFilenames = [[sender draggingPasteboard] propertyListForType:NSFilenamesPboardType];
    NSString* draggedFilePath = [[draggedFilenames objectAtIndex:0] pathExtension];
    
    if([draggedFilePath isEqualToString:@"mp4"]||[draggedFilePath isEqualToString:@"avi"])
    {
        //if mp4 or avi file dragged calling method in VideoConverterController and setting values
        [conversionController performDragOperation:[draggedFilenames objectAtIndex:0]];
        return YES;    
    }
    else
    {
        NSAlert* alert = [[NSAlert alloc]init];
        [alert setInformativeText:@"Please drag an avi or mp4 file for conversion."];
        [alert runModal];
        [alert release];
        return NO;
    }	
}

@end
