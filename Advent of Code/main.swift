//
//  main.swift
//  No rights reserved.
//

import Foundation
import RegexHelper

func main() {
    let fileUrl = URL(fileURLWithPath: "./aoc-input")
    guard let inputString = try? String(contentsOf: fileUrl, encoding: .utf8) else { fatalError("Invalid input") }
    
    let lines = inputString.components(separatedBy: "\n")
        .filter { !$0.isEmpty }

    var currentCycle = 0
    var x = 1
    
    var signalStrengths = [Int]()
    
    lines.forEach { line in
        let operation = parseLine(line)
        var cycleDuration = 1
        var increment = 0
        switch operation {
        case .noop: ()
        case .addx(let int):
            increment = int
            cycleDuration = 2
        }
        
        for _ in 0..<cycleDuration {
            currentCycle += 1
            if currentCycle % 40 == 20 {
                signalStrengths.append(currentCycle * x)
            }
        }
        x += increment
    }
    
    let result = signalStrengths.reduce(0, +)
    print(result)
}

enum Operation {
    case noop
    case addx(Int)
}

func parseLine(_ line: String) -> Operation {
    if line.hasPrefix("noop") {
        return .noop
    }
    
    let result = line.components(separatedBy: .whitespaces)
    let value = Int(result[1])!
    
    return .addx(value)
}

main()
