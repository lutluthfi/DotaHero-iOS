//
//  StoragePoint.swift
//  DTDomainModule
//
//  Created by Arif Luthfiansyah on 13/11/21.
//

import Foundation
import RxSwift

public enum StoragePoint {
    case realm
    case remote
}

public extension StoragePoint {
    
    static func makeRealmStorageNotSupported<C, T>(
        `class`: C.Type,
        function: String,
        object type: T.Type
    ) -> Observable<T> {
        return Observable<T>.create { (observer) -> Disposable in
            let error = NSError(
                domain: "\(String(describing: `class`)) -> \(function) is not available for Realm",
                code: 0,
                userInfo: nil
            )
            observer.onError(error)
            observer.onCompleted()
            return Disposables.create()
        }.observe(on: CurrentThreadScheduler.instance)
    }
    
    static func makeRemoteStorageNotSupported<C, T>(
        `class`: C.Type,
        function: String,
        object type: T.Type
    ) -> Observable<T> {
        return Observable<T>.create { (observer) -> Disposable in
            let error = NSError(
                domain: "\(String(describing: `class`)) -> \(function) is not available for Remote",
                code: 0,
                userInfo: nil
            )
            observer.onError(error)
            observer.onCompleted()
            return Disposables.create()
        }.observe(on: CurrentThreadScheduler.instance)
    }
    
}
