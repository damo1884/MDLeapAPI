//
//  MDLeapAPI.h
//  LeapiOS
//
//  Created by Mert Dümenci on 1/24/13.
//  Copyright (c) 2013 Mert Dümenci. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "SRWebSocket.h"

@class MDLeapAPI;

@protocol MDLeapAPIDelegate <NSObject>

-(void)leapAPI:(MDLeapAPI *)api didConnectWithWebSocket:(SRWebSocket *)webSocket;
-(void)leapAPI:(MDLeapAPI *)api didGetData:(NSDictionary *)data;
-(void)leapAPI:(MDLeapAPI *)api didFailWithError:(NSError *)error;
-(void)leapAPI:(MDLeapAPI *)api didCloseConnectionWithCode:(NSInteger)code reason:(NSString *)reason;

@end

@interface MDLeapAPI : NSObject <SRWebSocketDelegate> {
    @private
    SRWebSocket *_ws;
}

@property (nonatomic, retain) NSURL *leapURL;

@property (nonatomic, assign) id <MDLeapAPIDelegate> delegate;

-(id)initWithDelegate:(id <MDLeapAPIDelegate>)delegate;

-(void)connectToLeapAtURL:(NSURL *)url; // URL is formatted as "ws://<computer's IP>:6437"
-(void)reconnect;
-(void)disconnect;

@end
