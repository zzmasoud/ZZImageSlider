//
//  Copyright © zzmasoud (github.com/zzmasoud).
//  

import UIKit

public protocol ImageLoader {
    func load(id: String) async throws -> UIImage
}
