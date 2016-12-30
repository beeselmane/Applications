import UIKit

class CASettingsView: UITableView
{
    func ginit() {
        self.backgroundColor = UIColor(colorLiteralRed: 239.0 / 255.0, green: 239.0 / 255.0, blue: 244.0 / 255.0, alpha: 1.0)
    }

    override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame, style: style)
        self.ginit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.ginit()
    }
}
