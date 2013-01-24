# MDLeapAPI

MDLeapAPI is a very rough iOS API for Leap Motion. The Leap Motion drivers on OS X create a web socket for the JavaScript SDK. Using this endpoint, we can get realtime output as JSON.

As for now, there are no model objects for hands, fingers or other stuff. Check the dictionary the following delegate method returns and see if you can build something cool!

```objective-c
-(void)leapAPI:(MDLeapAPI *)api didGetData:(NSDictionary *)data;
```

## Basic Usage

The connection URL you'll be giving the API is usually formatted as
```
ws://<your computer's url>:6437
```

**Setup**

```objective-c
MDLeapAPI *leap = [[MDLeapAPI alloc] initWithDelegate:self];

[leap connectToLeapAtURL:/* URL HERE */];
```

**Seek for the delegate methods firing**

```objective-c
-(void)leapAPI:(MDLeapAPI *)api didConnectWithWebSocket:(SRWebSocket *)webSocket;
-(void)leapAPI:(MDLeapAPI *)api didGetData:(NSDictionary *)data;
-(void)leapAPI:(MDLeapAPI *)api didFailWithError:(NSError *)error;
-(void)leapAPI:(MDLeapAPI *)api didCloseConnectionWithCode:(NSInteger)code reason:(NSString *)reason;
```
***

This project uses RocketSocket by Square. It's added as a submodule. (git submodule update --init)

```
  Copyright 2012 Square Inc.

   Licensed under the Apache License, Version 2.0 (the "License");
   you may not use this file except in compliance with the License.
   You may obtain a copy of the License at

       http://www.apache.org/licenses/LICENSE-2.0

   Unless required by applicable law or agreed to in writing, software
   distributed under the License is distributed on an "AS IS" BASIS,
   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
   See the License for the specific language governing permissions and
   limitations under the License.
```