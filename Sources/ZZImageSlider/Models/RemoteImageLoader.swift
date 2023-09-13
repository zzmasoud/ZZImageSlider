//
//  Copyright © zzmasoud (github.com/zzmasoud).
//  

import UIKit

public final class RemoteImageLoader: ImageLoader {
    public typealias URLFetch = (_ id: String) -> URL
    private let session: URLSession
    private let urlFetcher: URLFetch?
    
    public enum Error: Swift.Error {
        case invalidImageData, invalidURL
    }
    
    public init(session: URLSession, urlFetcher: URLFetch?) {
        self.session = session
        self.urlFetcher = urlFetcher
    }
    
    public func load(id: String) async throws -> UIImage {
        guard let url = self.urlFetcher?(id) ?? URL(string: id) else { throw Error.invalidURL }
        let (data, _) = try await session.data(from: url)
        guard let image = UIImage(data: data) else { throw Error.invalidImageData }
        return image
    }
}
