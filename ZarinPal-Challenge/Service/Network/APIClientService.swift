//
//  APIClientService.swift
//  ZarinPal-Challenge
//
//  Created by Farshad Mousalou on 6/17/20.
//  Copyright © 2020 Farshad Mousalou. All rights reserved.
//

import Foundation
import RxSwift
import RxAlamofire
import Alamofire

private let queueName = "com.ifarshad.zarinpal-challenge.network.queue"

fileprivate extension DispatchQueue {
    
    /// <#Description#>
    static let networkResponseQueue = DispatchQueue(label: queueName, qos: .background, attributes: .concurrent, autoreleaseFrequency: .workItem)
}


final class APIClient: NetworkServiceInterceptable {
    
    
    typealias SessionManager = Session
    
    static let `default` = APIClient(decoder: {
        var decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        return decoder
    }())
    
    static var instance : APIClient {
        return APIClient(baseURL: AppConfig.baseURL,
                         session: SessionManager(),
                         queue: .networkResponseQueue,
                         decoder: {
                            let decoder = JSONDecoder()
                            decoder.dateDecodingStrategy = .iso8601
                            return decoder
        }())
    }
    
    /// <#Description#>
    let baseURL: URL
    
    /// <#Description#>
    private(set) var session: SessionManager
    
    /// <#Description#>
    let workQueue: DispatchQueue
    
    private var interceptor: RequestInterceptor?
    
    let decoder: DataDecoder
    
    /// <#Description#>
    ///
    /// - Parameters:
    ///   - baseURL: <#baseURL description#>
    ///   - session: <#session description#>
    ///   - queue: <#queue description#>
    init(baseURL: URL = AppConfig.baseURL,
         session: SessionManager = .default,
         queue: DispatchQueue = .networkResponseQueue,
         decoder: @autoclosure () -> DataDecoder) {
        self.baseURL = baseURL
        self.session = session
        self.workQueue = queue
        self.decoder = decoder()
        
    }
    
    func addingRequest(interceptor: RequestInterceptor) {
        let locker = NSLock()
        locker.lock()
        defer {
            locker.unlock()
        }
        
        self.interceptor = interceptor
    }
    
    func executeRequest<T>(endpoint: INetworkServiceEndpoint,
                           query: IGraphQLQueryRequest,
                           headers: NetworkHeadersType) -> Observable<Result<T, Error>> where T : Decodable {
        
        let httpBody = query.query.data(using: .utf8, allowLossyConversion: false)
        
        let dataRequest = session.request(attachBaseURL(into: endpoint),
                                          method: .post,
                                          headers: HTTPHeaders(headers),
                                          interceptor: interceptor,
                                          requestModifier: { (request) in
                                            request.httpBody = httpBody
        })
            .validate()
        
        return map(dataRequest: dataRequest, decoder: decoder)
    }
    
    func executeRequest<T>(endpoint: INetworkServiceEndpoint,
                           parameters: Parameters,
                           method: HTTPMethod,
                           headers: NetworkHeadersType) -> Observable<Result<T, Error>> where T : Decodable {
        
        let headers = headers.compactMap { HTTPHeader(name: $0.key, value: $0.value) }
        let dataRequest = session.request(attachBaseURL(into: endpoint),
                                          method: method,
                                          parameters: parameters,
                                          headers: HTTPHeaders(headers),
                                          interceptor: interceptor)
            .validate()
        
        return map(dataRequest: dataRequest, decoder: decoder)
    }
    
    func executeRequest<T, P>(endpoint: INetworkServiceEndpoint,
                               parameter: P,
                               headers: NetworkHeadersType) -> Observable<Result<T, Error>> where T : Decodable, P : Encodable {
        
        let headers = headers.compactMap { HTTPHeader(name: $0.key, value: $0.value) }
               let dataRequest = session.request(attachBaseURL(into: endpoint),
                                                 method: .post,
                                                 parameters: parameter,
                                                 encoder: JSONParameterEncoder.default,
                                                 headers: HTTPHeaders(headers),
                                                 interceptor: interceptor)
                   .validate()
               
               return map(dataRequest: dataRequest, decoder: decoder)
    }
    
    /// <#Description#>
    /// - Parameter endpoint: <#endpoint description#>
    private func attachBaseURL(into endpoint: INetworkServiceEndpoint) -> URLConvertible {
        guard let endpointURL = URL(string: endpoint.path, relativeTo: baseURL) else {
            return ""
        }
        
        return endpointURL
    }
    
    /// <#Description#>
    /// - Parameters:
    ///   - dataRequest: <#dataRequest description#>
    ///   - decoder: <#decoder description#>
    private func map<T: Decodable> (dataRequest: DataRequest, decoder: DataDecoder) -> Observable<Result<T, Error>> {
        dataRequest.rx.decodable(decoder: decoder)
            .map { value in
                return Result<T,Error> { value }
        }.catchError { (error) -> Observable<Result<T, Error>> in
            .just(.failure(error))
        }
    }
    
}
