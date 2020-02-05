//
//  CXFPalette.m
//  Spectrums comparison
//
//  Created by Kirill Varshamov on 04.02.2020.
//  Copyright © 2020 Kirill Varshamov. All rights reserved.
//

#import "CXFPalette.h"

@implementation CXFPalette

@synthesize rootElement, currentElementPointer;
@synthesize xmlParser;

-(NSArray *) openCXF:(NSString *) cxfFileName
{
    NSMutableDictionary *spectrumsObjects = [NSMutableDictionary dictionary];
    NSMutableDictionary *spectrumsLight = [NSMutableDictionary dictionary];
    
    NSUInteger typeLable = 0;
    
    NSString *objectLable;
    NSMutableArray *objectValues;
        
    NSData *xml = [[NSData alloc] initWithContentsOfFile: cxfFileName];
        
    self.xmlParser = [[NSXMLParser alloc] initWithData: xml];
    self.xmlParser.delegate = self;
    
    if ([self.xmlParser parse]) {
                
        // level 0
        for (CXFElement *level0 in rootElement.subElements) {
            
            // level 1
            for (CXFElement *level1 in level0.subElements) {
                
                // level 2
                for (CXFElement *level2 in level1.subElements) {
                    
                    objectValues = [NSMutableArray array];

                    // get lable
                    if ([level2.name isEqual: @"Name"]) {
                        objectLable = level2.text;
                    }
                    
                    // level 3
                    for (CXFElement *level3 in level2.subElements) {
                        if ([level3.name isEqual: @"Spectrum"]) {
                            if ([level3.attributes[@"Conditions"]  isEqual: @"2"]) {
                                typeLable = 2;
                            } else if ([level3.attributes[@"Conditions"]  isEqual: @"4"]) {
                                typeLable = 4;
                            }
                        }
                        
                        // level 4
                        for (CXFElement *level4 in level3.subElements) {
                            // get value
                            if ([level4.name isEqual: @"Value"]) {
                                [objectValues addObject: [NSNumber numberWithDouble: [level4.text doubleValue]]];
                            }
                            
                        } // 4
                        
                    } // 3

                } //2
                // add to dictionary
                if ([level1.name isEqual: @"Sample"]) {
                    if (typeLable == 2) {
                        [spectrumsObjects setObject: objectValues forKey: objectLable];
                    } else if (typeLable == 4) {
                        [spectrumsLight setObject: objectValues forKey: objectLable];
                    }
                }

            } // 1
            
        } // 0

    } else {
        NSLog(@"Failed to parse the XML");
    }
        
    return [NSArray arrayWithObjects: spectrumsObjects, spectrumsLight, nil];
}



-(void) parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary<NSString *,NSString *> *)attributeDict
{
    if (self.rootElement == nil) {
        self.rootElement = [[CXFElement alloc] init];
        self.currentElementPointer = self.rootElement;
    } else {
        CXFElement *newElement = [[CXFElement alloc] init];
        newElement.parent = self.currentElementPointer;
        
        [currentElementPointer.subElements addObject: newElement];
        self.currentElementPointer = newElement;
    }
    
    self.currentElementPointer.name = elementName;
    self.currentElementPointer.attributes = attributeDict;
}

-(void) parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    if ([self.currentElementPointer.text length] > 0) {
        self.currentElementPointer.text = [self.currentElementPointer.text stringByAppendingString: string];
    } else {
        self.currentElementPointer.text = string;
    }
}

-(void) parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    self.currentElementPointer = self.currentElementPointer.parent;
}

@end
