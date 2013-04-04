
/////////////////////////////////////////////
//  Project: Mac VideoConverter
//  Author: Gagan Malik
//  URN: 000687563
//  
//
//  File Name: VideoConverterController.h
//  Date: Saturday 21 April, 2012
//  
/////////////////////////////////////////////// 


#import <Foundation/Foundation.h>
#import <QTKit/QTKit.h>

@interface VideoConverterController : NSObject
{
    bool flag;
    
    NSString*                       selectedFilePath;
    NSString*                       convertedFilePAth;
    
    IBOutlet NSView*                mianWindowView;
    IBOutlet NSView*                conversionWindowView;
    
    IBOutlet NSWindow*              window;
    
    IBOutlet NSProgressIndicator*   progInd;
    IBOutlet NSTextField*           percentLabel;
    
    IBOutlet NSPopUpButton*         conversionFormat;
    IBOutlet NSTextField*           converterWindowName;
    IBOutlet NSTextField*           selectedFileName;
    
    IBOutlet NSTextField*           textInDragArea;
    IBOutlet NSButton*              buttonInDragArea;
    IBOutlet NSBox*                 boxAsLinInDragArea;
    
    IBOutlet NSButton*              convertButton;
    IBOutlet NSButton*              showFileButton;
    IBOutlet NSButton*              abortButton;
    
}
- (IBAction)doOpen:(id)sender;
- (IBAction)doConvert:(id)sender;
- (IBAction)revealConvertedFile:(id)sender;
- (void)performDragOperation:(NSString*)draggedFilePath;
- (BOOL)movie:(QTMovie *)movie shouldContinueOperation:(NSString *)op withPhase:(QTMovieOperationPhase)phase atPercent:(NSNumber *)percent withAttributes:(NSDictionary *)attributes;


@end
