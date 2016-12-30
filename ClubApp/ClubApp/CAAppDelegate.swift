import UIKit

@UIApplicationMain class CAAppDelegate: UIResponder, UIApplicationDelegate
{
    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool
    {
        UINavigationBar.appearance().barStyle = UIBarStyle.Black
        UITabBar.appearance().barStyle = UIBarStyle.Black
        UITabBar.appearance().tintColor = UIColor.redColor()
        UIScrollView.appearance().indicatorStyle = UIScrollViewIndicatorStyle.Black
        CASettingsView.initialize()

        return true
    }
}

class CATabBarController: UITabBarController, UITabBarControllerDelegate
{
    static let lightItemTitle = "Settings"

    override func prefersStatusBarHidden() -> Bool
    {
        return (self.selectedViewController?.prefersStatusBarHidden() ?? super.prefersStatusBarHidden())
    }

    override func preferredStatusBarStyle() -> UIStatusBarStyle
    {
        return (self.selectedViewController?.preferredStatusBarStyle() ?? super.preferredStatusBarStyle())
    }

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?)
    {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.delegate = self
    }

    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        self.delegate = self
    }

    func tabBarController(tabBarController: UITabBarController, didSelectViewController viewController: UIViewController)
    {
        let vc = viewController as! UINavigationController

        if (vc.title == CATabBarController.lightItemTitle) {
            tabBarController.tabBar.barStyle = UIBarStyle.Default
            vc.navigationBar.barStyle = UIBarStyle.Default
            tabBarController.tabBar.tintColor = UIColor.orangeColor()
        } else {
            tabBarController.tabBar.barStyle = UIBarStyle.Black
            tabBarController.tabBar.tintColor = UIColor.redColor()

        }
    }
}
