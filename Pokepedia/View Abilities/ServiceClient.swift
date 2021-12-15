import Foundation

final class ServiceClient {
    // Get function to retreive data
    func get(from url: URL, completion: @escaping (Result<Data, Error>) -> ()) {
        
        let request = URLRequest(url: url)
        let session = URLSession(configuration: .default)
        let task: URLSessionDataTask = session.dataTask(with: request) { [weak self] data, response, error in
            self?.handle(data: data, response: response, error: error, completion: completion)
        }
        task.resume()
        session.finishTasksAndInvalidate()
    }
    
    private func handle(data: Data?, response: URLResponse?, error: Error?, completion: @escaping (Result<Data, Error>) -> ()) {
        
        if let error = error {
            print(error)
            
            completion(.failure(error))
            return
        }
        
        guard let httpResponse = response as? HTTPURLResponse else {
            print("Could not parse response.")
            let serviceError: ServiceError = .invalidResponse
            
            completion(.failure(serviceError))
            return
            
        }
        
        let isStatusCodesInOkRange = 200...299 ~= httpResponse.statusCode
        guard isStatusCodesInOkRange else {
            let localizedDescription = HTTPURLResponse.localizedString(forStatusCode: httpResponse.statusCode)
            let serviceError: ServiceError = .invalidStatusCode(localizedDescription)
            
            completion(.failure(serviceError))
            return
        }
        
        guard let data = data else {
            print("No data!!!")
            let serviceError: ServiceError = .noData
            
            completion(.failure(serviceError))
            return
        }
        
        completion(.success(data))
        return
    }
    
    // Detailed error messaging 
    private enum ServiceError: CustomNSError {
        case invalidResponse
        case invalidStatusCode(String)
        case noData
        
        var errorUserInfo: [String: Any] {
            switch self {
            case .invalidResponse:
                return [NSLocalizedDescriptionKey: "Invalid response"]
            case .invalidStatusCode(let localizedDescription):
                return [NSLocalizedDescriptionKey: localizedDescription]
            case .noData:
                return [NSLocalizedDescriptionKey: "No Data"]
            }
        }
    }
}
