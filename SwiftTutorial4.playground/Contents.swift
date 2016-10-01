//: Playground - noun: a place where people can play

import Cocoa

var str = "Hello, playground"

enum Optional<T>{
    case Just(T),None
    func map<U>(f: (T) -> U) -> U? {
        switch self {
        case .Just(let x): return f(x)
        case .None: return .none
        }
    }
    
    func apply<U>(f:((T)->U)?)->U? {
        switch f {
        case .some(let someF): return self.map(f: someF)
        case .none: return .none
        }
    }
}

extension Array {
    func apply<U>(fs:[(Element) -> U]) -> [U] {
        var result = [U]()
        for f in fs {
            for element in self.map(f) {
                result.append(element)
            }
        }
        return result
    }
}

infix operator <^> { associativity left }
func <^><T, U>(f: (T) -> U, a: T?) -> U? {
    return a.map(f)
}

let add3 = {$0 + 3}
add3 <^> 3

infix operator <*> { associativity left }

func <*><T, U>(f: ((T) -> U)?, a: Optional<T>) -> U? {
    return a.apply(f: f)
}

let xPlus3 = Optional.Just({$0 + 3})
func <*><T, U>(f: [(T) -> U], a: [T]) -> [U] {
    return a.apply(fs: f)
}


let optionalApply = {$0 + 3} <*> Optional.Just(5)
print(Optional.Just(5).map(f: {$0 + 5}))
//let optionalApply2 = Optional.Just({$0 + 3}).apply(f: Optional.Just(5))
//let optionalApply2 = Optional.Just(5).apply(f: {$0 + 3})
//let optionalApply2 = Optional.Just(5).apply(f: Optional.Just({$0 + 5}))

let arrayApply = [{$0 + 3},{$0 * 10}] <*> [1,2,3]
let arrayApply2 = [1,2,3].apply(fs: [{$0 + 4}])

print(arrayApply)
print(arrayApply2)
