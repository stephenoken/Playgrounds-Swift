//: Playground - noun: a place where people can play

import Cocoa


enum Some<T>{
    case None,Just(T)
    
    func map(f:(T)->T) ->Some<T>{
        switch self {
        case .Just(let x):
            return .Just(f(x))
        default:
            return Some.None
        }
    }
}

let someNum = Some.Just(4)

//Functor
let someNewNum = someNum.map({$0 + 1})

//Applicative Functor
print(someNewNum)

func add(num1:Int, num2:Int) -> Int {
    return num1 + num2
}

func add3(x:Int) -> Int {
    return add(3,num2:x)
}

let add2: (_:Int) -> Int = {add(10,num2: $0)}
let arr = [1,2,3,4,5,6,7,8,9,10]
arr.map(add3)
arr.map(add2)


// Swift functor-applicative-monads
// http://www.mokacoding.com/blog/functor-applicative-monads-in-pictures/
// Start

// Maybe Monad



enum Optional<T>{
    case Just(T),None
    func map<U>(f: T -> U) -> U? {
        switch self {
        case .Just(let x): return f(x)
        case .None: return .None
        }
    }
    
//    func fmap() -> Any {
//        switch self {
//        case .Just(let x): return x
//        default: return Optional.None
//        }
//    }
}
//Functor
func add6(num:Int) -> Int{
    return num + 6
}

Optional.Just(3).map(add6)

Optional.None.map{$0 + 3}

struct Post {
    let id:Int
    let name:String
}

let posts = [
 Post(id: 1, name: "Joe"),
 Post(id: 2, name: "Bob"),
 Post(id: 3, name: "Rob"),
 Post(id: 4, name: "Kyle")
]

func getNames(p:Post) -> Optional<String> {
    if p.name == "Bob" {
        return Optional.None
    }else{
        return Optional.Just(p.name)
    }
}

Optional.Just(Post(id: 2, name: "Joe")).map(getNames)?.fmap()

// AKA <$>
infix operator <^> { associativity left }
func <^><T, U>(f: T -> U, a: T?) -> U? {
    return a.map(f)
}

add3 <^> 3

arr.map({$0 * 3})

typealias IntFunction = Int -> Int

func map(f: IntFunction, _ g: IntFunction) -> IntFunction {
    return { x in f(g(x)) }
}

let foo = map({$0 * 3},{ $0 + 3})
foo(10)

extension Optional {
    func apply<U>(f:(T->U)?)->U? {
        switch f {
        case .Some(let someF): return self.map(someF)
        case .None: return .None
        }
    }
}

extension Array {
    func apply<U>(fs:[Element -> U]) -> [U] {
        var result = [U]()
        for f in fs {
            for element in self.map(f) {
                result.append(element)
            }
        }
        return result
    }
}

infix operator <*> { associativity left }

func <*><T, U>(f: (T -> U)?, a: T?) -> U? {
    return nil
}

let xPlus3 = Optional.Just({$0 + 3})
//Optional.Just(5).apply(xPlus3)
func <*><T, U>(f: [T -> U], a: [T]) -> [U] {
    return a.apply(f)
}


