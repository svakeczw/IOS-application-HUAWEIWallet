//
//  ObjectSavable.swift
//  HUAWEI Wallet
//
//  Created by 刘皇逊 on 23/5/20.
//  Copyright © 2020 hayden. All rights reserved.
//

import Foundation

//iOS supports several types of objects that we can directly save into UserDefaults like Int, String, Float, Double, Bool, URL, Data or collection of these types.
//But what if we want to save custom objects into UserDefaults?
//If you want to store any other type of object, you should typically archive it to create an instance of NSData.
//简而言之，为了使用UserDefault存储 custome objects,我们使用Codeable protocol
//https://medium.com/flawless-app-stories/save-custom-objects-into-userdefaults-using-codable-in-swift-5-1-protocol-oriented-approach-ae36175180d8

protocol ObjectSavable {
    func setObject<Object>(_ object: Object, forKey: String) throws where Object: Encodable
    func getObject<Object>(forKey: String, castTo type: Object.Type) throws -> Object where Object: Decodable
}



// MARK: To manage the failures below I have created an enum ObjectSavableError of raw type String which is conforming to LocalizedError protocol.

enum ObjectSavableError: String, LocalizedError {
    case unableToEncode = "Unable to encode object into data"
    case noValue = "No data object found for the given key"
    case unableToDecode = "Unable to decode object into given type"
    
    var errorDescription: String? {
        rawValue
    }
}

// MARK: setObject -> save it into the UserDefaults with the given key

extension UserDefaults: ObjectSavable {
    func setObject<Object>(_ object: Object, forKey: String) throws where Object: Encodable {
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(object)
            set(data, forKey: forKey)
        } catch {
            throw ObjectSavableError.unableToEncode
            
        }
    }

// MARK: getObject -> retrieve the object from UserDefaults for the given key
    
    func getObject<Object>(forKey: String, castTo type: Object.Type) throws -> Object where Object: Decodable {
        guard let data = data(forKey: forKey) else { throw ObjectSavableError.noValue }
        let decoder = JSONDecoder()
        do {
            let object = try decoder.decode(type, from: data)
            return object
        } catch {
            throw ObjectSavableError.unableToDecode
        }
    }
}

