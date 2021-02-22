import UIKit

func multiplyFive(_ string: String?, _ integer: Int?) -> Int{
    guard let integer = integer else {return 0}
    print("Integer value = \(integer)")
    guard let string = string else {return 0}
    print("String value = \(string)")
    return integer * 5
    
}

print(multiplyFive("Info6350", nil))
