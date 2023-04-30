
import Foundation
import ArgumentParser

/// Mark the conforming type as `@main` to designate the `commandType` to accept standard input as its first argument.
public protocol StandardInputRunner {
    associatedtype Command: AsyncParsableCommand

    static var commandType: Command.Type { get }
}

public extension StandardInputRunner {
    static func main() async throws {
        let standardInput = parseStandardInput()
        var arguments = Array(CommandLine.arguments.dropFirst())
        if let standardInput {
            arguments.insert(standardInput, at: 0)
        }
        var command = commandType.parseOrExit(arguments)
        try await command.run()
    }

    static func parseStandardInput() -> String? {
        // Check for conditions to read from standard input.
        guard CommandLine.arguments.count == 1 || CommandLine.arguments.last == "-" else { return nil }

        // Remove the "-" so it doesn't pollute any other arguments.
        if CommandLine.arguments.last == "-" { CommandLine.arguments.removeLast() }

        // Get contents of standard input.
        var lines: [String] = []
        while let line = readLine() {
            lines.append(line)
        }

        // Empty is not valid input.
        guard !lines.isEmpty else { return nil }

        // Return the value of standard input.
        return lines.reduce("") { (result, line) in
            result + "\n" + line
        }
    }
}
