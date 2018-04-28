//
//  TermModel.h
//  Smart Classroom Manager
//
//  Created by Muthukumar on 22/04/18.
//  Copyright © 2018 PICNFRAMES TECHNOLOGIES. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TermModel : NSObject

@property (nonatomic, strong) NSString *title;
@property (assign) NSInteger term_id;


- (id) initWithID:(int)termid andTitle:(NSString *)title;

@end
