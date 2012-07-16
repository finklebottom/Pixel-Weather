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

@synthesize elementDictionary,objectAttributes,object,currentTemp, condition, conditionImageURL, location, lowTemp, highTemp, weekday,datee, qpf, snow, high, low, cond, wind, hourlyCondition, hourlyRain, hourlyTemp, hourlyTime, hourlySnow;

- (WeatherParser *)initWithQuery:(NSString *)query
{
    if (self = [super init])
    {

        
        //CXMLDocument *parser = [[CXMLDocument alloc] initWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://api.wunderground.com/api/166b5c4e39c974f4/geolookup/conditions/forecast/hourly/q/%@.xml", query]] options:0 error:nil];
        
        //currentTemp         = [[[parser nodesForXPath:@"/response/current_observation/temp_c" error:nil] objectAtIndex:0] stringValue];
        
        
        //location          = [[[parser nodesForXPath:@"/response/current_observation/display_location/full" error:nil] objectAtIndex:0] stringValue];
        
        //currentTemp       = [[[[[parser nodesForXPath:@"/xml_api_reply/weather/current_conditions/temp_f" error:nil] objectAtIndex:0] attributeForName:@"data"] stringValue] integerValue];
        //lowTemp           = [[[[[parser nodesForXPath:@"/xml_api_reply/weather/forecast_conditions/low" error:nil] objectAtIndex:0] attributeForName:@"data"] stringValue] integerValue];
        //highTemp          = [[[[[parser nodesForXPath:@"/xml_api_reply/weather/forecast_conditions/high" error:nil] objectAtIndex:0] attributeForName:@"data"] stringValue] integerValue];
        
        //conditionImageURL = [NSURL URLWithString:[NSString stringWithFormat:@"http://www.google.com%@", [[[[parser nodesForXPath:@"/xml_api_reply/weather/current_conditions/icon" error:nil] objectAtIndex:0] attributeForName:@"data"] stringValue]]];
    }
    
    return self;
}

