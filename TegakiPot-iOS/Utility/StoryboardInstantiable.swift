// 拝借

import UIKit

// MARK: - StoryboardInstantiable
protocol StoryboardInstantiable {
    static var storyboardName: String { get }
}

extension StoryboardInstantiable {
    static func instantiateFromStoryboard() -> Self{
        let storyboard = UIStoryboard(name: self.storyboardName, bundle: nil)
        if let controller = storyboard.instantiateInitialViewController() as? Self {
            return controller
        }
        assert(false, "生成したいViewControllerと同じ名前のStorybaordが見つからないか、Initial ViewControllerに設定されていない可能性があります。")
    }
}
