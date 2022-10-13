//
//  PidsType.swift
//  ProcessListXPCService
//
//  Created by Aleksei Sapitskii on 6.10.2022.
//

import Foundation

enum PidsType {
    case all
    case pgrp
    case tty
    case uid
    case ruid
    case ppid
    case kdbg
}

extension PidsType: RawRepresentable {
    init?(rawValue: Int32) {
        switch rawValue {
        case PROC_ALL_PIDS:  self = .all
        case PROC_PGRP_ONLY: self = .pgrp
        case PROC_TTY_ONLY:  self = .tty
        case PROC_UID_ONLY:  self = .uid
        case PROC_RUID_ONLY: self = .ruid
        case PROC_PPID_ONLY: self = .ppid
        case PROC_KDBG_ONLY: self = .kdbg
        default: return nil
        }
    }
    
    var rawValue: Int32 {
        switch self {
        case .all:  return PROC_ALL_PIDS
        case .pgrp: return PROC_PGRP_ONLY
        case .tty:  return PROC_TTY_ONLY
        case .uid:  return PROC_UID_ONLY
        case .ruid: return PROC_RUID_ONLY
        case .ppid: return PROC_PPID_ONLY
        case .kdbg: return PROC_KDBG_ONLY
        }
    }
}
