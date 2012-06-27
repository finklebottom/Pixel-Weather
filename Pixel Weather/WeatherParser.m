//
//  WeatherParser.m
//  Pixel Weather
//
//  Created by colin gleeson on 12-06-23.
//  Copyright (c) 2012 colin gleeson. All rights reserved.
//

#import "WeatherParser.h"
#import "TouchXML.h"

@implementation WeatherParser

@synthesize elementDictionary,objectAttributes,object,currentTemp, condition, conditionImageURL, location, lowTemp, highTemp;

- (WeatherParser *)initWithQuery:(NSString *)query
{
    if (self = [super init])
    {
        CXMLDocument *parser = [[CXMLDocument alloc] initWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://api.wunderground.com/api/166b5c4e39c974f4/geolookup/conditions/forecast/q/Canada/%@.xml", query]] options:0 error:nil];
        
        currentTemp         = [[[parser nodesForXPath:@"/response/current_observation/temp_c" error:nil] objectAtIndex:0] stringValue];
        
        
        location          = [[[parser nodesForXPath:@"/response/current_observation/display_location/full" error:nil] objectAtIndex:0] stringValue];
        
        //currentTemp       = [[[[[parser nodesForXPath:@"/xml_api_reply/weather/current_conditions/temp_f" error:nil] objectAtIndex:0] attributeForName:@"data"] stringValue] integerValue];
        //lowTemp           = [[[[[parser nodesForXPath:@"/xml_api_reply/weather/forecast_conditions/low" error:nil] objectAtIndex:0] attributeForName:@"data"] stringValue] integerValue];
        //highTemp          = [[[[[parser nodesForXPath:@"/xml_api_reply/weather/forecast_conditions/high" error:nil] objectAtIndex:0] attributeForName:@"data"] stringValue] integerValue];
        
        //conditionImageURL = [NSURL URLWithString:[NSString stringWithFormat:@"http://www.google.com%@", [[[[parser nodesForXPath:@"/xml_api_reply/weather/current_conditions/icon" error:nil] objectAtIndex:0] attributeForName:@"data"] stringValue]]];
    }
    
    return self;
}

- (WeatherParser *)fullParseWithQuery:(NSString *)query
{
    if (self == [super init])
    {

    
        NSMutableArray *ar=[[NSMutableArray alloc] init];
    
        CXMLDocument *parser = [[CXMLDocument alloc] initWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://api.wunderground.com/api/166b5c4e39c974f4/geolookup/conditions/forecast/q/Canada/%@.xml", query]] options:0 error:nil];
        
        NSArray *nodes = nil;
        nodes = [parser nodesForXPath:@"/response/current_observation" error:nil];
        
        NSString *strValue;
        NSString *strName;
        
        for (CXMLElement *node in nodes)
        {
            object = [[NSMutableDictionary alloc] init];
            
            // process to set attributes
            objectAttributes=[[NSMutableDictionary alloc] init];
            NSArray *arAttr = [node attributes];
            NSUInteger i, countAttr = [arAttr count];
            
            for (i = 0; i < countAttr; i++)
            {
                strValue = [[arAttr objectAtIndex:i] stringValue];
                strName = [[arAttr objectAtIndex:i] name];
                
                if (strValue && strName)
                {
                    [objectAttributes setValue:strValue forKey:strName];
                }
            
            }
            
            [object setValue:objectAttributes forKey:[node name]];
            //objectAttributes=nil;
            
            // process to read elements of object ----------------------------------------
            NSUInteger j, countElements = [node childCount];
            CXMLNode *element;
            elementDictionary=nil;
            for (j=0; j<countElements; j++) {
                element=[node childAtIndex:j];
                elementDictionary=[[NSMutableDictionary alloc] init];
                
                // process to read element attributes ----------------------------------
                if([element isMemberOfClass:[CXMLElement class]])
                {
                    CXMLElement *element2=(CXMLElement*)element;
                    arAttr=[element2 attributes];
                    countAttr=[arAttr count];
                    for (i=0; i<countAttr; i++)
                    {
                        strName=[[arAttr objectAtIndex:i] name];
                        strValue=[[arAttr objectAtIndex:i] stringValue];
                        if(strName && strValue){
                            [elementDictionary setValue:strValue forKey:strName];
                        }
                    }
                }
                // --------------------------------------------------------------------
                
                // element value if available
                strValue=[element stringValue];
                if(strValue)
                {
                    [elementDictionary setValue:strValue forKey:@"value"];
                }
                // ---------------------------------------------------------------------
                
                // check if object/dictionary exists for this key "name"
                strName=[element name];
                if([object valueForKey:strName])
                {
                    if([[object valueForKey:strName] isKindOfClass:[NSMutableDictionary class]])
                    {
                        NSMutableDictionary *d=[[NSMutableDictionary alloc] initWithDictionary:[object valueForKey:strName]];
                        NSMutableArray *arOFSameElementName=[[NSMutableArray alloc] initWithObjects:d,elementDictionary,nil];
                        [object setValue:arOFSameElementName forKey:strName];
                        
                        d=nil;
                        arOFSameElementName=nil;
                    } else {
                        NSMutableArray *arOFSameElementName=[object valueForKey:strName];
                        [arOFSameElementName addObject:elementDictionary];
                    }
                } else {
                    [object setValue:elementDictionary forKey:strName];
                }
                //elementDictionary=nil;
                // ---------------------------------------------------------------------
            }
            [ar addObject:object];
            //object=nil;
        
        }
        
        
    
    }
    
    return self;
}


@end