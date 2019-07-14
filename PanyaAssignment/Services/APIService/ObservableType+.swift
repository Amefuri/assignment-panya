//
//  LoginRequestModelType.swift
//  PanyaAssignment
//
//  Created by peerapat atawatana on 13/7/2562 BE.
//  Copyright © 2562 Socket9. All rights reserved.
//

import Foundation
import Moya
import RxSwift
import SwiftyJSON
import ObjectMapper

public extension ObservableType where Element == Moya.Response {
  
  /// Maps received data at key path into a SwiftyJSON. If the conversion fails, the signal errors.
  func mapSwiftyJSON() -> Observable<JSON> {
    return self.map { JSON($0.data) }
  }
}

public extension ObservableType where Element == JSON {
  
  func filterApiStatus(isIgnoreOutmostArray: Bool = true) -> Observable<Element> {
    return map { json -> Element in
      //print(json)
      var dataRef = json
      
      if isIgnoreOutmostArray
        , let dataRefArray = dataRef.array
        , let dataRefArrayFirstItem = dataRefArray.first {
        dataRef = dataRefArrayFirstItem
      }
      
      let error = dataRef["error"]
      if error == JSON.null {
        return json
      }
      
      throw
        APIService.Error(
          name: "Error: Status \(error["code"].intValue)",
          message: error["message"].stringValue)
    }
  }
  
  func mapApiValue<T>(of type: T.Type,
                      dataPath: [String] = ["data"],
                      isIgnoreOutmostArray: Bool = true) -> Observable<T> where T: Any {
    return map { json -> T in
      var dataRef = json
      
      if isIgnoreOutmostArray
        , let dataRefArray = dataRef.array
        , let dataRefArrayFirstItem = dataRefArray.first {
        dataRef = dataRefArrayFirstItem
      }
      
      for i in 0..<dataPath.count {
        dataRef = dataRef[dataPath[i]]
      }
      guard let mappedModel = dataRef.rawValue as? T
        else {
          throw
            APIService.Error(
              name: "Error: mapApiModel",
              message: "Cannot map object to model.") }
      return mappedModel
    }
  }
  
  func mapApiArrayValue<T>(of type: T.Type,
                      dataPath: [String] = ["data"],
                      isIgnoreOutmostArray: Bool = true) -> Observable<[T]> where T: Any {
    return map { json -> [T] in
      var dataRef = json
      
      if isIgnoreOutmostArray
        , let dataRefArray = dataRef.array
        , let dataRefArrayFirstItem = dataRefArray.first {
        dataRef = dataRefArrayFirstItem
      }
      
      for i in 0..<dataPath.count {
        dataRef = dataRef[dataPath[i]]
      }
      
      return dataRef.arrayObject?.compactMap{ each in return each as? T} ?? []
    }
  }
  
  func mapApiModel<T>(of type: T.Type,
                             dataPath: [String] = ["data"],
                             isIgnoreOutmostArray: Bool = true) -> Observable<T> where T: Mappable {
    return map { json -> T in
      var dataRef = json
      
      if isIgnoreOutmostArray
        , let dataRefArray = dataRef.array
        , let dataRefArrayFirstItem = dataRefArray.first {
        dataRef = dataRefArrayFirstItem
      }
      
      for i in 0..<dataPath.count {
        dataRef = dataRef[dataPath[i]]
      }
      guard let mappedModel = Mapper<T>().map(JSONObject: dataRef.object)
        else {
          throw
            APIService.Error(
              name: "Error: mapApiModel",
              message: "Cannot map object to model.") }
      return mappedModel
    }
  }
  
  func mapApiModelArray<T>(of type: T.Type,
                           dataPath: [String] = ["data"],
                           isIgnoreOutmostArray: Bool = true) -> Observable<[T]> where T: Mappable {
    return map { json -> [T] in
      var dataRef = json
      
      if isIgnoreOutmostArray
        , let dataRefArray = dataRef.array
        , let dataRefArrayFirstItem = dataRefArray.first {
        dataRef = dataRefArrayFirstItem
      }
      
      for i in 0..<dataPath.count {
        dataRef = dataRef[dataPath[i]]
      }
      guard let mappedModel = Mapper<T>().mapArray(JSONObject: dataRef.object)
        else {
          throw
            APIService.Error(
              name: "Error: mapApiModel",
              message: "Cannot map object to model.") }
      return mappedModel
    }
  }
}
