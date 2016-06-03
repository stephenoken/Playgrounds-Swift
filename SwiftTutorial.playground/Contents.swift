//: Playground - noun: a place where people can play

var str = "Hello, playground"

let exlicitFloat:Float = 4

let label = "The width is "
let width = 94
let widthLabel = label + String(width)

let apples = 3
let oranges = 5

let appleSummary = "I have \(apples) apples."
let fruitSummary = "I have \(apples + oranges) pieces of fruit."


let individualScores = [75,43,103,87,12]

var teamScore = 0

for score in individualScores{
    if score > 50{
        teamScore += 3
    }else{
        teamScore += 1
    }
}

print(teamScore)

let teamScores = individualScores.map({(score)-> Int in
    if score > 50 {return 3}
    else {return 1}
})

teamScores.reduce(0, combine:+)

var optionalString: String? = "Hello"
print(optionalString == nil)

var optionalName:String? = nil
var greeting = "Hello!"
if let name = optionalName {
    greeting = "Hello \(name)"
}

let nickName:String? = nil
let fullName:String? = "John Appleseed"
let informalGreeting = "Hi \(nickName ?? fullName)"


let vegetable = "red pepper"
switch vegetable {
    case "celery":
        print("Add some raisins")
    case "cucumber":
        print("Just eat you freak")
    case let x where x.hasSuffix("pepper"):
        print("Your hot stuff")
    default:
        print("Everything tastes horiible")
}

let interestingNumbers = [
    "Prime": [2, 3, 5, 7, 11, 13],
    "Fibonacci": [1, 1, 2, 3, 5, 8],
    "Square": [1, 4, 9, 16, 25],
]

var largest = 0
var largestKind:String = ""
for (kind, numbers) in interestingNumbers {
    for number in numbers {
        if number > largest {
            largestKind = kind
            largest = number
        }
    }
}
print(largest)
print(largestKind)

func getLargest(previous:Int,current:Int)->Int{
    if(current > previous){
        return current
    }
    return previous
}

let largestNumbers = interestingNumbers.map({(kind, numbers) -> [String: Int] in
    [kind: numbers.reduce(0, combine: getLargest)]
})
//
//func getInterestingNumber(prev:[String:Int],curr:[String:Int]) -> (String,Int){
//    if(current)
//}
//largestNumbers.reduce(0, combine:getInterestingNumber )


var n = 2
while n < 100{
    n = n*2
}
print(n)

var m = 2
repeat{
    m = m * 2
} while m > 100

print(m)

var firstForLoop = 0

for i in 0..<5{
    firstForLoop += i
}

print(firstForLoop)

func greet(name:String, day:String, special:String) -> String {
    return "Hello \(name), today is \(day). The special is \(special)"
}

print(greet("Bob", day:"Tuesday", special: "Vegetable Soup"))

func calculateStatistics(scores:[Int]) -> (min:Int,max:Int,sum:Int,avg:Int) {
    return (
        scores.reduce(scores[0],combine: {min($0, $1)}),
        scores.reduce(scores[0],combine: {max($0, $1)}),
        scores.reduce(scores[0],combine:+),
        scores.reduce(scores[0], combine:+)/scores.count
    )
}

calculateStatistics([98,24,34,40,56,69,76,82,91,100,44,50,76])

func sumOf(numbers:Int...) -> Int{
    return numbers.reduce(numbers[0], combine:+)
}

sumOf(42, 597, 12)

let numbers = [1,2,3,4,5,6,7,8,9,0]
let mappedNumbers = numbers.map({return $0 * 3})
let sortedNumbers = numbers.sort {$0>$1}
let zippedNumbers = Array(Zip2Sequence(mappedNumbers,sortedNumbers))

//let mappedNumbers = numbers.map({ number in 3 * number })
print(mappedNumbers)
print(sortedNumbers)

let infinteNumbers = [0...100]

class NamedShape {
    var numberOfSides = 0
    var name:String
    
    init(name:String){
        self.name = name
    }
    
    func simpleDesciption() -> String {
        return "A shape with \(numberOfSides)"
    }
}

let shape = NamedShape(name: "Square")

print(shape.simpleDesciption())
//Optionals
//var display: UILabel?
//if let label = display{
//    if let text = label.text{
//        let x = text.hashValue
//    }
//}
//can be expressed as 
//if let x = display?.text?.hashValue{...}

