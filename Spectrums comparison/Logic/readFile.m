//
//  readFile.m
//  Spector CLI
//
//  Created by Kirill Varshamov on 27.01.2020.
//  Copyright © 2020 Kirill Varshamov. All rights reserved.
//

#import "readFile.h"

double readLineAsDouble(FILE *file)
{
    char buffer[4096];

    NSMutableString *tmpStr = [NSMutableString stringWithCapacity:256];

    // Read up to 4095 non-newline characters, then read and discard the newline
    int charsRead;
    do
    {
        if(fscanf(file, "%4095[^\n]%n%*c", buffer, &charsRead) == 1)
            [tmpStr appendFormat:@"%s", buffer];
        else
            break;
    } while(charsRead == 4095);

    double result = [tmpStr doubleValue];
    
    return result;
}

NSArray *readFileToArray(const char *fileName)
{
    NSMutableArray *objectSpector = [NSMutableArray array];

    FILE *file = fopen(fileName, "r");
    
    // check for NULL
    while(!feof(file))
    {
        NSNumber *line = [NSNumber numberWithDouble: readLineAsDouble(file)];
        
        [objectSpector addObject: line];
    }
    fclose(file);
    
    [objectSpector removeLastObject];
    
    return [NSArray arrayWithArray: objectSpector];
}
