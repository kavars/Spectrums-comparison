//
//  XMLElement.h
//  Spectrums comparison
//
//  Created by Kirill Varshamov on 04.02.2020.
//  Copyright © 2020 Kirill Varshamov. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CXFElement : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *text;
@property (nonatomic, strong) NSDictionary *attributes;
@property (nonatomic, strong) NSMutableArray *subElements;
@property (nonatomic, weak)   CXFElement *parent;

@end

NS_ASSUME_NONNULL_END
