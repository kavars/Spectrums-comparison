//
//  XMLElement.m
//  Spectrums comparison
//
//  Created by Kirill Varshamov on 04.02.2020.
//  Copyright © 2020 Kirill Varshamov. All rights reserved.
//

#import "CXFElement.h"

@implementation CXFElement

-(NSMutableArray *) subElements {
    if (_subElements == nil) {
        _subElements = [[NSMutableArray alloc] init];
    }
    return _subElements;
}

@end
