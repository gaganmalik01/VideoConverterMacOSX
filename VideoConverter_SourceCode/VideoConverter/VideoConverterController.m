/////////////////////////////////////////////
//  Project: Mac VideoConverter
//  Author: Gagan Malik
//  URN: 000687563
//  
//
//  File Name: VideoConverterController.m
//  Date: Saturday 21 April, 2012
//  
/////////////////////////////////////////////

#import "VideoConverterController.h"

@implementation VideoConverterController

- (id)init
{
    self = [super init];
    
    if (self) 
    {
        // Initialization code here.
    }
    
    return self;
}
-(void)awakeFromNib
{
    flag = YES;
    selectedFilePath = nil;
    convertedFilePAth = nil;
    [converterWindowName setAlignment:NSCenterTextAlignment];
    [selectedFileName setAlignment:NSCenterTextAlignment];
    [showFileButton setHidden:YES];
}


- (IBAction)doOpen:(id)sender
{
	NSOpenPanel* openPanel = [NSOpenPanel openPanel];
	NSArray* fileTypes = [NSArray arrayWithObjects:@"mp4", @"avi", nil];
    [openPanel setAllowedFileTypes:fileTypes];	
    
    //Opens a dialog to choose file
	if([openPanel runModal] == NSFileHandlingPanelOKButton)
	{
        [showFileButton setHidden:YES];
        [converterWindowName setStringValue:@"Ready to Convert!"];
        
        //Setting file path 
        if(selectedFilePath)
        {
            [selectedFilePath autorelease];            
        } 
        
        selectedFilePath = [[[openPanel URLs] objectAtIndex:0] path];
        [selectedFilePath retain];
        
        //Setting file name and its alignment
        [selectedFileName setAlignment:NSCenterTextAlignment];
        [selectedFileName setStringValue:[selectedFilePath lastPathComponent]];
        
        //Setting control's text and position in drag area
        [textInDragArea setStringValue:@"To select a different file drag here OR"];
        [textInDragArea setFrame:NSMakeRect(5, 30, 280, 17)];        
        [buttonInDragArea setFrame:NSMakeRect(280, 20, 100, 32)];
        [boxAsLinInDragArea setFrame:NSMakeRect(285, 13, 78, 5)];
                
        [convertButton setEnabled:YES];
        [window display];
	}
}


-(void)performDragOperation:(NSString*)draggedFilePath
{
    //Setting file path
    if(selectedFilePath)
    {
        [selectedFilePath autorelease];            
    }
    
    selectedFilePath = draggedFilePath;
    [selectedFilePath retain];
    
    //Setting text and position of view controls
    [converterWindowName setStringValue:@"Ready to Convert!"];
    [showFileButton setHidden:YES];

    [selectedFileName setAlignment:NSCenterTextAlignment];
    [selectedFileName setStringValue:[selectedFilePath lastPathComponent]];
    
    [textInDragArea setStringValue:@"To select a different video drag it here or"];
    [textInDragArea setFrame:NSMakeRect(4, 17, 262, 17)];   
    
    [buttonInDragArea setFrame:NSMakeRect(265,10, 90, 32)];
    [boxAsLinInDragArea setFrame:NSMakeRect(268, 13, 78, 5)];
    
    [convertButton setEnabled:YES];
    
    [window display];

}

