
#import "NSObject+SBJSON.h"
#import "SBJsonWriter.h"

static const SBJsonWriter *jsonWriter;

@implementation NSObject (NSObject_SBJSON)

- (NSString *)JSONFragment {
	if (!jsonWriter)
		jsonWriter = [SBJsonWriter new];
	
    NSString *json = [jsonWriter stringWithFragment:self];
    if (json)
        return json;

    NSLog(@"-JSONFragment failed. Error trace is: %@", [jsonWriter errorTrace]);
    return nil;
}

- (NSString *)JSONRepresentation {
	if (!jsonWriter)
		jsonWriter = [SBJsonWriter new];
    
    NSString *json = [jsonWriter stringWithObject:self];
    if (json)
        return json;
    
    NSLog(@"-JSONRepresentation failed. Error trace is: %@", [jsonWriter errorTrace]);
    return nil;
}

@end
