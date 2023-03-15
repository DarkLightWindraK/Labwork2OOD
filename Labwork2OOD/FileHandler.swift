import Foundation

protocol FileHandler: AnyObject {
    var pathsToRead: [String] { get set }
    var pathToWrite: String { get set }
    
    init?(paths: [String])
    
    func readFile(path: String)
    func writeFile(path: String)
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

class SecondFileHandler: FileHandler {
    var pathsToRead: [String] = []
    var pathToWrite: String
    
    private var words = Set<String>()
    private var resultPaths: [String] = []
    
    func readFile(path: String) {
        var mySet: Set<String> = []
        _ = try? String(
            contentsOf: URL(filePath: path),
            encoding: .utf8
        )
            .components(separatedBy: CharacterSet(charactersIn: " \n"))
            .filter { !$0.isEmpty }
            .map { mySet.insert(String($0)) }
        if words.isSubset(of: mySet) {
            resultPaths.append(path)
        }
    }
    
    func writeFile(path: String) {
        resultPaths.forEach { resultPath in
            try? resultPath.write(toFile: path, atomically: false, encoding: .utf8)
        }
    }
    
    required init?(paths: [String]) {
        guard paths.count >= 3 else { return nil }
        
        pathToWrite = paths.last!
        _ = try? String(
            contentsOf: URL(filePath: paths.first!),
            encoding: .utf8
        )
            .components(separatedBy: CharacterSet(charactersIn: " \n"))
            .filter { !$0.isEmpty }
            .map { words.insert($0) }
        
        for index in 1..<paths.count - 1 {
            pathsToRead.append(paths[index])
        }
        
        run()
    }
    
    
}
