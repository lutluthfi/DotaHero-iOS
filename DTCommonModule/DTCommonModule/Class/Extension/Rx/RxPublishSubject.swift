//
//  RxPublishSubject.swift
//  Alamofire
//
//  Created by Arif Luthfiansyah on 15/11/21.
//

import RxSwift

@propertyWrapper
public struct RxPublishSubject<Element> {
    @available(
        *,
         unavailable,
         message: "Repalce rx directly with `onNext(_:)` or `onError(_:)` instead"
    )
    public let rx: PublishSubject<Element>! = nil
    
    internal let _rx: PublishSubject<Element> = PublishSubject<Element>()
    public var wrappedValue: Observable<Element> { _rx }
    public var projectedValue: RxPublishSubject<Element> { self }
    
    public init() { }
    
    public init(_ value: Element) {
        _rx.onNext(value)
    }
    
    public var hasObservers: Bool {
        _rx.hasObservers
    }
    
    public func asObserver() -> PublishSubject<Element> {
        _rx
    }
}

extension RxPublishSubject where Element == Void {
    public func onNext() {
        _rx.onNext(Void())
    }
}

extension RxPublishSubject: ObservableType, SubjectType, Cancelable, ObserverType {
    public var isDisposed: Bool {
        _rx.isDisposed
    }
    
    public func on(_ event: Event<Element>) {
        _rx.on(event)
    }
    
    public func dispose() {
        _rx.dispose()
    }
    
    public func subscribe<Observer>(
        _ observer: Observer
    ) -> Disposable where Observer: ObserverType, Self.Element == Observer.Element {
        _rx.subscribe(observer)
    }
}