//Set default values for optionals
//let s:string? = nil
//if s!=nil{
//    display.text = s
//}else{
//    display.text=" "
//}
//can be expressed as
//display.text = s ?? ""


//tuples

//let x:(String,Int,Double) = ("Hello",5,0.85)
//let (word,number,value) = x
//print(word)
//print(number)
//print(value)

//can be expressed as 

//let x:(w:String,n:Int,v:Double) = ("Hello",5,0.85)
//print(x.w)
//print(x.n)
//print(x.v)

//tuples are effectively types

//func getSize() -> (weight:Double,height:Double) {
//    return (250,80)
//}
//
//let x = getSize()
//print("weight is \(x.weight)")
//print ("Height is \(getSize().height)")

//Range

//struct Range<T>{
//    var startIndex:T
//    var endIndex:T
//}
//Range<Int> would be an array's range
//A string subrange would not be Range<Int> (It would be Range<String.Index>)

//Range ...(inclusive) ..<(open-ended)

//let arr = ["a","b","c","d"]
//let arr = ["a"..."z"]
//let x = arr[2...9]
//print(x)
//for i in 1...5{
//    print(i)
//}


//Methods

func foo(first:Int, externalSecond second: Double) -> Double{
    var sum = 0.0
    for _ in 0..<first{sum+=second}
    return sum
}

func bar() -> Double{
   return foo(123,externalSecond:5.5)
}
bar()

//There are static instances like Double.abs(12.60)
//There are instance foo.bar()

//Properties

var someStoredValue = 42 {
willSet {print("Hello")}
didSet {oldValue}
}

someStoredValue = 46

//lazy properties don't get initalised until someone calls it 

//var a = Array<String>()
//var a = [String]()

//var dict :Dictionary<String,Int>= [
//    "One":1,
//    "Two":2
//]

//Inference Baby!!
//let dict = [
//"One":1,
//"Two":2]
//
//let arr = dict.map({$1+1})
//print(arr)
//let filteredBigNumbers = (0...10000).filter({$0 % 2 != 0})
//print(filteredBigNumbers)
//let mappedBigNumbers = filteredBigNumbers.map{$0^2}
//let reduceNumbers = mappedBigNumbers.reduce(0){$0 + $1}
//print(reduceNumbers)

//Pallindrome Test
let t = "Race car".lowercaseString.characters.split(" ").map(String.init).joinWithSeparator("")
let t1 = t == String(t.characters.reverse())
print(t1)

//Note that enums raw value start at 0 by default. In the velow example we start Ace at 1 Two to 2...
enum Rank:Int {
    case Ace = 1
    case Two,Three,Four,Five,Six,Seven,Eight,Nine,Ten
    case Jack,Queen,King
    func simpleDescription() -> String {
        switch self {
        case .Ace:
            return "Ace"
        case .Jack:
            return "Jack"
        case .Queen:
            return "Queen"
        case .King:
            return "King"
        default:
            return String(self.rawValue)
        }
    }
    
    func indefinateArtical() -> Bool {
        let value = String(self).lowercaseString
        return ["a","e","i","o","u"].indexOf(value.)
    }
}
let ace = Rank.Ace
let rawVal = ace.rawValue
let rawVal2 = ace.indefinateArtical()

func compareCards(card1:Rank,card2:Rank) -> Rank {
    return card1.rawValue >= card2.rawValue ? card1 : card2
}
let TwoCard = Rank.Two

let graterCard = compareCards(ace, card2: TwoCard)

assert(rawVal == 1)

Rank(rawValue: 15)?.simpleDescription()
//The init retruns a constructor
Rank(rawValue: 13)?.simpleDescription()

enum Suit {
    case Spades, Hearts, Diamonds, Clubs
    func simpleDescription() -> String {
        switch self {
        case .Spades:
            return "Spades"
        case .Clubs:
            return "Clubs"
        case .Diamonds:
            return "Diamonds"
        case .Hearts:
            return "Hearts"
        }
    }
}

let hearts = Suit.Hearts
hearts.simpleDescription()

let card:(s:Suit,r:Rank) = (Suit.Hearts,Rank.Eight)
print("Your card has is \(String (card.r)) \(card.r) of \(card.s)")


struct Card {
    var rank: Rank
    var suit: Suit
    
    func simpleDescription() -> String {
        return "The  \(rank.simpleDescription()) of \(suit.simpleDescription)"
    }
}

let threeOfSpades = Card(rank: .Three, suit: .Spades)
threeOfSpades.simpleDescription()