- (void)parseWithQuery:(NSString *)query
{
    
        CXMLDocument *parser = [[CXMLDocument alloc] initWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://api.wunderground.com/api/9e43e9d86f5fb05c/geolookup/conditions/forecast/q/%@.xml", query]] options:0 error:nil];
        
        NSArray *nodes = [parser nodesForXPath:@"/response/forecast/simpleforecast/forecastdays/forecastday/date" error:nil];
        
        for (CXMLElement *node in nodes)
        {
            NSString *dateCombo;
            
            NSArray *weekdayy = [node elementsForName:@"weekday"];
            for (CXMLElement *idd in weekdayy)
            {
                [self.weekday  addObject:idd.stringValue];
                break;
            }
            
            
            NSArray *month = [node elementsForName:@"month"];
            for (CXMLElement *idd in month)
            {
                dateCombo = idd.stringValue;
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
            
            //NSLog(dateCombo);
            [self.datee  addObject:dateCombo];
            
            
        }
    
        NSArray *node2 = [parser nodesForXPath:@"/response/forecast/simpleforecast/forecastdays/forecastday" error:nil];
    
        for (CXMLElement *node in node2)
        {

            NSArray *hi = [node elementsForName:@"high"];
            for (CXMLElement *idd in hi)
            {
                NSArray *hiC = [idd elementsForName:@"celsius"];
                for (CXMLElement *iddd in hiC)
                {
                    [self.high  addObject:iddd.stringValue];
                    //NSLog(@"High C >> %@",iddd.stringValue);
                    break;
                }
            }
            
            NSArray *loww = [node elementsForName:@"low"];
            for (CXMLElement *idd in loww)
            {
                NSArray *lowC = [idd elementsForName:@"celsius"];
                for (CXMLElement *iddd in lowC)
                {
                    [self.low  addObject:iddd.stringValue];
                    //NSLog(@"High C >> %@",iddd.stringValue);
                    break;
                }
            }
            
            NSArray *rain = [node elementsForName:@"qpf_allday"];
            for (CXMLElement *idd in rain)
            {
                NSArray *hiC = [idd elementsForName:@"mm"];
                for (CXMLElement *iddd in hiC)
                {
                    [self.qpf  addObject:iddd.stringValue];
                    //NSLog(@"rain >> %@",iddd.stringValue);
                    break;
                }
            }
            
            NSArray *snoww = [node elementsForName:@"snow_allday"];
            for (CXMLElement *idd in snoww)
            {
                NSArray *lowC = [idd elementsForName:@"cm"];
                for (CXMLElement *iddd in lowC)
                {
                    [self.snow  addObject:iddd.stringValue];
                    //NSLog(@"snow >> %@",iddd.stringValue);
                    break;
                }
            }

            
            NSArray *condd = [node elementsForName:@"conditions"];
            for (CXMLElement *idd in condd)
            {
                [self.cond  addObject:idd.stringValue];
                break;
            }
        
        }

        
    

}

- (WeatherParser *)fullParseWithQuery:(NSString *)query path:(NSString *)nodePath
{
    if (self == [super init])
    {
        weekday =[[NSMutableArray alloc] init];
        datee =[[NSMutableArray alloc] init];
        qpf =[[NSMutableArray alloc] init];
        snow =[[NSMutableArray alloc] init];
        high =[[NSMutableArray alloc] init];
        low =[[NSMutableArray alloc] init];
        cond =[[NSMutableArray alloc] init];
        wind =[[NSMutableArray alloc] init];
        
        hourlyRain =[[NSMutableArray alloc] init];
        hourlyTime =[[NSMutableArray alloc] init];
        hourlyTemp =[[NSMutableArray alloc] init];
        hourlyCondition =[[NSMutableArray alloc] init];
        

    
        NSMutableArray *ar=[[NSMutableArray alloc] init];
    
        CXMLDocument *parser = [[CXMLDocument alloc] initWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://api.wunderground.com/api/9e43e9d86f5fb05c/geolookup/conditions/forecast/hourly/q/%@.xml", query]] options:0 error:nil];
        
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
        
        
        NSArray *node2 = [parser nodesForXPath:@"/response/hourly_forecast/forecast" error:nil];
        
        for (CXMLElement *node in node2)
        {
            
            NSArray *timee = [node elementsForName:@"FCTTIME"];
            for (CXMLElement *idd in timee)
            {
                NSArray *hourr = [idd elementsForName:@"civil"];
                for (CXMLElement *iddd in hourr)
                {
                    [self.hourlyTime  addObject:iddd.stringValue];
                    break;
                }
            }
            
            NSArray *tempp = [node elementsForName:@"temp"];
            for (CXMLElement *idd in tempp)
            {
                NSArray *metricc = [idd elementsForName:@"metric"];
                for (CXMLElement *iddd in metricc)
                {
                    [self.hourlyTemp  addObject:iddd.stringValue];
                    break;
                }
            }
            
            NSArray *conditionn = [node elementsForName:@"condition"];
            for (CXMLElement *idd in conditionn)
            {
                [self.hourlyCondition  addObject:idd.stringValue];
                break;
                
            }
            
            NSString *wett = @"";
            
            NSArray *rainn = [node elementsForName:@"qpf"];
            for (CXMLElement *idd in rainn)
            {
                NSArray *metricc = [idd elementsForName:@"metric"];
                for (CXMLElement *iddd in metricc)
                {
                    wett = (iddd.stringValue != nil ? iddd.stringValue : @"0");
                    break;
                }
            }
            
            wett = [wett stringByAppendingString:@"mm"];
            [self.hourlyRain  addObject:wett];
            
            NSArray *snoww = [node elementsForName:@"snow"];
            for (CXMLElement *idd in snoww)
            {
                NSArray *metricc = [idd elementsForName:@"metric"];
                for (CXMLElement *iddd in metricc)
                {
                    wett = (iddd.stringValue != nil ? iddd.stringValue : @"0");
                    break;
                }
            }
            
            wett = [wett stringByAppendingString:@"cm"];
            [self.hourlySnow  addObject:wett];
            
            
            
        }
        
    
    }
    
    [self parseWithQuery:query];
    
    return self;
}


@end
