//
//  WebConnect.m
//  LZHotelControl
//
//  Created by Jony on 17/6/15.
//  Copyright © 2017年 yavatop. All rights reserved.
//

#import "WebConnect.h"
@interface WebConnect()
//@property (nonatomic,strong) NSDictionary *dataDic;
@end

@implementation WebConnect
static WebConnect *sharedWebConnect = nil;
+ (instancetype)sharedWebConnect{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedWebConnect = [[self alloc] init];
    });
    return sharedWebConnect;
}
- (void)some:(void (^)(NSString *str))block{
    
}

- (void)registerWithInfoDic:(NSDictionary *)infoDic complet:(void (^)(NSDictionary *netObject, BOOL isSeccuss))complete{
    
    NSString *parameterStr = [[NSString alloc] initWithFormat:@"?localIp=%@&localPort=%@&userId=%@&userPwd=%@", [infoDic objectForKey:@"localIp"]
                      , [infoDic objectForKey:@"localPort"]
                      , [infoDic objectForKey:@"userId"]
                      , [infoDic objectForKey:@"userPwd"]
                              ];
    NSString *strUrl = [NSString stringWithFormat:@"http://192.168.0.45:8080/webDemo/Register%@",parameterStr];
    
    strUrl = [strUrl stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    NSURL *url = [NSURL URLWithString:strUrl];
    
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *taskError){
        NSLog(@"Register请求完成！");
        if (!taskError) {
            //NSError *jsonError = nil;
          NSDictionary *dataDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
            complete(dataDic,YES);
        }else{
            NSLog(@"\ntask error: %@", taskError.localizedDescription);
            complete(nil,NO);
        }
    }];
    
    [task resume];
}

@end