- (IBAction)doConvert:(id)sender
{      
    //Handling format selection in drop down list
    if ([[conversionFormat titleOfSelectedItem] isEqualToString:@"Pick a video format"])
    {
        NSAlert *alert = [[NSAlert alloc] init];
        [alert setInformativeText:@"Please select a format for conversion."];
        [alert runModal];
        [alert release];
        return;
    }
    
    if (![[[conversionFormat titleOfSelectedItem] lowercaseString] isEqualToString:@"mp4"] && ![[[conversionFormat titleOfSelectedItem] lowercaseString]isEqualToString:@"avi"] )
    {
        NSAlert *alert = [[NSAlert alloc] init];
        [alert setInformativeText:@"This format is not supported. Please select other format."];
        [alert runModal];
        [alert release];
        return;
    }
    
    if ([[[conversionFormat titleOfSelectedItem] lowercaseString] isEqualToString:[[selectedFilePath pathExtension] lowercaseString]])
    {
         NSAlert *alert = [[NSAlert alloc] init];
         [alert setInformativeText:[NSString stringWithFormat:@"The file is already in %@ format.",
                                    [conversionFormat titleOfSelectedItem]]];
         [alert runModal];
         [alert release];
         return;         
    }
    
    
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    
    [percentLabel setStringValue:@"0 % done"];
    [window setContentView:conversionWindowView];
    [window display];
   
	
	QTMovie *movie = [QTMovie movieWithFile:selectedFilePath error:nil];
    
    //setting movie delegae
	[movie setDelegate:self];
    NSDictionary *dictionary  = nil;
    
    //Setting avi file format for conversion
    if ([[[conversionFormat titleOfSelectedItem] lowercaseString] isEqualToString:@"avi"])
    {
        dictionary = [NSDictionary dictionaryWithObjectsAndKeys:
                      [NSNumber numberWithBool:YES], QTMovieExport,
                      [NSNumber numberWithLong:kQTFileTypeAVI], QTMovieExportType,
                      self, QTMovieDelegateAttribute,
                      nil];
    }
    
    //Setting mp4 file format for conversion
    else if ([[[conversionFormat titleOfSelectedItem] lowercaseString] isEqualToString:@"mp4"])
    {
        dictionary = [NSDictionary dictionaryWithObjectsAndKeys:
                      [NSNumber numberWithBool:YES], QTMovieExport,
                      [NSNumber numberWithLong:kQTFileTypeMP4], QTMovieExportType,
                      self, QTMovieDelegateAttribute,
                      nil];
    }
	
	NSString* fileSavePath = nil;
    NSString* filename = [[selectedFilePath lastPathComponent] stringByDeletingPathExtension];
    NSString* fileSaveDir = [selectedFilePath stringByDeletingLastPathComponent];
  

	fileSavePath = [NSString stringWithFormat:@"%@%@%@%@%@", fileSaveDir, @"/", filename, @".",
                    [[conversionFormat titleOfSelectedItem] lowercaseString]];

    //writing converted file
	[movie writeToFile:fileSavePath withAttributes:dictionary];
    
    if (!flag)
    {
        flag = YES;
        
        [window setContentView:mianWindowView];
        [window display];
                
        return;
    }
    
    if (convertedFilePAth)
    {
        [convertedFilePAth release];
    }
    
    convertedFilePAth = fileSavePath;
    [convertedFilePAth retain];    
    
    [selectedFileName setStringValue:@""];
    [textInDragArea setStringValue:@"To Convert drag a video file here or"];
    [converterWindowName setStringValue:[NSString stringWithFormat:@"%@%@",@"Finished converting ",
                                         [selectedFilePath lastPathComponent]]];
    [textInDragArea setFrame:NSMakeRect(18, 68, 229, 17)];        
    [buttonInDragArea setFrame:NSMakeRect(244,61,92, 32)];
    [boxAsLinInDragArea setFrame:NSMakeRect(249, 64, 78, 5)];
    
    [convertButton setEnabled:NO];
    [conversionFormat selectItemAtIndex:0];
    [showFileButton setHidden:NO];
    
    [window setContentView:mianWindowView];
    [window display];
    
	[pool release];	
    
    return;
}

//QTMovie delegate method
- (BOOL)movie:(QTMovie *)movie shouldContinueOperation:(NSString *)op withPhase:(QTMovieOperationPhase)phase 
        atPercent:(NSNumber *)percent withAttributes:(NSDictionary *)attributes
{
     NSEvent* event = [NSApp nextEventMatchingMask:NSAnyEventMask untilDate:nil inMode:NSDefaultRunLoopMode dequeue:YES];
    
    //Handling click on Cancel button
    if (event && NSPointInRect([event locationInWindow],[abortButton frame])) 
    {   
        flag = NO;
        return NO;
    }
    
    //Handling progress indicator
    [progInd setDoubleValue:[percent doubleValue] * 100];
    [progInd displayIfNeeded];
    
    //Showing percentage
    NSString* percentLabelString = [NSString stringWithFormat:@"%d%@", (int)[progInd doubleValue],@" % done"];
    [percentLabel setStringValue:percentLabelString];
    [percentLabel display];

    return YES;
}

- (IBAction)revealConvertedFile:(id)sender
{
   if ([[NSWorkspace sharedWorkspace] selectFile:convertedFilePAth 
                                      inFileViewerRootedAtPath:@""] == NO)
   {
       NSAlert* alert = [[NSAlert alloc] init];
       [alert setInformativeText:@"File deleted or moved to some other location."];
       [alert runModal];
       [alert release];
   }
   
}
@end
