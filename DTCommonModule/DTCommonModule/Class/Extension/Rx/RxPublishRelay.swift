//
//  RxPublishRelay.swift
//  DTCommonModule
//
//  Created by Arif Luthfiansyah on 19/12/21.
//

import RxCocoa
import RxSwift

@propertyWrapper
public struct RxPublishRelay<Element> {
    @available(
        *,
         unavailable,
         message: "Repalce rx directly with `onNext(_:)` or `onError(_:)` instead"
    )
    public let rx: PublishRelay<Element>! = nil
    
    internal let _rx = PublishRelay<Element>()
    public var wrappedValue: Observable<Element> { _rx.asObservable() }
    public var projectedValue: RxPublishRelay<Element> { self }
    
    public init() { }
    
    public init(_ value: Element) {
        _rx.accept(value)
    }
    
    public func asObserver() -> PublishRelay<Element> {
        _rx
    }
    
    public func accept(_ event: Element) {
        _rx.accept(event)
    }
}

extension RxPublishRelay where Element == Void {
    public func accept() {
        _rx.accept(Void())
    }
}

extension RxPublishRelay: ObservableType {
    public func subscribe<Observer>(
        _ observer: Observer
    ) -> Disposable where Observer: ObserverType, Self.Element == Observer.Element {
        _rx.subscribe(observer)
    }
}
