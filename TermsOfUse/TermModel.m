//
//  TermModel.m
//  Smart Classroom Manager
//
//  Created by Muthukumar on 22/04/18.
//  Copyright © 2018 PICNFRAMES TECHNOLOGIES. All rights reserved.
//

#import "TermModel.h"

@implementation TermModel


- (id) initWithID:(int)termid andTitle:(NSString *)title {
    
    self = [super init];
    if (self) {
        self.term_id = termid;
        self.title = title;
    }
    return self;
}
@end
