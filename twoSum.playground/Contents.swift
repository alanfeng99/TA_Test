//: Playground - noun: a place where people can play

import UIKit

/*

Given an array of integers, find two numbers such that they add up to a specific target number.
The function twoSum should return indices of the two numbers such that they add up to the target, where index1 must be less than index2. Please note that your returned answers (both index1 and index2) are not zero-based.
You may assume that each input would have exactly one solution.
Input: numbers={2, 7, 11, 15}, 
target=9 
Output: index1=1, index2=2

*/

func twoSum(arrayOfInts:[Int], target: Int) {

    for (index, element) in arrayOfInts.enumerate() {
        
        let sliceArray = arrayOfInts[index..<arrayOfInts.count]
        
        for (index2, number) in sliceArray.enumerate() {
            
            let value = element + number
            
            if (value == target) {
                print("index1=\(index+1), index2=\(index2+1)")
                break
            }
        }
    }
}

twoSum([2,7,11,15], target: 9)