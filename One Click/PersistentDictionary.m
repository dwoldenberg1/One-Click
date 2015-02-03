//
//  PersistentDictionary.m
//  

#import "PersistentDictionary.h"

#define USE_DEFAULT_DICTIONARIES 0
#define USE_JSON_FORMAT          1


#if 0 /* Not sure this is required */


@interface NSJSONSerialization (NSJSONSerialization_MutableBugFix)
+ (id)JSONObjectWithDataFixed:(NSData *)data options:(NSJSONReadingOptions)opt error:(NSError **)error;
+ (id)JSONMutableFixObject:(id)object;
@end

@implementation NSJSONSerialization (NSJSONSerialization_MutableBugFix)

+ (id)JSONObjectWithDataFixed:(NSData *)data options:(NSJSONReadingOptions)opt error:(NSError **)error {
    id object = [NSJSONSerialization JSONObjectWithData:data options:opt error:error];
	
    if (opt & NSJSONReadingMutableContainers) {
        return [self JSONMutableFixObject:object];
    }
	
    return object;
}

+ (id)JSONMutableFixObject:(id)object {
    if ([object isKindOfClass:[NSDictionary class]]) {
        // NSJSONSerialization creates an immutable container if it's empty (boo!!)
        if ([object count] == 0) {
            object = [object mutableCopy];
        }
		
        for (NSString *key in [object allKeys]) {
            [object setObject:[self JSONMutableFixObject:[object objectForKey:key]] forKey:key];
        }
    } else if ([object isKindOfClass:[NSArray class]]) {
        // NSJSONSerialization creates an immutable container if it's empty (boo!!)
        if (![object count] == 0) {
            object = [object mutableCopy];
        }
		
        for (NSUInteger i = 0; i < [object count]; ++i) {
            [object replaceObjectAtIndex:i withObject:[self JSONMutableFixObject:[object objectAtIndex:i]]];
        }
    }
	
    return object;
}

@end

#endif




static __strong NSMutableDictionary *s_dictionaryDictionary = nil;

@implementation PersistentDictionary

+ (PersistentDictionary*) dictionaryWithName:(NSString*)name {
	if (!s_dictionaryDictionary) {
		s_dictionaryDictionary = [[NSMutableDictionary alloc] initWithCapacity:10];		
	}
	
	PersistentDictionary *dic = [s_dictionaryDictionary valueForKey:name];
	if (!dic) {
		dic = [[PersistentDictionary alloc] initWithFileName:name];
		if (dic) [s_dictionaryDictionary setValue:dic forKey:name];
	}
	return dic;
}



+ (void) saveAllDictionaries {
	if (!s_dictionaryDictionary) return;
	NSArray *dictionaries = [s_dictionaryDictionary allValues];
	for (int i = 0; i < [dictionaries count]; i++) {
		PersistentDictionary *dic = [dictionaries objectAtIndex:i];
		[dic saveToFile];
	}
}

+ (void) clearDictionaryMemCache {
	s_dictionaryDictionary = [[NSMutableDictionary alloc] initWithCapacity:10];
}

+ (void) deleteDictionaryNamed:(NSString*)name {
	if (s_dictionaryDictionary) {
		[s_dictionaryDictionary removeObjectForKey:name];
	}
	
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSApplicationSupportDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [NSString stringWithFormat:@"%@/dics", [paths objectAtIndex:0]];
	
	[[NSFileManager defaultManager] removeItemAtPath:[NSString stringWithFormat:@"%@/%@.plist", documentsDirectory, name] error:nil];
	[[NSFileManager defaultManager] removeItemAtPath:[NSString stringWithFormat:@"%@/%@.json",  documentsDirectory, name] error:nil];
	[[NSFileManager defaultManager] removeItemAtPath:[NSString stringWithFormat:@"%@/%@.md5",   documentsDirectory, name] error:nil];
}


+ (void) clearDictionaryDiskCache {
	
	/* Let's create the full path to the dictionary */
	NSFileManager *fileManager = [NSFileManager defaultManager];
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSApplicationSupportDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [NSString stringWithFormat:@"%@/dics", [paths objectAtIndex:0]];

	if ([fileManager fileExistsAtPath:documentsDirectory]) {
		[fileManager removeItemAtPath:documentsDirectory error:nil];
	}
	
}


