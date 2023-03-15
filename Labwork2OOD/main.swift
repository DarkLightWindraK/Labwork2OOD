import Foundation

var task: Int?
repeat {
    print("Выберите задачу: 1 или 2")
    task = Int(readLine() ?? "")
} while task == nil

switch task {
case 1:
    var numberOfPaths: Int?
    repeat {
        print("Введите количество путей (не менее 2): ")
        numberOfPaths = Int(readLine() ?? "")
    } while numberOfPaths == nil
    
    var paths: [String] = []
    
    for _ in 1...numberOfPaths! {
        paths.append(readLine() ?? "")
    }
    
    _ = FirstFileHandler(paths: paths)
case 2:
    var numberOfPaths: Int?
    repeat {
        print("Введите количество путей (не менее 3): ")
        numberOfPaths = Int(readLine() ?? "")
    } while numberOfPaths == nil
    
    var paths: [String] = []
    
    for _ in 1...numberOfPaths! {
        paths.append(readLine() ?? "")
    }
    
    _ = SecondFileHandler(paths: paths)
default:
    break
}
