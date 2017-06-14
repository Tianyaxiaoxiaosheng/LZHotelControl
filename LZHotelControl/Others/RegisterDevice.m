//
//  RegisterDevice.m
//  LZHotelControl
//
//  Created by Jony on 17/5/18.
//  Copyright © 2017年 yavatop. All rights reserved.
//

#import "RegisterDevice.h"

@interface RegisterDevice ()<NSXMLParserDelegate>
//解析出的数据内部是字典类型
@property(strong, nonatomic) NSMutableArray *listData;
//当前标签的名字
@property(strong, nonatomic) NSString *currentTagName;


@end

@implementation RegisterDevice

+ (NSDictionary *)registerDeviceWithLocalInfo:(NSDictionary *)localInfoDic{
    NSMutableDictionary *mutDic = [[NSMutableDictionary alloc] init];
    
    NSString *strURL = @"";
    //把字符串转换为URL字符串
    [strURL stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    NSURL *url = [NSURL URLWithString:strURL];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *  data, NSURLResponse *  response, NSError *  error) {
        if (!error) {
//                NSString *aString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                //解析
                [[[self alloc] init] start:data];
        }else{
            NSLog(@"error: %@", error.localizedDescription);
        }
    }];
    [task resume];

    
    return [NSDictionary dictionaryWithDictionary:mutDic];
}

- (void)start:(NSData *)data{
    NSXMLParser *parser = [[NSXMLParser alloc] initWithData:data];
    parser.delegate = self;
    [parser parse];
}
//文档开始的时候触发
- (void)parserDidStartDocument:(NSXMLParser *)parser {
    self.listData = [[NSMutableArray alloc] init];
}

//文档出错的时候触发
- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError {
    NSLog(@"%@", parseError);
}

//遇到一个开始标签时候触发
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qualifiedName attributes:(NSDictionary *)attributeDict {
    
    self.currentTagName = elementName;
    if ([self.currentTagName isEqualToString:@"Table1"]) {
        [self.listData addObject:attributeDict];
    }
    
}

//遇到字符串时候触发
- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    //替换回车符和空格
    string = [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if ([string isEqualToString:@""]) {
        return;
    }

}

//遇到结束标签时候出发
- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    self.currentTagName = nil;
}

//遇到文档结束时候触发
- (void)parserDidEndDocument:(NSXMLParser *)parser {
    
    NSLog(@"NSXML解析完成...");
    
//    self.data.text = [NSString stringWithFormat:@"%@\nNSXML解析完成...", self.data.text];
//    
//    for (NSDictionary *dic in self.listData) {
//        self.data.text = [NSString stringWithFormat:@"%@\n num: %@\t name: %@",self.data.text, [dic objectForKey:@"num"],   [dic objectForKey:@"name"]];
//    }
    
}


@end