- (id) initWithFileName:(NSString*)name {
	if (self = [super init]) {
		_fileName = [name copy];
		
		/* Let's create the full path to the dictionary */
		NSFileManager *fileManager = [NSFileManager defaultManager];
		NSArray *paths = NSSearchPathForDirectoriesInDomains(NSApplicationSupportDirectory, NSUserDomainMask, YES);
		NSString *documentsDirectory = [NSString stringWithFormat:@"%@/dics", [paths objectAtIndex:0]];
		[fileManager createDirectoryAtPath:documentsDirectory withIntermediateDirectories:YES attributes:nil error:nil];
		NSString *dicFilePath = [documentsDirectory stringByAppendingPathComponent:name];
		_filePath = [NSString stringWithFormat:@"%@.plist", dicFilePath];
		_md5Path  = [NSString stringWithFormat:@"%@.md5", dicFilePath];
				
		/* If the file exists, let's reconstruct the dictionary from the file */
		{
			/* Retry with JSON version of the file */
			_filePath = [NSString stringWithFormat:@"%@.json", dicFilePath];
			if ([fileManager fileExistsAtPath:_filePath]) {
				NSData *jsonData = [NSData dataWithContentsOfFile:_filePath];
				if (jsonData) {
					NSError *error;
					id val = [NSJSONSerialization JSONObjectWithData:jsonData options:(NSJSONReadingMutableContainers | NSJSONReadingMutableLeaves) error:&error];
					if (error) {
						EXLog(HELPER, ERR, @"JSON deserialization error for stored dictionary [%@]: %@", _fileName, error);
					} else if ([val isKindOfClass:[NSDictionary class]]) {
						_dictionary = val;
					}
				}
					
			}
		}
	
		/* Otherwise we can try defaults */
		#if USE_DEFAULT_DICTIONARIES
		if (!_dictionary) {
			NSString *defaultDicPath = [[NSBundle mainBundle] pathForResource:_fileName ofType:@"plist"];
			if ([fileManager fileExistsAtPath:defaultDicPath]) {
				NSData *propListData = [NSData dataWithContentsOfFile:defaultDicPath];
				if (propListData) {
					NSPropertyListFormat format;
					_dictionary = [NSPropertyListSerialization propertyListFromData:propListData mutabilityOption:kCFPropertyListMutableContainersAndLeaves format:&format errorDescription:nil];
				}
			}
		}
		
		/* Try the JSON version if the plist doesn't exist */
		if (!_dictionary) {
			NSString *defaultDicPath = [[NSBundle mainBundle] pathForResource:_fileName ofType:@"json"];
			if ([fileManager fileExistsAtPath:defaultDicPath]) {
				NSData *jsonData = [NSData dataWithContentsOfFile:defaultDicPath];
				if (jsonData) {
					NSError *error;
					id val = [NSJSONSerialization JSONObjectWithData:jsonData options:(NSJSONReadingMutableContainers | NSJSONReadingMutableLeaves) error:&error];
					if (error) {
						EXLog(HELPER, ERR, @"JSON deserialization error for default dictionary [%@]: %@", _fileName, error);
					} else if ([val isKindOfClass:[NSDictionary class]]) {
						_dictionary = val;
					}
				}
			}
		}
		#endif
		
		/* Now create the dictionary if it's still nil */
		if (!_dictionary) {
			_dictionary = [[NSMutableDictionary alloc] initWithCapacity:10];
		}		
	}
	return self;
}



- (void) saveToFile {
	
	#if USE_JSON_FORMAT 
	
	NSError *error = nil;
	NSData *jsonData = [NSJSONSerialization dataWithJSONObject:_dictionary options:NSJSONWritingPrettyPrinted error:&error];
	if (error) {
		NSLog(@"Error: %@", error);
	} else {
		[jsonData writeToFile:_filePath atomically:YES];
	}
	
	#else
	
	NSString *errorStr;
	NSData *propListData = [NSPropertyListSerialization dataFromPropertyList:_dictionary format:NSPropertyListBinaryFormat_v1_0 errorDescription:&errorStr];
	if (errorStr) {
		NSLog(@"Error string: %@", errorStr);
	} else {
		[propListData writeToFile:_filePath atomically:YES];
		
		NSString *dataString = [[NSString alloc] initWithData:propListData encoding:NSUTF8StringEncoding];
		NSString *coffee = [PersistentDictionary caffinate:dataString];
		[coffee writeToFile:_md5Path atomically:YES encoding:NSUTF8StringEncoding error:nil];
	}
	
	#endif
}



@end

