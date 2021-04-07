//
//  StoragePoint.swift
//  DotaHero
//
//  Created by Arif Luthfiansyah on 27/03/21.
//

import Foundation
import RxSwift

public enum StoragePoint {
    case realm
    case remote
}

public extension StoragePoint {
    
    static func makeRealmStorageNotSupported<C, T>(`class`: C.Type,
                                                   function: String,
                                                   object type: T.Type) -> Observable<T> {
        return Observable<T>.create { (observer) -> Disposable in
            let error = PlainError(description: "\(String(describing: `class`)) -> \(function) is not available for Realm")
            observer.onError(error)
            observer.onCompleted()
            return Disposables.create()
        }.observeOn(CurrentThreadScheduler.instance)
    }
    
    static func makeRemoteStorageNotSupported<C, T>(`class`: C.Type,
                                                    function: String,
                                                    object type: T.Type) -> Observable<T> {
        return Observable<T>.create { (observer) -> Disposable in
            let error = PlainError(description: "\(String(describing: `class`)) -> \(function) is not available for Remote")
            observer.onError(error)
            observer.onCompleted()
            return Disposables.create()
        }.observeOn(CurrentThreadScheduler.instance)
    }
    
}
