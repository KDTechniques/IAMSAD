//
//  UIDevice+EXT.swift
//  IAMSAD
//
//  Created by Mr. Kavinda Dilshan on 2024-01-09.
//

import UIKit

let screenWidth: CGFloat = UIScreen.main.bounds.size.width
let screenHeight: CGFloat = UIScreen.main.bounds.size.height
let bottomBarStandardFrameHeight: CGFloat = 57
let scrollBottomPadding: CGFloat = screenWidth/4
let modelSize: ViewThatFitsTypes = UIDevice.getViewThatFits()

extension UIDevice {
    // MARK: - modelNameNSize
    static let modelNameNSize: (String, Double?) = {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") {
            guard let value = $1.value as? Int8, value != 0 else { return $0 }
            return $0 + String(UnicodeScalar(UInt8(value)))
        }
        
        func mapToDevice(identifier: String) -> (String, Double?) {
            switch identifier {
            case "iPhone10,1", "iPhone10,4":    return ("iPhone 8", 4.7)
            case "iPhone10,2", "iPhone10,5":    return ("iPhone 8 Plus", 5.5)
            case "iPhone10,3", "iPhone10,6":    return ("iPhone X", 5.8)
            case "iPhone11,2":                  return ("iPhone XS", 5.8)
            case "iPhone11,4", "iPhone11,6":    return ("iPhone XS Max", 6.5)
            case "iPhone11,8":                  return ("iPhone XR", 6.1)
            case "iPhone12,1":                  return ("iPhone 11", 6.1)
            case "iPhone12,3":                  return ("iPhone 11 Pro", 5.8)
            case "iPhone12,5":                  return ("iPhone 11 Pro Max", 6.5)
            case "iPhone13,1":                  return ("iPhone 12 mini", 5.4)
            case "iPhone13,2":                  return ("iPhone 12", 6.1)
            case "iPhone13,3":                  return ("iPhone 12 Pro", 6.1)
            case "iPhone13,4":                  return ("iPhone 12 Pro Max", 6.7)
            case "iPhone14,4":                  return ("iPhone 13 mini", 5.4)
            case "iPhone14,5":                  return ("iPhone 13", 6.1)
            case "iPhone14,2":                  return ("iPhone 13 Pro", 6.1)
            case "iPhone14,3":                  return ("iPhone 13 Pro Max", 6.7)
            case "iPhone14,7":                  return ("iPhone 14", 6.1)
            case "iPhone14,8":                  return ("iPhone 14 Plus", 6.7)
            case "iPhone15,2":                  return ("iPhone 14 Pro", 6.1)
            case "iPhone15,3":                  return ("iPhone 14 Pro Max", 6.7)
            case "iPhone12,8":                  return ("iPhone SE (2nd generation)", 4.7)
            case "iPhone14,6":                  return ("iPhone SE (3rd generation)", 4.7)
            case "iPhone15,4":                  return ("iPhone 15", 6.1)
            case "iPhone15,5":                  return ("iPhone 15 Plus", 6.7)
            case "iPhone16,1":                  return ("iPhone 15 Pro", 6.1)
            case "iPhone16,2":                  return ("iPhone 15 Pro Max", 6.7)
                // iPhone 16 lineup goes here in the future...
            case "i386", "x86_64", "arm64":     return (
                "Simulator \(mapToDevice(identifier: ProcessInfo().environment["SIMULATOR_MODEL_IDENTIFIER"] ?? "iOS"))",
                mapToDevice(identifier: ProcessInfo().environment["SIMULATOR_MODEL_IDENTIFIER"] ?? "iOS").1
            )
            default:                            return (identifier, nil)
            }
        }
        return mapToDevice(identifier: identifier)
    }()
    
    // MARK: - getViewThatFits
    static func getViewThatFits() -> ViewThatFitsTypes {
        guard let modelSize: Double = UIDevice.modelNameNSize.1 else { return .xLarge }
        
        if modelSize < 5.4 {
            return .xSmall
        } else if modelSize < 5.7 {
            return .small
        } else if modelSize < 6.0 {
            return .medium
        } else if modelSize < 6.5 {
            return .large
        } else {
            return .xLarge
        }
    }
}
