//
//  NetworkLogger.swift
//  DotaHero
//
//  Created by Arif Luthfiansyah on 06/04/21.
//

import Alamofire

public final class NetworkLogger: EventMonitor {
    
    public func requestDidResume(_ request: Request) {
        let body = request.request.flatMap { $0.httpBody.map { String(decoding: $0, as: UTF8.self) } } ?? "None"
        let message = """
        🚀🚀🚀🚀🚀 REQUEST STARTED: \(request)
        🚀🚀🚀🚀🚀 REQUEST BODY DATA: \(body)
        """
        print(message)
    }
    
    public func request<Value>(_ request: DataRequest, didParseResponse response: DataResponse<Value, AFError>) {
        print("⚡️⚡️⚡️⚡️⚡️ RESPONSE RECEIVED: \(response.debugDescription)")
    }
    
}
