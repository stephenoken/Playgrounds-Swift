//: Playground - noun: a place where people can play

import Cocoa

var str = "Hello, playground"

enum ServerResponse {
    case Result (String,String)
    case Failure(String)
}

let success = ServerResponse.Result("6:00 am", "8:17 pm")
let failure = ServerResponse.Failure("Out of Cheese")

switch success {
    
case let .Result(sunrise, sunset):
    print("sunrise at \(sunrise) and sunset at \(sunset).")
case let .Failure(message):
    print("Failure \(message)")
}

//Protocols 

protocol ExampleProtocol {
    var simpleDescription:String{get}
    mutating func adjust()
}

class SimpleClass: ExampleProtocol {
    var simpleDescription = "A very Simple class"
    var anotherProperty = 34
    
    func adjust() {
        simpleDescription += " Now 100% adjusted"
    }
}

var a = SimpleClass()
a.adjust()

let aDescription = a.simpleDescription

struct SimpleStructure:ExampleProtocol {
    var simpleDescription: String = "A simple description"
    mutating func adjust() {
        simpleDescription += " (adjusted)"
    }
}

var b = SimpleStructure()
b.adjust()

let bDescription = b.simpleDescription

enum SimpleEnum:ExampleProtocol {
    case Base, Adjusted
    var simpleDescription: String {
        return self.getDescription()
    }
    
    func getDescription() -> String {
        switch self {
        case .Base:
            return "A simple descitpion"
        case .Adjusted:
            return "Adjusted simple description"
        }
    }
    
    mutating func adjust() {
        self = SimpleEnum.Adjusted
    }
    
}

var c = SimpleEnum.Base
print(SimpleEnum.Base.simpleDescription)
c.adjust()
print(c.simpleDescription)


extension Int: ExampleProtocol{
    var simpleDescription: String{
        return "The number is \(self)"
    }
    
    mutating func adjust() {
        self += 7
    }
}

print(7.simpleDescription)
var x = 7
print(x.adjust())


extension Double{
    var absolute:Double{
        return round(self)
    }
}

var y :Double = 14.443
print(y.absolute)

let protocolValue: ExampleProtocol = a
print(protocolValue.simpleDescription)
//print(protocolValue.anotherProtperty)


//Error Handling
enum PrinterError:ErrorType {
    case OutOfPaper,NoToner,OnFire
}

func sendToPrinter(printerName:String) throws -> String {
    if printerName == "Never Has Toner"{
        throw PrinterError.NoToner
    }
    
    return "Job Sent"
}


do{
    let printerResponse = try sendToPrinter("Bi Sheng")
    print(printerResponse)
} catch{
    print(error)
}

do {
    let printerResponse = try sendToPrinter("Gutenberg")
    print(printerResponse)
} catch PrinterError.OnFire {
    print("I'll just put this over here, with the rest of the fire.")
} catch let printerError as PrinterError {
    print("Printer error: \(printerError).")
} catch {
    print(error)
}


let printerSuccess = try? sendToPrinter("Mergenthler")
let printerFailure = try? sendToPrinter("Never Has Toner")


var fridgeIsOpen = false
let fridgeContent = ["milk","eggs","leftovers"]

func fridgeContains(itemName: String) -> Bool{
    fridgeIsOpen = true
    defer {
        fridgeIsOpen = false
    }
    
    return fridgeContent.contains(itemName)
    
}

fridgeContains("banana")
print(fridgeIsOpen)



//Generics 


func repeatItem<T>(item:T,numberOfTimes:Int) -> [T]{
    var result = [T]()
    for _ in 0..<numberOfTimes{
        result.append(item)
    }
    
    return result
}

repeatItem("knock",numberOfTimes: 12)

struct Person {
    let firstName: String
    let lastName:String
    let age: Int
    func desciption() -> String {
        return "Hello"
    }
}

repeatItem(Person(firstName:"John",lastName:"Snow",age:25).desciption(),numberOfTimes: 10)
//Haskell FTW
enum Monad<Context>{
    case Nothing,Just(Context)
    func unWrap() -> Any{
        switch self {
        case .Just(let x):
            return x
        default:
            return Monad.Nothing
        }
    }
}

var possibleInteger: Monad<Int> = .Nothing
possibleInteger = .Just(199)
possibleInteger.unWrap()

var possibleStr:String? = "Hello"
print(possibleStr)

func anyCommonElements<T:SequenceType,U:SequenceType where T.Generator.Element: Equatable,T.Generator.Element == U.Generator.Element>(lhs:T,_ rhs: U) -> Bool {
    for lhsItem in lhs {
        for rhsItem in rhs {
            if lhsItem == rhsItem {
                return true
            }
        }
    }
    return false
}

anyCommonElements([1,2,3,4,5,6,7,8], [3])

//func anyCommonElements2<T:SequenceType,U:SequenceType where T.Generator.Element: Equatable,T.Generator.Element == U.Generator.Element>(lhs:T,_ rhs: U) -> T {
//    for lhsItem in lhs {
//        for rhsItem in rhs {
//            if lhsItem == rhsItem {
//                lhsItem
//                return lhsItem
//            }
//        }
//    }
//    return nil
//}
//
//
//anyCommonElements2([Int](1...8), [3])


let str1 = "I am the very model of a modern Major-General, I've information vegetable, animal, and mineral, I know the kings of England, and I quote the fights historical From Marathon to Waterloo, in order categorical;a I'm very well acquainted, too, with matters mathematical,I understand equations, both the simple and quadratical,About binomial theorem I'm teeming with a lot o' news, (bothered for a rhyme)With many cheerful facts about the square of the hypotenuse.I'm very good at integral and differential calculus;I know the scientific names of beings animalculous:In short, in matters vegetable, animal, and mineral,I am the very model of a modern Major-General. 😑"

str1.characters.count


let str2 = "Race C_a_r!"

func isPallindrome(str:String) -> Bool {
    return true
}

isPallindrome(str2)

let names = ["Jack", "Jill","Nathan","Stephen"]

let reversed = names.sort({$1 < $0})

reversed

//This is a functor
let optionalStr: String? = "Hello"
optionalStr.map {$0.uppercaseString}

let add: (x1 :Int, x2: Int) -> Int = {x1,y1 in x1 + y1}

let addTen: ((a:Int) -> Int)? = {add(x1: $0,x2: 10)}

let optionalInt: Int? = 5

print(optionalInt.flatMap{$0 + 10})


func add(a: Int, b: Int) -> Int {
    return a + b
}

func addTwo(a: Int) -> Int {
    return add(a, b: 2)
}

let xs = 1...100
let q = xs.map(addTwo)

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
var q1 = "ww"
print(q1.uppercaseString)
let someNewNum = someNum.map({$0 + 1})
print(someNewNum)