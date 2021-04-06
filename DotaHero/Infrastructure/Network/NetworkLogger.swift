//
//  NetworkLogger.swift
//  DotaHero
//
//  Created by Arif Luthfiansyah on 07/04/21.
//

import Alamofire

public final class NetworkLogger: EventMonitor {
    
    public func requestDidResume(_ request: Request) {
        let headers = request.request.flatMap { $0.allHTTPHeaderFields.map { $0.description } } ?? "None"
        let body = request.request.flatMap { $0.httpBody.map { String(decoding: $0, as: UTF8.self) } } ?? "None"
        let _request = """
        🚀🚀🚀🚀 REQUEST STARTED: \(request)
        🚀🚀🚀🚀 REQUEST HEADERS: \(headers)
        🚀🚀🚀🚀 REQUEST BODY   : \(body)
        """
        print(_request)
    }
    
    public func request<Value>(_ request: DataRequest, didParseResponse response: AFDataResponse<Value>) {
        NSLog("⚡️⚡️⚡️⚡️ RESPONSE HEADERS : \(String(describing: response.response?.allHeaderFields))")
        NSLog("⚡️⚡️⚡️⚡️ RESPONSE RECEIVED: \(response.debugDescription)")
    }
    
}
