//
//  SwiftyUserDefaults+Workaround.swift
//  SwiftBilibili
//
//  Created by Wells on 2022/7/27.
//  Copyright © 2022 luowen. All rights reserved.
//
import SwiftyUserDefaults
import Foundation

extension DefaultsSerializable {
    //swiftlint:disable all
    public static var _defaultsArray: DefaultsArrayBridge<[T]> { return DefaultsArrayBridge() }
}

extension Date: DefaultsSerializable {
    //swiftlint:disable all
    public static var _defaults: DefaultsObjectBridge<Date> { return DefaultsObjectBridge() }
}
extension String: DefaultsSerializable {
    //swiftlint:disable all
    public static var _defaults: DefaultsStringBridge { return DefaultsStringBridge() }
}
extension Int: DefaultsSerializable {
    //swiftlint:disable all
    public static var _defaults: DefaultsIntBridge { return DefaultsIntBridge() }
}
extension Double: DefaultsSerializable {
    //swiftlint:disable all
    public static var _defaults: DefaultsDoubleBridge { return DefaultsDoubleBridge() }
}
extension Bool: DefaultsSerializable {
    public static var _defaults: DefaultsBoolBridge { return DefaultsBoolBridge() }
}
extension Data: DefaultsSerializable {
    public static var _defaults: DefaultsDataBridge { return DefaultsDataBridge() }
}

extension URL: DefaultsSerializable {
    #if os(Linux)
    public static var _defaults: DefaultsKeyedArchiverBridge<URL> { return DefaultsKeyedArchiverBridge() }
    #else
    public static var _defaults: DefaultsUrlBridge { return DefaultsUrlBridge() }
    #endif
    public static var _defaultsArray: DefaultsKeyedArchiverBridge<[URL]> { return DefaultsKeyedArchiverBridge() }
}

extension DefaultsSerializable where Self: Codable {
    public static var _defaults: DefaultsCodableBridge<Self> { return DefaultsCodableBridge() }
    public static var _defaultsArray: DefaultsCodableBridge<[Self]> { return DefaultsCodableBridge() }
}

extension DefaultsSerializable where Self: RawRepresentable {
    public static var _defaults: DefaultsRawRepresentableBridge<Self> { return DefaultsRawRepresentableBridge() }
    public static var _defaultsArray: DefaultsRawRepresentableArrayBridge<[Self]> { return DefaultsRawRepresentableArrayBridge() }
}

extension DefaultsSerializable where Self: NSCoding {
    public static var _defaults: DefaultsKeyedArchiverBridge<Self> { return DefaultsKeyedArchiverBridge() }
    public static var _defaultsArray: DefaultsKeyedArchiverBridge<[Self]> { return DefaultsKeyedArchiverBridge() }
}

extension Dictionary: DefaultsSerializable where Key == String {
    public typealias T = [Key: Value]
    public typealias Bridge = DefaultsObjectBridge<T>
    public typealias ArrayBridge = DefaultsArrayBridge<[T]>
    public static var _defaults: Bridge { return Bridge() }
    public static var _defaultsArray: ArrayBridge { return ArrayBridge() }
}
extension Array: DefaultsSerializable where Element: DefaultsSerializable {
    public typealias T = [Element.T]
    public typealias Bridge = Element.ArrayBridge
    public typealias ArrayBridge = DefaultsObjectBridge<[T]>
    public static var _defaults: Bridge {
        return Element._defaultsArray
    }
    public static var _defaultsArray: ArrayBridge {
        fatalError("Multidimensional arrays are not supported yet")
    }
}
