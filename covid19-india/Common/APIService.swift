import Foundation

class APIService {
    
    func get(url: String, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) {
        let request = makeRequest(url: url)
        performRequest(request: request, completionHandler: completionHandler)
    }
    
    func get<T : Codable>(url: String, completionHandler: @escaping (T?, Error?) -> Void) {
        get(url: url) { (data, response, error) in
            self.completeCodableRequest(data: data, error: error, completionHandler: completionHandler)
        }
    }
    
    func post(body: Any?, url: String, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) {
        var request = makeRequest(url: url)
        request.httpMethod = "POST"
        
        if let body = body {
            do {
                let convertedData = try JSONSerialization.data(withJSONObject: body, options: .prettyPrinted)
                request.httpBody = convertedData
                
            } catch {
                fatalError("Cannot convert data to request body")
            }
        }
        
        performRequest(request: request, completionHandler: completionHandler)
    }
    
    func post<T: Codable>(body: Any?, url: String, completionHandler: @escaping (T?, Error?) -> Void) {
        post(body: body, url: url) { (data, response, error) in
            self.completeCodableRequest(data: data, error: error, completionHandler: completionHandler)
        }
    }
    
    private func completeCodableRequest<T: Codable>(data: Data?, error: Error?, completionHandler: @escaping (T?, Error?) -> Void) {
        guard error == nil else {
            completionHandler(nil, error)
            return
        }
        
        guard let safeData = data else {
            completionHandler(nil, nil)
            return
        }
        
        
        do {
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            let result = try decoder.decode(T.self, from: safeData)
            completionHandler(result, nil)
        } catch let parseError {
            completionHandler(nil, parseError)
        }
    }
    
    private func performRequest(request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) {
        let session = URLSession(configuration: URLSessionConfiguration.default)
        
        session.dataTask(with: request) { (data, response, error) in
            completionHandler(data, response, error)
        }.resume()
    }
    
    private func makeRequest(url: String) -> URLRequest {
        let url = URL(string: url)!
        let request = URLRequest(url: url)
        return request
    }
    
}
