//
//  Observable.swift
//  NewsDay
//
//  Created by ihan carlos on 18/05/24.
//

import Foundation

class Observable<T> {

    private var value: T {
        didSet {
            notifyObservers()
        }
    }
    
    init(_ value: T) {
        self.value = value
    }

    private var observers: [(T) -> Void] = []
    
    func addObserver(_ observer: @escaping (T) -> Void) {
        observers.append(observer)
        observer(value)
    }

    private func notifyObservers() {
        for observer in observers {
            observer(value)
        }
    }

    var observedValue: T {
        get {
            return value
        }
        set {
            value = newValue
        }
    }
}
