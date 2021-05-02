//
//  OpenDotaNetworkService.swift
//  DotaHero
//
//  Created by Arif Luthfiansyah on 06/04/21.
//

import Alamofire
import RxSwift

public struct OpenDotaNetworkService {
    
    public static let baseURL = "https://api.opendota.com"
    public static let contextPath = "api"
    
    let session: Session
    
    public init(session: Session = .default) {
        self.session = session
    }
    
    public func fetchHeroStats<Request: Encodable,
                               Response: Decodable>(with requestDTO: Request,
                                                    responseType: Response.Type) -> Observable<(Response, NetworkProgress)> {
        let requestPath = "\(OpenDotaNetworkService.baseURL)/\(OpenDotaNetworkService.contextPath)/herostats"
        return self.session.rx
            .request(.get, requestPath)
            .flatMap({ (request) -> Observable<(Response, NetworkProgress)>  in
                let responsePart: Observable<Response> = request.rx.decodable()
                let progressPart = request.rx.progress()
                return Observable.combineLatest(responsePart, progressPart)
            })
            .observeOn(ConcurrentMainScheduler.instance)
    }
    
}
