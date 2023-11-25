import UIKit
import SnapKit

public protocol SwitcherDelegate: AnyObject {
    func switchDidChanged(value: Bool)
}

private extension HomeFavourCell {
    struct Appearance {
        let titleColor = UIColor.black
        let verticalInset: CGFloat = 5
        let sideInset: CGFloat = 20
    }
}

public final class HomeFavourCell: UITableViewCell {
    private let titleLabel = UILabel()
    private let switchView = UISwitch()
    private let appearance = Appearance()
    private weak var delegate: SwitcherDelegate?
    
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubviews()
        makeConstraints()
        addTargetToSwitchView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubviews() {
        addSubview(titleLabel)
    }
    
    private func makeConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(appearance.sideInset)
            make.centerY.equalToSuperview()
        }
        accessoryView = switchView
    }
    
    private func addTargetToSwitchView() {
        switchView.addTarget(self, action: #selector(switchAction), for: .valueChanged)
    }
    
    @objc func switchAction() {
        switchView.isOn ? delegate?.switchDidChanged(value: true) : delegate?.switchDidChanged(value: false)
    }
    
    public func configure(delegate: SwitcherDelegate) {
        titleLabel.text = "Favorites only"
        self.delegate = delegate
    }
}

