//
//  APIClient.swift
//  CartixIOS
//
//  Created by Tiago Laim Rodrigues on 31/10/2026.
//

import Foundation

class APIClient {
    // Create a Singleton
    static let shared = APIClient()
    
    private init() {}
    
    func request<T: Decodable>(_ endpoint: APIEndpoint) async throws -> T {
        var request = URLRequest(url: endpoint.url)
        request.httpMethod = endpoint.method
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        //TODO: Inject JWT auth token here
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
            throw URLError(.badServerResponse)
        }
        
        return try JSONDecoder().decode(T.self, from: data)
    }
}
