//
//  MDLeapAPI.m
//  LeapiOS
//
//  Created by Mert Dümenci on 1/24/13.
//  Copyright (c) 2013 Mert Dümenci. All rights reserved.
//

#import "MDLeapAPI.h"

@interface MDLeapAPI (private)

@end

@implementation MDLeapAPI

#pragma mark - Lifecycle
-(id)initWithDelegate:(id<MDLeapAPIDelegate>)delegate {
    if ((self = [super init])) {
        self.delegate = delegate;
    }
    
    return self;
}

-(id)init {
    if ((self = [super init])) {}
    
    return self;
}

#pragma mark - Connection
-(void)connectToLeapAtURL:(NSURL *)url {
    self.leapURL = url; // set the property
    
    _ws = [[SRWebSocket alloc] initWithURL:self.leapURL]; // initialise the websocket which we'll be using for connection
    _ws.delegate = self;
    
    [_ws open]; // initiate the connection
}

-(void)reconnect {
    [self disconnect];
    
    [self connectToLeapAtURL:self.leapURL]; // we need to re-initialise, can't open a connection again because of RocketSocket
}

-(void)disconnect {
    [_ws close]; // close the websocket connection
}

#pragma mark - SRWebSocket delegate
-(void)webSocketDidOpen:(SRWebSocket *)webSocket {
    if ([self.delegate respondsToSelector:@selector(leapAPI:didConnectWithWebSocket:)]) {
        [self.delegate leapAPI:self didConnectWithWebSocket:webSocket];
    }
}

-(void)webSocket:(SRWebSocket *)webSocket didReceiveMessage:(id)message {
    if (message) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:[message dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONWritingPrettyPrinted error:nil]; // convert the message (JSON string) to a Foundation dictionary
        
        if ([self.delegate respondsToSelector:@selector(leapAPI:didGetData:)]) {
            [self.delegate leapAPI:self didGetData:dict];
        }
    }
}

-(void)webSocket:(SRWebSocket *)webSocket didFailWithError:(NSError *)error {
    if ([self.delegate respondsToSelector:@selector(leapAPI:didFailWithError:)]) {
        [self.delegate leapAPI:self didFailWithError:error];
    }
}

-(void)webSocket:(SRWebSocket *)webSocket didCloseWithCode:(NSInteger)code reason:(NSString *)reason wasClean:(BOOL)wasClean {
    if ([self.delegate respondsToSelector:@selector(leapAPI:didCloseConnectionWithCode:reason:)]) {
        [self.delegate leapAPI:self didCloseConnectionWithCode:code reason:reason];
    }
}

@end
