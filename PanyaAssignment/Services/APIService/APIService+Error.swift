//
//  LoginRequestModelType.swift
//  PanyaAssignment
//
//  Created by peerapat atawatana on 13/7/2562 BE.
//  Copyright © 2562 Socket9. All rights reserved.
//

import Moya

public protocol APIServiceErrorType {
  var category: APIService.ErrorCategory { get }
  var name: String { get }
  var message: String { get }
}

public extension APIService
{
  enum ErrorCategory {
    case generic
    case tokenInvalid
  }
  
  struct Error: Swift.Error
  {
    private var _category: ErrorCategory = .generic
    private var _name: String?
    private var _message: String?
    private var _domain: Int?
    private var _code: Int?
    
    public init(
      category: ErrorCategory,
      name: String,
      message: String,
      domain: Int,
      code: Int?)
    {
      self._category = category
      self._name = name
      self._message = message
      self._domain = domain
      self._code = code
    }
    
    public init(category: ErrorCategory = .generic, name: String, message: String) {
      self = Error(
        category: category,
        name: name,
        message: message,
        domain: 0,
        code: 0)
    }
    
    public init(error: Swift.Error) {
      
      if let errorResponse = error as? Error {
        self = errorResponse
      }
      else { // Generic Error
        self = Error(name: "Generic Error", message: error.localizedDescription)
      }
    }
  }
}

extension APIService.Error: APIServiceErrorType {
  
  public var category: APIService.ErrorCategory {
    return _category
  }
  
  public var name: String {
    return _name ?? ""
  }
  
  public var message: String {
    return _message ?? ""
  }
}

