//
//  CXFPalette.h
//  Spectrums comparison
//
//  Created by Kirill Varshamov on 04.02.2020.
//  Copyright © 2020 Kirill Varshamov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CXFElement.h"

NS_ASSUME_NONNULL_BEGIN

@interface CXFPalette : NSObject <NSXMLParserDelegate>

@property (nonatomic, strong) NSXMLParser *xmlParser;

@property (nonatomic, strong) CXFElement *rootElement;
@property (nonatomic, strong) CXFElement *currentElementPointer;

-(NSArray *) openCXF: (NSString *) cxfFileName;

@end

NS_ASSUME_NONNULL_END
