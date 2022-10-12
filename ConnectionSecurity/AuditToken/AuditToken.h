//
//  AuditToken.h
//  com.alex.ProcessKillerXPCService
//
//  Created by Aleksei Sapitskii on 12.10.2022.
//

#import <Foundation/Foundation.h>

@interface NSXPCConnection(PrivateAuditToken)

@property (nonatomic, readonly) audit_token_t auditToken;

@end


@interface AuditToken : NSObject

+(NSData *)getAuditTokenFromNSXPCConnection:(NSXPCConnection *)connection;

@end
