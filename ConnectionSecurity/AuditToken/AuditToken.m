//
//  AuditToken.m
//  com.alex.ProcessKillerXPCService
//
//  Created by Aleksei Sapitskii on 12.10.2022.
//

#import <Foundation/Foundation.h>

#import "AuditToken.h"

@implementation AuditToken

+ (NSData *)getAuditTokenFromNSXPCConnection:(NSXPCConnection *)connection {
    audit_token_t auditToken = connection.auditToken;
    return [NSData dataWithBytes:&auditToken length:sizeof(audit_token_t)];
}

@end
