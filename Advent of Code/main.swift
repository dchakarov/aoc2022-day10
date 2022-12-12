//
//  main.swift
//  No rights reserved.
//

import Foundation
import Algorithms

func main() {
    let fileUrl = URL(fileURLWithPath: "./aoc-input")
    guard let inputString = try? String(contentsOf: fileUrl, encoding: .utf8) else { fatalError("Invalid input") }
    
    let lines = inputString.components(separatedBy: "\n")
        .filter { !$0.isEmpty }

//    part1(lines)
    part2(lines)
}

func part1(_ lines: [String]) {
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

func part2(_ lines: [String]) {
    var currentCycle = 0
    var x = 1
    var crtRows = [String]()
        
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
            let position = currentCycle % 40 - 1
            var crt = "."
            if position >= x - 1 && position <= x + 1 {
                crt = "#"
            }
//            print("x = \(x); cycle = \(currentCycle); crt = \(crt)")
            crtRows.append(crt)
        }

        x += increment
    }
    
    for chunk in crtRows.chunks(ofCount: 40) {
        print(chunk.joined())
    }
//    print(crtRows)
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
