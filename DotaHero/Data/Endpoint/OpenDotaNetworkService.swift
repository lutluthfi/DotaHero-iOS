//
//  OpenDotaNetworkService.swift
//  DotaHero
//
//  Created by Arif Luthfiansyah on 06/04/21.
//

import Alamofire
import RxSwift

public struct OpenDotaNetworkService {
    
    public var baseURL: String { return "https://api.opendota.com" }
    public var contextPath: String { return "api" }
    
    let session: Session
    
    public init(session: Session = .default) {
        self.session = session
    }
    
    public func fetchHeroStats(with requestDTO: FetchHeroStatDTO.Request) -> Observable<([FetchHeroStatDTO.Response], NetworkProgress)> {
        return self.session.rx
            .request(requestDTO.method, "\(self.baseURL)/\(self.contextPath)/\(requestDTO.path)")
            .flatMap { (request) -> Observable<([FetchHeroStatDTO.Response], NetworkProgress)>  in
                let responseDTOPart: Observable<[FetchHeroStatDTO.Response]> = request.rx.decodable()
                let progressPart = request.rx.progress()
                return Observable.combineLatest(responseDTOPart, progressPart)
            }
            .observeOn(ConcurrentMainScheduler.instance)
    }
    
}
