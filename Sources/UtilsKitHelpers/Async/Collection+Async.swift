//
//  Collection+Async.swift
//
//
//  Created by Michael Coqueret on 16/02/2024.
//

import Foundation

public extension Collection {
    
    /**
     Asynchronously performs a given completion task for each element in the sequence using a task group.
     The function returns an array of results obtained from the completion tasks.
     - Parameters:
     - completion: A closure representing the asynchronous task to be performed for each element in the sequence.
     It takes an element of the sequence as a parameter and returns a value of type `T`.
     - Returns: An array of results obtained from the completion tasks.
     **/
    func taskGroup<T: Sendable>(
        completion: @Sendable @escaping (Element) async -> T
    ) async -> [T] where Element: Sendable {
        await withTaskGroup(of: T.self) { group -> [T] in
            for element in self {
                group.addTask {
                    await completion(element)
                }
            }
            return await group.reduce(into: [T]()) { $0.append($1) }
        }
    }
}

public extension Collection where Element == (@Sendable () async throws -> Void) {
    
    /**
     Asynchronously executes a series of tasks represented by closures, optionally followed by a completion closure.
     - Parameters:
     - body: An optional closure representing a task to be executed for each element in the sequence. This closure takes no parameters and returns `Void`.
     It is executed before the completion closure, if provided.
     - Note: Each element in the sequence is expected to be a closure that returns `Void` and may throw errors.
     **/
    func run(
        body: (@Sendable () -> Void)? = nil
    ) async {
        await withTaskGroup(of: Void.self) { group in
            for element in self {
                let localBody = body
                group.addTask {
                    try? await element()
                    localBody?()
                }
            }
            await group.waitForAll()
        }
    }
}

