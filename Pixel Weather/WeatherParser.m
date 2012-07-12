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

@synthesize elementDictionary,objectAttributes,object,currentTemp, condition, conditionImageURL, location, lowTemp, highTemp, datee, qpf, snow, high, low, cond, wind;

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

- (void)parseWithQuery:(NSString *)query
{
    
        CXMLDocument *parser = [[CXMLDocument alloc] initWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://api.wunderground.com/api/166b5c4e39c974f4/geolookup/conditions/forecast/q/Canada/%@.xml", query]] options:0 error:nil];
        
        NSArray *nodes = [parser nodesForXPath:@"/response/forecast/simpleforecast/forecastdays/forecastday/date" error:nil];
        
        for (CXMLElement *node in nodes)
        {
            NSString *dateCombo;
            
            NSArray *weekday = [node elementsForName:@"weekday"];
            for (CXMLElement *idd in weekday)
            {
                dateCombo = idd.stringValue;
                break;
            }
            
            dateCombo = [dateCombo stringByAppendingString:@" ("];
            
            NSArray *month = [node elementsForName:@"month"];
            for (CXMLElement *idd in month)
            {
                dateCombo = [dateCombo stringByAppendingString:idd.stringValue];
                break;
            }
            
            dateCombo = [dateCombo stringByAppendingString:@"/"];
            
            NSArray *day = [node elementsForName:@"day"];
            for (CXMLElement *idd in day)
            {
                dateCombo = [dateCombo stringByAppendingString:idd.stringValue];
                break;
            }
            
            dateCombo = [dateCombo stringByAppendingString:@"/"];
            
            NSArray *year = [node elementsForName:@"year"];
            for (CXMLElement *idd in year)
            {
                dateCombo = [dateCombo stringByAppendingString:idd.stringValue];
                break;
            }
            
            dateCombo = [dateCombo stringByAppendingString:@")"];
            
            //NSLog(dateCombo);
            [self.datee  addObject:dateCombo];
            
            
        }
        
    

}

- (WeatherParser *)fullParseWithQuery:(NSString *)query path:(NSString *)nodePath
{
    if (self == [super init])
    {
        
        datee =[[NSMutableArray alloc] init];
        qpf =[[NSMutableArray alloc] init];
        snow =[[NSMutableArray alloc] init];
        high =[[NSMutableArray alloc] init];
        low =[[NSMutableArray alloc] init];
        cond =[[NSMutableArray alloc] init];
        wind =[[NSMutableArray alloc] init];

    
        NSMutableArray *ar=[[NSMutableArray alloc] init];
    
        CXMLDocument *parser = [[CXMLDocument alloc] initWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://api.wunderground.com/api/166b5c4e39c974f4/geolookup/conditions/forecast/q/Canada/%@.xml", query]] options:0 error:nil];
        
        NSArray *nodes = nil;
        nodes = [parser nodesForXPath:nodePath error:nil];
        
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
    
    [self parseWithQuery:query];
    
    return self;
}


@end
