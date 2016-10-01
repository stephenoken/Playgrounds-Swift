//: Playground - noun: a place where people can play
//http://zh-wang.github.io/blog/2015/10/09/functor-monad-applicative-in-swift/

import UIKit


//Currying
func add(x:Int,y:Int) -> Int{
    return x + y
}

func curry<A,B,C>(_ f:@escaping (A,B)->C) -> ((A) -> ((B) ->C)){
    return { a in { b in return f(a,b)}}
}
let curriedAdd = curry(add)

let add100 = curriedAdd(100)

let add5 = curriedAdd(5)

func prepend(_ s1:String,_ s2:String) -> String{
    return s1.appending(" " + s2)
}

prepend("Hello", "World😇")

let curriedPrepend = curry(prepend)
let addEmojies = curriedPrepend("😇")
addEmojies(" Whoop")

enum Maybe<T> {
    case Just(T),None
    // _
    func map<U>(_ f:(T) -> U) -> Maybe<U> {
        switch self {
        case .Just(let x): return .Just(f(x))
        case .None: return .None
        }
    }
}

//Functors 

Maybe.Just(50).map(add5)

func add( x:Double) -> (Int) -> Double{
    return {(y: Int) -> Double in return x + Double(y)}
}

let addOneAndAHalve = add(x: 1.5)

Maybe<Int>.Just(5).map(add5).map(addOneAndAHalve)

//Swift 3 jazz -- could be used to recreate BIRDMAS
precedencegroup functionalSwift {
    associativity: left
}

infix operator <^> : functionalSwift
func <^><T,U>(a:Maybe<T>, f: (T) -> U) -> Maybe<U>{
    return a.map(f)
}
// Lift to functor
func <^><T,U>(a:T, f: (T) -> U) -> Maybe<U>{
    return Maybe.Just(a).map(f)
}

Maybe<Int>.Just(5) <^> add5
Maybe<Int>.Just(5) <^> addOneAndAHalve

5 <^> add5

//Monads

extension Maybe {
    func flatMap<U>(_ f:(T) -> Maybe<U>) -> Maybe<U> {
        switch self {
        case .Just(let x): return f(x)
        case .None: return .None
        }
    }
}

func half(a:Int) -> Maybe<Int>{
    return a % 2 == 0 ? .Just(a/2) : .None
}

Maybe<Int>.Just(4).map(half)

Maybe<Int>.Just(8).flatMap(half).flatMap(half).flatMap(half).flatMap(half)
Maybe<Int>.Just(5).flatMap(half)

infix operator >>= : functionalSwift

func >>=<T,U>(a:Maybe<T>,f:(T) -> Maybe<U>) -> Maybe<U>{
    return a.flatMap(f)
}

Maybe<Int>.Just(8) >>= half >>= half >>= half >>= half
Maybe<Int>.Just(5).flatMap(half)


//Applicative Functors 
extension Maybe {
    func apply<U> (_ f: Maybe<((T) -> U)>) -> Maybe<U>{
        // Note that function `f` is ALSO wrapped in Maybe type
        switch f {
        case .Just(let someF): return self.map(someF)
        case .None: return .None
        }
    }
}

extension Array {
    func apply<U> (_ fs:[(Element) -> U]) -> [U]{
        var result = [U]()
        for f in fs {
            for element in self.map(f){
                result.append(element)
            }
        }
        return result
    }
}

let addFiveBox = Maybe.Just(add5)

Maybe<Int>.Just(5).apply(addFiveBox)

let x = [1,2,3,4,5,6,7,4].apply([{$0 + 5},{$0 - 4}])
print(x)

infix operator <*> : functionalSwift
func <*><T,U>(a:Maybe<T>,f:Maybe<((T) -> U)>) -> Maybe<U> {
    return a.apply(f)
}
func <*><T,U>(a:[T],f:[((T) -> U)]) -> [U] {
    return a.apply(f)
}

Maybe<Int>.Just(5) <*> addFiveBox
let y = [1,2,3,4,5,6,7,4] <*> [{$0 + 5},{$0 - 4}]
print(y)


//Composing Part 1
// f ∘ g
let add10 = {$0 + 10}
let multi5 = {$0 * 5}
let divideBy2 = {$0 / 2}

//let mult5Afteradd10 = {multi5(add10($0))} // Looks crap 

infix operator >>> :functionalSwift
//Compose operator
func >>> <A,B,C>(f: @escaping (B) -> C, g: @escaping (A) -> B) -> (A) -> C {
    return { x in f(g(x))}
}

let divideBy2afterMult5Afteradd10 = divideBy2 >>> multi5 >>> add10
divideBy2afterMult5Afteradd10(10)

print(Maybe<Int>.Just(10).map({(divideBy2 >>> multi5 >>> add10)($0)}))
(Maybe<Int>.Just(5) >>= half).map({(divideBy2 >>> multi5 >>> add10)($0)})

//Note we've only been dealing with single parameter functions

//Pipe Operator
infix operator <<< :functionalSwift
//Compose operator
func <<< <A,B,C>(f: @escaping (B) -> C, g: @escaping (A) -> B) -> (A) -> C {
    return { x in f(g(x))}
}