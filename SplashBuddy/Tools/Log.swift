// SplashBuddy

/*
 Licensed under the Apache License, Version 2.0 (the "License");
 you may not use this file except in compliance with the License.
 You may obtain a copy of the License at
 
 http://www.apache.org/licenses/LICENSE-2.0
 
 Unless required by applicable law or agreed to in writing, software
 distributed under the License is distributed on an "AS IS" BASIS,
 WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 See the License for the specific language governing permissions and
 limitations under the License.
 */

import Foundation
import os

/**
 Performs logging using os_log if on 10.12.x or newer, or NSLog if on older versions.
 
 - authors: Tyler Morgan
 - note: This is only going to be used until 10.11 is no longer supported in the environments.
 - version: 1.0.0
 */
class Log {

    /**
     Used in conjunction with OSLogType to produce the correct log type for OSLog, but also provide the same level of logging for NSLog as well.
     */
    enum Level: UInt8 {
        case debug = 2, error = 16, fault = 17, info = 1
    }
    /**
     Writes to the log using the correct logging methods for the OS.
     
     - parameters:
     -   string: A string that will be entered into the log
     -   cat: The category of the logging, like UI, Foundation, etc.
     -   level: The level of the logging; info, debug, error, fault. Leave blank for default logging.
     */
    static func write(string: String, cat: String, level: Level?) {
        let appName = "io.fti.SplashBuddy"
        if #available(OSX 10.12, *) {
            //  On only OSX 10.12 or newer
            let log = OSLog(subsystem: appName, category: cat)
            if level == .debug {
                os_log("%{public}@", log: log, type: .debug, string)
            } else if level == .error {
                os_log("%{public}@", log: log, type: .error, string)
            } else if level == .fault {
                os_log("%{public}@", log: log, type: .fault, string)
            } else if level == .info {
                os_log("%{public}@", log: log, type: .info, string)
            } else {
                os_log("%{public}@", log: log, type: .default, string)
            }
        } else {
            // Fallback on earlier versions
            if level == .debug {
                NSLog(" [\(cat)] DEBUG: \(string)")
            } else if level == .error {
                NSLog(" [\(cat)] ERROR: \(string)")
            } else if level == .fault {
                NSLog(" [\(cat)] FAULT: \(string)")
            } else if level == .info {
                NSLog(" [\(cat)] INFO: \(string)")
            } else {
                NSLog(" [\(cat)] \(string)")
            }
        }
    }
}
