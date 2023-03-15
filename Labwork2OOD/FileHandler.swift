import Foundation

protocol FileHandler: AnyObject {
    var pathsToRead: [String] { get set }
    var pathToWrite: String { get set }
    
    func readFile(path: String)
    func writeFile(path: String)
    init?(paths: [String])
}

extension FileHandler {
    func run() {
        for path in pathsToRead {
            readFile(path: path)
        }
        writeFile(path: pathToWrite)
    }
}

class FirstFileHandler: FileHandler {
    var pathsToRead: [String] = []
    var pathToWrite: String
    
    private var buffer = ""
    
    func readFile(path: String) {
        let text = try? String(contentsOf: URL(filePath: path), encoding: .utf8)
        buffer += text?.uppercased() ?? ""
    }
    
    func writeFile(path: String) {
        try? buffer.write(toFile: path, atomically: false, encoding: .utf8)
    }
    
    required init?(paths: [String]) {
        guard paths.count >= 2 else { return nil }
        
        for index in 0..<paths.count - 1 {
            pathsToRead.append(paths[index])
        }
        pathToWrite = paths.last!
        
        run()
    }
}
