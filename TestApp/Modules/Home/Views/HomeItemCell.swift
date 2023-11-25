import UIKit

private extension HomeItemCell {
    struct Appearance {
        let titleColor = UIColor.black
        let verticalInset: CGFloat = 5
        let sideInset: CGFloat = 10
        let size = CGSize(width: 50, height: 50)
        let cornerRadius: CGFloat = 25
    }
}

public final class HomeItemCell: UITableViewCell {
    
    private let appearance = Appearance()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = appearance.titleColor
        return label
    }()
    
    private lazy var previewImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    private lazy var isFavoriteImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "star.fill")
        imageView.tintColor = .systemYellow
        imageView.isHidden = true
        return imageView
    }()
    
    private lazy var arrowImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "star.fill")
        imageView.tintColor = .systemYellow
        imageView.isHidden = true
        return imageView
    }()
    
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.addSubviews()
        self.makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(item: HomeItemModel) {
        titleLabel.text = item.name
        previewImageView.image = UIImage(named: item.imageName)
        if item.isFavorite {
            isFavoriteImageView.isHidden = false
        } else {
            isFavoriteImageView.isHidden = true
        }
        accessoryType = .disclosureIndicator
    }
    
    private func addSubviews() {
        addSubview(titleLabel)
        addSubview(previewImageView)
        addSubview(isFavoriteImageView)
    }
    
    private func makeConstraints() {
        previewImageView.snp.makeConstraints { make in
            make.size.equalTo(appearance.size)
            make.top.bottom.equalToSuperview().inset(appearance.verticalInset)
            make.leading.equalToSuperview().inset(appearance.sideInset * 2)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(previewImageView.snp.trailing).offset(appearance.sideInset)
            make.trailing.equalToSuperview().inset(appearance.sideInset)
            make.centerY.equalToSuperview()
        }
        
        isFavoriteImageView.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(appearance.sideInset * 4)
            make.centerY.equalToSuperview()
        }
    }
}

