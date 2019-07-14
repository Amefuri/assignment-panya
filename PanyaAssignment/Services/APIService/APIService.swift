//
//  LoginRequestModelType.swift
//  PanyaAssignment
//
//  Created by peerapat atawatana on 13/7/2562 BE.
//  Copyright © 2562 Socket9. All rights reserved.
//

import Moya
import ObjectMapper
import SwiftyJSON
import RxSwift

public class APIService: APIServiceType {
  
  private var provider = MoyaProvider<API>()
  
  // MARK: Public
 
  func rx_login(requestModel: LoginRequestModelType) -> Observable<UserModel> {
    return handleResponseMap(with: .login(requestModel: requestModel), of: UserModel.self, dataPath: ["data"])
  }
  
  func rx_getRoundStreakBonus(requestModel: GetRoundStreakRequestModelType) -> Observable<[Int]> {
    return handleResponseArrayValue(with: .getRoundStreakBonus(requestModel: requestModel), of: Int.self, dataPath: ["data", "streak_bonus"])
  }
  
  // MARK: Private
  
  private func handleResponse(with targetType: API) -> Observable<JSON> {
    return provider
      .rx
      .request(targetType).debug()
      .asObservable()
      .do(onNext:{ (data) in print("handleResponse---->",(try? data.mapJSON()) ?? "-" ) } )
      .filterSuccessfulStatusCodes()
      .map { JSON($0.data) }
      .filterApiStatus()
      .catchError { throw APIService.Error(error: $0) }
  }
  
  private func handleResponseValue<T>(with targetType: API, of type: T.Type, dataPath: [String] = ["data"]) -> Observable<T> where T: Any {
    return handleResponse(with: targetType)
      .mapApiValue(of: T.self, dataPath: dataPath)
      .catchError { throw APIService.Error(error: $0) }
  }
  
  private func handleResponseArrayValue<T>(with targetType: API, of type: T.Type, dataPath: [String] = ["data"]) -> Observable<[T]> where T: Any {
    return handleResponse(with: targetType)
      .mapApiArrayValue(of: T.self, dataPath: dataPath)
      .catchError { throw APIService.Error(error: $0) }
  }
  
  private func handleResponseMap<T>(with targetType: API, of type: T.Type, dataPath: [String] = ["data"]) -> Observable<T> where T: Mappable {
    return handleResponse(with: targetType)
      .mapApiModel(of: T.self, dataPath: dataPath)
      .catchError { throw APIService.Error(error: $0) }
  }
  
  private func handleResponseMapArray<T>(with targetType: API, of type: T.Type, dataPath: [String] = ["data"]) -> Observable<[T]> where T: Mappable {
    return handleResponse(with: targetType)
      .mapApiModelArray(of: T.self, dataPath: dataPath)
      .catchError { throw APIService.Error(error: $0) }
  }
  
  private func handleResponseArrayWithPrefix<T>(with targetType: API, of type: T.Type, dataPath: [String] = ["data"]) -> Observable<([T], String)> where T: Mappable {
    let sharedResponse = handleResponse(with: targetType).share(replay: 1)
    let arraySignal = sharedResponse
      .mapApiModelArray(of: T.self, dataPath: dataPath)
    let prefixSignal = handleResponse(with: targetType)
      .map { $0["prefix"].stringValue }
    return Observable.zip(arraySignal, prefixSignal)
      .catchError { throw APIService.Error(error: $0) }
  }
}
